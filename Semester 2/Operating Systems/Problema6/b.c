#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/stat.h>
int main()
{
	int fd,v[5]={0};
	char *myfifo="/tmp/fifo1";
	mkfifo(myfifo,0666);
	fd=open(myfifo,O_RDONLY);
	if(fd==-1)
	{
		perror("open() error:");
		exit(EXIT_FAILURE);
	}
	for(int i=0; i<5; i++)
	{
	read(fd,&v[i],sizeof(int));
	printf("%d ",v[i]);
	}
	close(fd);
	//unlink(myfifo);
	return 0;
}
