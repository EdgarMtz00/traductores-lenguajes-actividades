#include "stdio.h"

int main(int argc,char* argv[]) {
    FILE *fp = fopen("listas.txt","wb");
    if(fp == NULL) {
        printf("error creating file");
        return -1;
    }
    int val[] = {140, 317, 11700, 1510, 209, 901, 111, 13, 10, 500, 240, 11, 960, 77, 6, 10};
    for (int i = 0; i < 16; i++) {
        fwrite(&val[i], sizeof val, 1, fp);
    }
    fclose(fp);
    return 0;
}