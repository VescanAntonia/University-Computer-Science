#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
int main(int argc,char* argv[])
{
	//char *myfifo=argv[1];
	//char *myfifo="/tmp/fifo1";
	//mkfifo(myfifo,0666);
	int fd,cifra,lungime=0;
	int suma=0,p[2];
	pipe(p);
	int pid=fork();
	if(pid==-1)
	{
		printf("Error on fork();");
		exit(EXIT_FAILURE);
	}
	if(pid==0)
	{
		fd=open(argv[1],O_RDONLY);
		if(fd==-1)
		{
			perror("open() error:");
			exit(EXIT_FAILURE);
		}
		read(fd,&lungime,sizeof(int));
		printf("%d\n",lungime);
		while(read(fd,&cifra,sizeof(int)))
		suma=suma+cifra;
		printf("Suma este: %d\n",suma);
		close(fd);
		write(p[1],&suma,sizeof(int));
		close(p[1]);
		exit(0); 
	}	
	else 
	{
	pid=fork();
	if(pid==0)
		{
		read(p[0],&suma,sizeof(int));
		int d=2,nr=suma;
		if (suma>=1)
			printf("1 ");
		else 
			printf("Nu avem niciun divizor");
		while(suma>1)
		{
			if(suma%d==0)
			printf("%d ",d);
			while(suma%d==0)
			suma=suma/d;
			d++;
		}
		printf("%d ",nr);
		}
	}
	wait(0);
	wait(0);
	//close(fd);
	close(p[0]);
	unlink(argv[1]);
	exit(0);
	return 0;
}
