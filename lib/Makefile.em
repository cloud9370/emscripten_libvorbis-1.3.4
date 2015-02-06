CC=emcc
CFLAGS=-DHAVE_CONFIG_H -I. -I.. -I../include -I../../libogg-1.3.2/include -O2 -Wall -Wextra -ffast-math -D_REENTRANT -fsigned-char -Wdeclaration-after-statement -DUSE_MEMORY_H

CXX=em++
CXXFLAGS=$(CFLAGS)

VORBISOBJS=mdct.o smallft.o block.o envelope.o window.o \
	lsp.o lpc.o analysis.o synthesis.o psy.o \
	info.o floor1.o floor0.o res0.o mapping0.o \
	registry.o codebook.o sharedbook.o lookup.o bitrate.o

VORBISFILEOBJS=vorbisfile.o

VORBISENCOBJS=vorbisenc.o

VORBISLIB=libvorbis.a
VORBISFILELIB=libvorbisfile.a
VORBISENCLIB=libvorbisenc.a

LDFLAGS=

.PHONY: all clean

all: $(VORBISLIB) $(VORBISFILELIB) $(VORBISENCLIB)

%.o:%.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(VORBISLIB): $(VORBISOBJS)
	emar cru $@ $(VORBISOBJS) $(LDFLAGS)
	emranlib $@

$(VORBISFILELIB): $(VORBISFILEOBJS)
	emar cru $@ $(VORBISFILEOBJS) $(LDFLAGS)
	emranlib $@

$(VORBISENCLIB): $(VORBISENCOBJS)
	emar cru $@ $(VORBISENCOBJS) $(LDFLAGS)
	emranlib $@

clean:
	rm -f $(VORBISENCLIB)
	rm -f $(VORBISENCOBJS)
	rm -f $(VORBISFILELIB)
	rm -f $(VORBISFILEOBJS)
	rm -f $(VORBISLIB)
	rm -f $(VORBISOBJS)
