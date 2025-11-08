DEFAULT_HOST=i386
HOST?=$(DEFAULT_HOST)
HOSTARCH!=../target-triplet-to-arch.sh $(HOST)

AS=i686-elf-as
CC=i686-elf-gcc

CFLAGS?=-O2 -g
CPPFLAGS?=
LDFLAGS?=
LIBS?=

CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_kernel -Iinclude
LDFLAGS:=$(LDFLAGS)
# LIBS:=$(LIBS) -nostdlib -lk -lgcc
LIBS:=$(LIBS) -nostdlib -lgcc -static 
# LIBK:=libc/libk.a

ARCHDIR=arch/$(HOSTARCH)
CROSSDIR=/home/kai/.bin/cross/bin/

include $(ARCHDIR)/make.config

# use musl
# LIBC=/home/kai/proj/OasisOS/sysroot/libc/libc.a

CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)

KERNEL_OBJS=\
$(KERNEL_ARCH_OBJS) \
kernel/kernel.o \

OBJS=\
$(ARCHDIR)/crti.o \
$(ARCHDIR)/crtbegin.o \
$(KERNEL_OBJS) \
$(ARCHDIR)/crtend.o \
$(ARCHDIR)/crtn.o \

LINK_LIST=\
$(LDFLAGS) \
$(ARCHDIR)/crti.o \
$(ARCHDIR)/crtbegin.o \
$(LIBS) \
$(ARCHDIR)/crtend.o \
$(ARCHDIR)/crtn.o \

.PHONY: all clean

crti.o: $(ARCHDIR)/x86_crti.s
	$(AS) $(ARCHDIR)/x86_crti.s -o $(ARCHDIR)/crti.o

crtn.o: $(ARCHDIR)/x86_crtn.s
	$(AS) $(ARCHDIR)/x86_crtn.s -o $(ARCHDIR)/crtn.o

crt0.o: $(ARCHDIR)/x86_crt0.s
	$(AS) $(ARCHDIR)/x86_crt0.s -o $(ARCHDIR)/crt0.o

$(ARCHDIR)/crtbegin.o $(ARCHDIR)/crtend.o:
	OBJ=`$(CC) $(CFLAGS) $(LDFLAGS) -print-file-name=$(@F)` && cp "$$OBJ" $@

boot.o: $(ARCHDIR)/boot.s
	$(AS) $(ARCHDIR)/boot.s -o $(ARCHDIR)/boot.o

linix.kernel: $(OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) \
	$(LINK_LIST) $(KERNEL_ARCH_OBJS)
	grub-file --is-x86-multiboot linix.kernel

$(ARCHDIR)/tty.c: 

kernel: kernel/kernel.c $(ARCHDIR)/tty.c $(ARCHDIR)/vga.h include/tty.h
	$(CC) kernel/kernel.c $(LIBK) -o kernel.o $(CFLAGS)
# $(CC) kernel/kernel.c $(LIBK) -o kernel.o $(CFLAGS)

# all: boot.o crt0.o crtn.o crti.o kernel linix.kernel
all: boot.o crt0.o crtn.o crti.o linix.kernel kernel

clean:
	rm -f linix.bin
	rm -f $(OBJS) *.o */*.o */*/*.o
	rm -f $(OBJS:.o=.d) *.d */*.d */*/*.d