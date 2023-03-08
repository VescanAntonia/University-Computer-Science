#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
int main(int argc, char* argv[])
{
	char* myfifo="/tmp/fifo1";
	int fd=open(myfifo,O_RDONLY);
	int suma;
	read(fd,&suma,sizeof(int));
	printf("Suma este %d\n",suma);
	close(fd);
	unlink("/tmp/fifo1");
	return 0;
}
