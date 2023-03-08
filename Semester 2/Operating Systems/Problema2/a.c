
	
//Scrieti 2 programe c, A si B. Programul A va citi doua numare intregi
//de la tastatura si va scrie intr-un fifo cel mai mic multiplu comun al
//acestora. Programul B va creea 2 procese P1 si P2, P1 va citi multiplul
//din fifo-ul mentionat anterior si va calcula divizorii acestuia.
//Divizorii vor fi transmis printr-un pipe procesului P2 care ii va afisa
//pe ecran.
//Numele fifo-ului va fi dat ca argument in linia de comanda in ambele
//programe. Programul A va creea fifo-ul si programul B va sterge fifo-ul.
//Ambele programe terbuie compilate cu gcc -Wall -g fara erori sau warninguri.
//Ambele programe trebuie sa ruleze fara memory leaks, erori de context sau
//procese zombie.

int main(int argc,char** argv[])
{
	int a,b,ok=0,cmmmc;
	char *myfifo="/tmp/fifo2";
	mkfifo(myfifo,0666);
	printf("Introduceti cele 2 numere:");
	scanf("%d %d",&a,&b);
	if(a>b) cmmmc=a;
		else cmmmc=b;
	while(ok==0)
	{
	if(cmmmc%a==0 && cmmmc%b==0)
		ok=1;
	else cmmmc++;
	}
	printf("%d ",cmmmc);
	int fd=open(myfifo,O_WRONLY);
	if(fd==-1)
	{
		perror("Eroare la open():");
		exit(EXIT_FAILURE);
	}
	write(fd,&cmmmc,sizeof(int));
	close(fd);
	return 0;
}
