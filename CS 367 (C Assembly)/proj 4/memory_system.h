#define OFFSET_BITS 8
#define PPN_BITS 9   // using 17 bit physical addresses
#define VPN_BITS 7   // using 15 bit virtual addresses

//   For the logging system
#define NEW_ADDRESS 0
#define ADDRESS_FROM_TLB 1
#define ADDRESS_FROM_PAGETABLE 2
#define DATA_FROM_CACHE 3
#define DATA_FROM_MEMORY 4
#define ILLEGALVIRTUAL 5
#define PHYSICALERROR 6
#define ILLEGALVPN 7




