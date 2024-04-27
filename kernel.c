void main();
void printc(char b);
void prints(char *c);
void exits();
void cls();
int video=0xb8000;
void main(){
       char *c="hello world...";
       video=0xb8000;
       cls();
       prints(c);
       exits();

}
void printc(char b)
        {
        int i=video;
	char *fbp=(char* )i;
	*((char *)(fbp)) =(char)b;
	*((char *)(fbp+1)) =(char)0x67;
	video++;
	video++;  
        }

void prints(char *c)
{
        int counter=0;
	while(c[counter]!=0){
		printc(c[counter]);
		counter++;
	}
}
void exits(){
    halts:
    goto halts;
    
}
void cls(){

char *dest=(char* )0xb8000;
int i=0;
int length=4000;
unsigned int value=0x67;
    // Cast o ponteiro para unsigned char* para permitir o preenchimento byte a byte
    unsigned char *d = (unsigned char *)dest;

    // Preencha os bytes da memória com o valor especificado
    for (i = 0; i < length; i=i+2) {
        d[i] = 32;
        d[i+1] = value;
    }
}
