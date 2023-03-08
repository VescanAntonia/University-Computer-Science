#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
int main(int argc, char* argv[])
{
	int p[2];
	pipe(p);
	if(fork()==0)
	{	
		int n,nr,suma=0;
		char *myfifo="/tmp/fifo5";
		int fd=open(myfifo,O_RDONLY);
		read(fd,&nr,sizeof(int));
		int i;
		for(i=1; i<=nr; i++)
		{
			read(fd,&n,sizeof(int));
			suma=suma+n;
		}
		write(p[1],&suma,sizeof(int));
		close(fd);
		close(p[1]);
		exit(0);
	}
	wait(0);
	if(fork()==0)
	{
		int sum;
		read(p[0],&sum,sizeof(int));
		printf("Suma este: %d",sum);
		close(p[0]);
		exit(0);
	}
	wait(0);
	close(p[0]);
	close(p[1]);
	unlink("/tmp/fifo5");
	return 0;
}
