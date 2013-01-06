src = xwit.c dsimple.c ClientWin.c
o = $(addsuffix .o,$(basename ${src}))

all: xwit

%.o: %.cpp
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

xwit: $(o)
	$(CC) $(LDFLAGS) $(o) -o xwit -lX11
