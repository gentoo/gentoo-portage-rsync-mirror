all: pogo pogo-remote

pogo: pogo.c
	gcc ${CFLAGS} -o pogo pogo.c -Wall -I/usr/X11R6/include -I${DESTDIR}/usr/share/include -L/usr/X11R6/lib -L${DESTDIR}/usr/share/lib -lX11 -lXext -ljpeg -lz -lm -lImlib

pogo-remote: pogo-remote.c
	gcc ${CFLAGS} -o pogo-remote pogo-remote.c -Wall 

install: 
	mkdir -p ${DESTDIR}/usr/bin
	mkdir -p ${DESTDIR}/usr/share/pogo-2.2
	mkdir -p ${DESTDIR}/usr/share/pogo-2.2/images
	mkdir -p ${DESTDIR}/usr/share/pogo-2.2/scripts
	mkdir -p ${DESTDIR}/usr/share/pogo-2.2/configs

	cp images/*.jpg ${DESTDIR}/usr/share/pogo-2.2/images/
	cp scripts/*.pogo ${DESTDIR}/usr/share/pogo-2.2/scripts/
	cp configs/*.config ${DESTDIR}/usr/share/pogo-2.2/configs/

	cp pogo ${DESTDIR}/usr/bin/
	cp pogo-remote ${DESTDIR}/usr/bin

clean:
	rm -rf pogo
	rm -rf pogo-remote

