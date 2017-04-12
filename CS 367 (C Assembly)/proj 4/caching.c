#include <stdio.h>
#include <stdlib.h>
#include "memory_system.h"
typedef struct Cach{
        int data;
        int valid;
        int age;
        int tag;
}cachItem;
static cachItem cachloc[32][2];
static int tlb[8];
	
initialize() {
//make tlb & cache
	int i,p;
	for(i=0; i<8; i++){
		tlb[i]=0;//i<<14;index it all dont need
	}
	for(p=0; p<32; p++){
		for(i=0; i<2; i++){
                	cachloc[p][i].data=0;
			cachloc[p][i].valid=0;
			cachloc[p][i].age=0;
			cachloc[p][i].tag=0;
		}
        }
}

int
get_physical_address(int virt_address) {
	int phys_address;
	int temp= virt_address>>15;
	if(temp>0){log_entry(ILLEGALVIRTUAL,virt_address); return -1;}
	//convert
	int vpn= virt_address>>8; //first 7
	int vpo=virt_address & 255; //last 8
	int vtag=vpn>>3;//first 4
	int vindex=vpn & 7;//remaing 3
	//check tlb, index, tag, validity
	int tlbloc=tlb[vindex];
	int ppn;
	if(tlbloc>>10==vtag){
		if(((tlbloc>>9)&1)==1){ //valid
			ppn=tlbloc&511;
			phys_address=(ppn<<8)|vpo;
        		log_entry(ADDRESS_FROM_TLB,phys_address);
		}
		else{//invalid, tag right
			ppn = get_page_table_entry(vpn);
			tlb[vindex]=(tlbloc|512)|ppn;
			phys_address=(ppn<<8)|vpo;
        		log_entry(ADDRESS_FROM_PAGETABLE,phys_address);
		}
	}
	else{//tag wrong
		ppn = get_page_table_entry(vpn);
		tlb[vindex]=vtag<<10|512|ppn;
		phys_address=(ppn<<8)|vpo;	
		log_entry(ADDRESS_FROM_PAGETABLE,phys_address);
	}
	return phys_address;
}



get_byte(int phys_address) {
	int byte;
	int tag=phys_address>>7;
	int index=((31<<2)&phys_address)>>2;	
	int bloc= phys_address&3;
	int fixbloc=abs(bloc-3)*8;
	fixbloc=bloc*8;
	int moveVal=255<<fixbloc;
       	//first 10 is tag, next valid bit, next oldest bit, 4 bytes data
	if(cachloc[index][0].tag==tag && cachloc[index][1].tag !=tag){
                if(cachloc[index][0].valid==1){ //vali
			byte=(cachloc[index][0].data & moveVal)>>(fixbloc);
                        log_entry(DATA_FROM_CACHE,byte);
                }
                //if wont happen if invalid because if invalid both are 0
        }
	//valid 
        else if(cachloc[index][1].tag==tag && cachloc[index][0].tag !=tag){//2nd place check
		if(cachloc[index][1].valid==1){ //valid
                        byte=(cachloc[index][1].data & moveVal)>>(fixbloc);
                        log_entry(DATA_FROM_CACHE,byte);
		}
		//first valid 2nd invalid but right tag(0), grab and put in 2nd
		else{
			byte=get_long_word(phys_address);
			cachloc[index][1].data=byte;
			cachloc[index][1].age=1;
                        cachloc[index][0].age=0;
			cachloc[index][1].valid=1;
                        byte=(cachloc[index][1].data & moveVal)>>(fixbloc);				log_entry(DATA_FROM_MEMORY,byte);
		}
	}
	//both invalid
	else if(cachloc[index][0].valid==0){
		byte=get_long_word(phys_address);
		cachloc[index][0].tag=tag;
                cachloc[index][0].data=byte;
                cachloc[index][0].age=1;
                cachloc[index][0].valid=1;
                byte=(byte&moveVal)>>(fixbloc);
		log_entry(DATA_FROM_MEMORY,byte);
	}
	//2nd invalid but miss both	
	else if(cachloc[index][1].valid==0){
		byte=get_long_word(phys_address);
                cachloc[index][1].data=byte;
                cachloc[index][1].age=1;
                cachloc[index][1].valid=1;
		cachloc[index][1].tag=tag;
                cachloc[index][0].age=0;
                byte=(byte&moveVal)>>(fixbloc);
		log_entry(DATA_FROM_MEMORY,byte);
	}
	//else missed both and no invalid
	else{
		//which is older
		int old;
		if(cachloc[index][0].age==0){old=0;}
		else{old=1;}
		//replace old
		byte=get_long_word(phys_address);
		cachloc[index][old].data=byte;
		cachloc[index][old].age=1;//make new
		cachloc[index][old].tag=tag;//append tag
                cachloc[index][!old].age=0;
                byte=(byte&moveVal)>>(fixbloc);
		log_entry(DATA_FROM_MEMORY,byte);	
	}		
	return byte;
}

