CC	= arm-linux-gnueabihf-gcc
CFLAGS	= -O0 -Wall
LDFLAGS = -fno-stack-protector -lrt

objects	= gcd.o get_gcd.o

default: gcd

.PHONY: default clean qemu

gcd: $(objects)
	$(CC) $(LDFLAGS) -o $@ $^

get_gcd.o: get_gcd.c
gcd.o: gcd.c

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o: %.s
	$(CC) -c $(CFLAGS) -o $@ $<

clean:
	rm -f $(objects) gcd result.txt

QEMU_CMD = qemu-arm -L /usr/arm-linux-gnueabihf ./gcd
qemu: gcd
	$(call QEMU_CMD)