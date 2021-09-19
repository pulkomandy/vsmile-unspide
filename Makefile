#####################################################################
#																	 
#	Created by u'nSP IDE V4.0.0		22:02:31	09/19/21
#
#####################################################################




PRJDIR	= C:\Users\pulkomandy\Documents\VTech_Hello

APPDIR	= C:\PROGRA~1\GENERA~1\UNSPID~1.0

OUTDIR	= .\Debug

MK	= $(APPDIR)\make

CC	= $(APPDIR)\toolchain\gcc

AS	= $(APPDIR)\toolchain\xasm16

LD	= $(APPDIR)\toolchain\xlink16

AR	= $(APPDIR)\toolchain\xlib16

RESC	= $(APPDIR)\toolchain\resc

BHPCK	= $(APPDIR)\toolchain\BootPacker

RM	= del	/F	1>NUL	2>NUL

STRIP	= $(APPDIR)\toolchain\stripper

S37STRIP	= $(APPDIR)\toolchain\BinaryFileStripper

RD	= rd /S /Q

BOOTPACKER	= $(APPDIR)\toolchain\BootPacker 

LIKMODIFIER	= $(APPDIR)\toolchain\unSP_LIKModifier 

INCLUDES	= -I"C:/Users/pulkomandy/Documents/VTech_Hello" -I"C:/Program Files/Generalplus/unSPIDE 4.0.0/library/include" -I"C:/Program Files/Generalplus/unSPIDE 4.0.0/library/include/sys"

BODY	= -body SPG200CartG -nobdy -bfile "C:\Users\pulkomandy\Documents\VTech_Hello\VTech_Hello.bdy"

BODYFILE	= "C:\Users\pulkomandy\Documents\VTech_Hello\VTech_Hello.bdy" 

BINFILE	= "$(OUTDIR)\VTech_Hello.TSK"

BINFILENOEXT	= $(OUTDIR)\VTech_Hello

ARYFILE	= "$(OUTDIR)\VTech_Hello.ary"

SBMFILE	= "$(OUTDIR)\VTech_Hello.sbm"

OPT	= -S -gstabs -Wall -mglobal-var-iram

ASFLAGS	= -t2 -d -sr

CASFLAGS	= -t2 -sr -wpop

CFLAGS	= $(OPT) -B$(APPDIR)\toolchain\ $(INCLUDES) 

BINTYPE	= -at

LDFLAGS	=  -blank 0x00

EXTRAFLAGS	= 


OBJFILES	= \
	"$(OUTDIR)\font_bin.res" \
	"$(OUTDIR)\main.obj" \
	"$(OUTDIR)\isr.obj" \
	"$(OUTDIR)\Resource.obj" 

"$(OUTDIR)\font_bin.res": "C:\Users\pulkomandy\Documents\VTech_Hello\font.bin"
	$(RESC) "C:\Users\pulkomandy\Documents\VTech_Hello\font.bin" "$(OUTDIR)\font_bin.res" RES_FONT_BIN 

"$(OUTDIR)\main.asm": "C:\Users\pulkomandy\Documents\VTech_Hello\main.c" ".\Resource.h" 
	set PATH="$(APPDIR)\toolchain\";%PATH% & \
	$(CC) $(CFLAGS) -o "$(OUTDIR)\main.asm" "C:/Users/pulkomandy/Documents/VTech_Hello/main.c" 

"$(OUTDIR)\main.obj": "$(OUTDIR)\main.asm"
	$(AS) $(CASFLAGS) $(INCLUDES) -o "$(OUTDIR)\main.obj" "$(OUTDIR)\main.asm" 

"$(OUTDIR)\isr.obj": "C:\Users\pulkomandy\Documents\VTech_Hello\isr.asm" 
	$(AS) $(ASFLAGS) $(INCLUDES) -o "$(OUTDIR)\isr.obj" "C:\Users\pulkomandy\Documents\VTech_Hello\isr.asm" 

"$(OUTDIR)\Resource.obj": "C:\Users\pulkomandy\Documents\VTech_Hello\Resource.asm" 
	$(AS) $(ASFLAGS) $(INCLUDES) -o "$(OUTDIR)\Resource.obj" "C:\Users\pulkomandy\Documents\VTech_Hello\Resource.asm" 


.SUFFIXES : .c .asm .obj .s37 .tsk .res

all :	 BEFOREBUILD "$(OUTDIR)" $(BINFILE)

BEFOREBUILD :

"$(OUTDIR)" :
	if not exist "$(OUTDIR)\$(NULL)" mkdir "$(OUTDIR)"

$(BINFILE) : $(OBJFILES) 
	$(LD) $(BINTYPE) $(ARYFILE) $(BINFILE) $(LDFLAGS) $(BODY) $(EXTRAFLAGS) -undefined-opt __TgP190708CM -undefined-opt __TgP190708CL -undefined-opt __TgP190708M

compile :	 $(OBJFILES)

CLEANFILES = \
	"$(OUTDIR)\font_bin.res" \
	"$(OUTDIR)\main.obj" \
	"$(OUTDIR)\main.lst" \
	"$(OUTDIR)\main.asm" \
	"$(OUTDIR)\isr.obj" \
	"$(OUTDIR)\isr.lst" \
	"$(OUTDIR)\Resource.obj" \
	"$(OUTDIR)\Resource.lst" \
	"$(BINFILENOEXT).s37" "$(BINFILENOEXT).tsk" "$(BINFILENOEXT)_SPI.bin*" "$(BINFILENOEXT).hdb" "$(BINFILENOEXT).lod" "$(BINFILENOEXT).map" "$(BINFILENOEXT).sbm" "$(BINFILENOEXT).sym" "$(BINFILENOEXT).smy" \
	"$(SBMFILE)

clean :
	$(RM) $(wordlist 1,65536,$(CLEANFILES))

.c.asm:
	$(CC) $(CFLAGS) $(INCLUDES) -o "$(OUTDIR)\$@" $<

.asm.obj:
	$(AS) $(ASFLAGS) $(INCLUDES) -o "$(OUTDIR)\$@" $<

