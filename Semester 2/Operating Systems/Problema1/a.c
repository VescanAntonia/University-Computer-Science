ar
	
//Scrieti 2 programe c, A si B. Programul A va citi de la tastatura un nume de
//fisier. Programul A va citi din fisier si va scrie in fifo toate cifrele din
//fisier.
//Probramul B va creea 2 procese P1 si P2. P1 va citi cifrele din fifo-ul
//mentionat anterior si va calcula suma acestora, pe care o va trimite prin
//pipe catre P2, care va afisa pe ecran divizorii numarului acestuia.
//Numele fifo-ului va fi dat ca argument in linia de comanda in ambele
//programe. Programul A va creea fifo-ul si programul B va sterge fifo-ul.
//Ambele programe terbuie compilate cu gcc -Wall -g fara erori sau warninguri.
//Ambele programe trebuie sa ruleze fara memory leaks, erori de context sau
//procese zombie.

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
int main(int argc,char** argv[]) 
{
	char nume_fisier[101];
	char c;
	//char *myfifo=argv[1];
	//char *myfifo="/tmp/fifo1";
	//mkfifo(myfifo,0666);
	int res=mkfifo(argv[1],0666);
	if(res==-1)
	{
		perror("mkfifo() error");
		exit(EXIT_FAILURE);
	}
	int fd=open(argv[1],O_WRONLY);
	if(fd==-1)
	{
		perror("open() error:");
		exit(EXIT_FAILURE);
	}
	scanf("%s",nume_fisier);
	int fisier,cifra,lungime=strlen(nume_fisier)+1;
	write(fd,&lungime,sizeof(int));
	fisier=open(nume_fisier,O_RDONLY);
	while(read(fisier,&c,sizeof(char)))
	{
		if(c>='0' && c<='9')
		{
		cifra=c-'0';
		write(fd,&cifra,sizeof(int));
		}
	}
	close(fd);
	wait(0);
	exit(0);
	return 0;
}
