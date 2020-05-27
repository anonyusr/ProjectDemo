####################dirs####################
TOPDIR := $(PWD)
BINDIR := $(TOPDIR)/bin
INCDIR := $(TOPDIR)/inc
SRCDIR := $(TOPDIR)/src
OBJDIR := $(TOPDIR)/obj

VPATH := $(INCDIR):$(SRCDIR):$(OBJDIR)

LIBDIR := $(TOPDIR)/lib
SHARELIBDIR := $(LIBDIR)/sharelib
STATICLIBDIR := $(LIBDIR)/staticlib

###################defines###################
OUTPUT = main.out
LIBNAME = function

####################libs####################
LIB = lib
SHARELIBNAME = $(SHARELIBDIR)/$(LIB)$(LIBNAME).so
STATICLIBNAME = $(STATICLIBDIR)/$(LIB)$(LIBNAME).a

####################args####################
#DEBUGFLAG = -g
IFLAG = -I $(INCDIR)
SHAREFLAG = -shared
FPICFLAG = -fpic
LlSHAREFLAG = -L $(SHARELIBDIR) -l $(LIBNAME)
LlSTATICFLAG = -L $(STATICLIBDIR) -l $(LIBNAME)

####################tools####################
CC = gcc
AR = ar -rcs

TARGET=$(BINDIR)/$(OUTPUT)

SRC=$(wildcard $(SRCDIR)/*.c)
OBJ=$(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRC))

$(TARGET):$(OBJ)
	$(CC) $(IFLAG) $(DEBUGFLAG) -o $(TARGET) $(OBJ)

$(OBJDIR)/%.o:$(SRCDIR)/%.c
	$(CC) $(IFLAG) $(DEBUGFLAG) -c $< -o $@

all:
	@echo "run 'make' to creat target flie."
	@echo "run 'make share' to creat target flie with sharelib."
	@echo "run 'make static' to create target flie with staticlib."
	@echo "run 'make install' to get command for export sharelib path."
	@echo "run 'make clean' to clean."

.PHONY:share
share:
	make -f share

.PHONY:static
static:
	make -f static

install:
	@echo "==========copy and run follow command to export sharelib path========="
	export LD_LIBRARY_PATH=$(SHARELIBDIR)
	@echo "or"
	export LD_LIBRARY_PATH=./lib/sharelib
clean:
	rm $(BINDIR)/* -f
	rm $(OBJDIR)/* -f
	rm $(SHARELIBDIR)/* -f
	rm $(STATICLIBDIR)/* -f
