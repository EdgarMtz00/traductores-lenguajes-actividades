cc=gcc
ens=nasm

trinomio_cuadrado: raiz2.o principal.o
	${cc} -g -no-pie -o trinomio_cuadrado principal.o raiz2.o 

raiz2.o: raiz2.s
	${ens} -g -felf64 raiz2.s

principal.o: principal.s
	${ens} -g -felf64 principal.s