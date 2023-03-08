

//Scrieti 2 programe c, A si B. Programul A va citi un numar intreg de la
//tastatura si va scrie intr-un fifo toti divizorii numarului citit. Programul
//B va crea 2 procese P1 si P2, P1 va citi divizorii din fifo-ul mentionat
//anterior si va calcula suma lor. Suma respectiva va fi transmis printr-un
//pipe procesului P2 care o va afisa pe ecran.
//Numele fifo-ului va fi dat ca argument in linia de comanda in ambele
//programe. Programul A va creea fifo-ul si programul B va sterge fifo-ul.
//Ambele programe terbuie compilate cu gcc -Wall -g fara erori sau warninguri.
//Ambele programe trebuie sa ruleze fara memory leaks, erori de context sau
//procese zombie.
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
int main(int argc, char* argv[])
{
	int i,n,nr=1;
	printf("Introduceti un numar:");
	scanf("%d",&n);
	if(n<0) n=abs(n);
	for(i=1; i<=n/2; i++)
	if(n%i==0) nr++;
	char *myfifo="/tmp/fifo5";
	mkfifo(myfifo,0666);
	int fd=open(myfifo,O_WRONLY);
	write(fd,&nr,sizeof(int));
	for(i=1; i<=n/2; i++)
	if(n%i==0) write(fd,&i,sizeof(int));
	write(fd,&n,sizeof(int));
	close(fd);
	return 0;
}
