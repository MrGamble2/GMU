#include <stdio.h>
#include <stdlib.h>
#define BYTETOBINARYPATTERN "%d%d%d%d%d%d%d%d"

#define BYTETOBINARY(byte)  \
  (byte & 0x80 ? 1 : 0), \
  (byte & 0x40 ? 1 : 0), \
  (byte & 0x20 ? 1 : 0), \
  (byte & 0x10 ? 1 : 0), \
  (byte & 0x08 ? 1 : 0), \
  (byte & 0x04 ? 1 : 0), \
  (byte & 0x02 ? 1 : 0), \
  (byte & 0x01 ? 1 : 0) 


#define PRINTBIN(x) printf(BYTETOBINARYPATTERN, BYTETOBINARY(x));

void setlsbs(unsigned char *p, unsigned char b0)
{
	int i;
	for(i=0;i<8;i++)
	{
		//lowest of p[i] replace wiht b0 ith bit
		int gj=0;
		int n;
		for(n=0;n<=i;n++)
		{
			gj=gj*2;
			if(gj==0)
			{
				gj=1;
			}
		}
		unsigned char c= gj;
		c= c & b0;
		c= c>>i;
		if(c==1)
		{
			p[i]=p[i] | c;
		}
		else
		{	
			c= 1;
			c= ~c;
			p[i]=p[i] & c;
		}
	}
	return;
}
unsigned char getlsbs(unsigned char *p)
{
	unsigned char f=0;
	int i;
	for(i=0;i<8; i++)
	{
		int gj=0;
                int n;
                /*for(n=0;n<=i;n++)
                {       
                        gj=gj*2;
                        if(gj==0)
                        {       
                                gj=1;
                        }
                }*/
		unsigned char c= 1;
		c=c & p[i];
		//shift c
		c= c<<i;		
		f= f | c;
	}
	return f;
}

void main(int argc, char* argv[])
{
	int i= atoi(argv[1]);
	srandom(i);
	unsigned char byte0;
	unsigned char *p;
	p=malloc(sizeof(unsigned char)*8);
	if(p==NULL)
	{
		printf("could not allocate memory for p\n");
		exit(0);
	}
	int n;
	printf("first p\n");
	for(n=0;n<8;n++)
	{
		p[n]=random()%256;
		printf("%d ", p[n]);PRINTBIN(p[n]);printf("\n");
	}
	byte0=random()%256;
	printf("first byte0\n");
	printf("%d ", byte0);PRINTBIN(byte0);printf("\n");
	setlsbs(p, byte0);
	printf("second p\n");
	for(n=0;n<8;n++)
	{	
		printf("%d ",p[n]);PRINTBIN(p[n]);printf("\n");
	}
	unsigned char news=getlsbs(p);
	printf("second byte0\n");
	printf("%d ",news);PRINTBIN(news);printf("\n");
	return;
}
	
