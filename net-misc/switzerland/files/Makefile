SRC = FastCollector.c
OBJ = ${SRC:.c=.o}

LIBS = -L/usr/lib -lpcap

CFLAGS ?=
LDFLAGS ?=

CC = gcc
LD = ${CC}

all: FastCollector

.c.o:
	${CC} -c ${CFLAGS} $<

FastCollector: ${OBJ}
	${LD} -o $@ ${CFLAGS} ${LDFLAGS} ${OBJ} ${LIBS}
