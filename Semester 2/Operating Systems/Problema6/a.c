#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>
int main(int argc, char** argv) {
        int p[2];
        char path[101];
        char* myfifo="/tmp/fifo1";
        mkfifo(myfifo,0666);
        pipe(p);
        if(fork()==0)
        {
                //procesul 1
                scanf("%s",path);       //fara & aici
                close(p[0]);
                int length=strlen(path)+1;
                write(p[1],&length,sizeof(int));
                write(p[1],path,strlen(path)*sizeof(char));
                close(p[1]);
                exit(0);
        }
        else
        {
                //procesul 2
		if(fork()==0)
		{
                char *result;
                //close(p[1]);
                char c;
                int size;
                int fd, v[5]={0};
                read(p[0],&size,sizeof(int));
                result=malloc(sizeof(char)*size);
                read(p[0],result,size*sizeof(char));
                result[size]=0;
                printf("%s\n",result);
                fd=open(result,O_RDONLY);
                while(read(fd,&c,sizeof(char)))
                {
                        if(c=='A') v[0]++;
                        else if(c=='E') v[1]++;
                        else if(c=='I') v[2]++;
                        else if(c=='O') v[3]++;
                        else if(c=='U') v[4]++;

                }
                free(result);
                close(p[0]);
                int i;
                //printf("DA\n");
                fd=open(myfifo,O_WRONLY);
                //printf("DA\n");
                for(i=0; i<5; i++)
                write(fd,&v[i],sizeof(int));
                close(fd);
                //printf("%d\n",v[i]);
                exit(0);
		}

        }
        close(p[0]);
        close(p[1]);
        wait(0);
        wait(0);
        return 0;
}


