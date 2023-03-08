#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <fcntl.h>
int main()
{
	char* myfifo="/tmp/fifo1";
	int fd=open(myfifo,O_RDONLY);
	char caracter;
	read(fd,&caracter,sizeof(char));
	int cod_ascii=(int)caracter;
	printf("Codul ASCII este %d",cod_ascii);
	unlink("/tmp/fifo1");
	return 0;
}
