#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
int main(int argc,char* argv[])
{
	int p[2];
	pipe(p);
	int pid=fork();
	if(pid==0)
	{
		//procesul 1
		char* myfifo="/tmp/fifo2";
		mkfifo(myfifo,0666);
		int fd=open(myfifo,O_RDONLY);
		if(fd==-1)
		{
			perror("Eroare la open():");
			exit(EXIT_FAILURE);
		}
		int i,nr_div=1,cmmmc=1;
		read(fd,&cmmmc,sizeof(int));
		for(i=1; i<=cmmmc/2; i++)
		if(cmmmc%i==0) nr_div++;
		write(p[1],&nr_div,sizeof(int));
		for(i=1; i<=cmmmc/2; i++)
		if(cmmmc%i==0) write(p[1],&i,sizeof(int));
		write(p[1],&cmmmc,sizeof(int));
		close(p[1]);
		close(fd);
		exit(0);
	}
	wait(0);
	pid=fork();
	if(pid==0)
	{	
		//procesul 2
		int i,div,nr;
		read(p[0],&nr,sizeof(int));
		for(i=1; i<=nr; i++)
		{
			read(p[0],&div,sizeof(int));
			printf("%d ",div);
		}
		close(p[0]);
		exit(0);
	}
	wait(0);
	close(p[0]);
	close(p[1]);
	unlink("/tmp/fifo1");
	return 0;
}
