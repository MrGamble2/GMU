#--------------------------------------------------------------------------
#Choose a compiler & its options
#--------------------------------------------------------------------------

CC   = gcc
OPTS = -W -O3

#--------------------------------------------------------------------------
# Add the debug flag (based on the #ifndef in the source files)
#--------------------------------------------------------------------------
#DEBUG=-D

#--------------------------------------------------------------------------
# Add the names of the directories
#--------------------------------------------------------------------------
SRCDIR=./src
OBJDIR=./obj
INCDIR=./include
BINDIR=./bin

#--------------------------------------------------------------------
# Add the rest of the source files. Don't forget to add the '\' character
# to continue the line. You don't need it after the last source file
#--------------------------------------------------------------------
SRCS=$(SRCDIR)/Lab9.c \
$(SRCDIR)/Function1.c \
$(SRCDIR)/Function2.c \
$(SRCDIR)/Function3.c \
$(SRCDIR)/Function4.c \
$(SRCDIR)/Function5.c

#--------------------------------------------------------------------
# You don't need to edit the next few lines. They define other flags
# used in the compilation of the source code
#--------------------------------------------------------------------
INCLUDE = $(addprefix -I,$(INCDIR))
OBJS=${SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o}
CFLAGS   = $(OPTS) $(INCLUDE) $(DEBUG)

#--------------------------------------------------------------------
# Add the name of the executable after the $(BINDIR)/
#--------------------------------------------------------------------
TARGET = $(BINDIR)/Lab9

all: $(TARGET)

$(TARGET): $(OBJS) 
	${CC} ${CFLAGS} -o $@ $(OBJS)

$(OBJS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@
clean:
	rm -f $(OBJS)
# --------------------------------------------------------------------
#  Add a target named cleanall that will remove the object files as well
#  as the executable
# --------------------------------------------------------------------
cleanall:
	rm -f $(OBJS) $(TARGET)
