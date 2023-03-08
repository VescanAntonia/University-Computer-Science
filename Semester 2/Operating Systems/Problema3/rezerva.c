#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
int main(int argc,char* argv[])
{
        int p[2];
        pipe(p);
        char *myfifo="/tmp/fifo1";
        mkfifo(myfifo,0666);
        if(fork()==0)
        {
                char nume_fisier[101];
                printf("Introduceti un nume de fisier existent:");
                scanf("%s",nume_fisier);
                FILE* path1;
                path1=fopen(nume_fisier,"r");
                //if(path1==-1)
                //{
                //      perror("Eroare la deschiderea fisierului");
                //      exit(EXIT_FAILURE);
                //}
                //else
                //{
                        int nr,n,sum=0;
                        printf("Introduceti un numar:");
                        scanf("%d",&n);
                        for(int i=1; i<=n; i++)
                        {
                        fscanf(path1,"%d",&nr);
                        printf("%d\n",nr);
                        sum=sum+nr;
                        }
                        int fd=open(myfifo,O_WRONLY);
                        write(fd,&sum,sizeof(int));
                        close(fd);
                //}
                fclose(path1);
                //close(fd);
                exit(0);
        }
        wait(0);
        close(p[0]);
        close(p[1]);
        return 0;
}
