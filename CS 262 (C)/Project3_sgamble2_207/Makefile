CC   = gcc
OPTS = -g -W -O3 

SRCDIR=./src
OBJDIR=./obj
INCDIR=./include
BINDIR=./bin

SRCS=$(SRCDIR)/project3_sgamble2_207.c \
$(SRCDIR)/set_sgamble2_207.c

INCLUDE = $(addprefix -I,$(INCDIR))
OBJS=${SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o}
CFLAGS   = $(OPTS) $(INCLUDE) $(DEBUG)

TARGET = $(BINDIR)/Project3_sgamble2_207

all: $(TARGET)

$(TARGET): $(OBJS)
	${CC} ${CFLAGS} -o $@ $(OBJS)

$(OBJS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@
clean:
	rm -f $(OBJS)

cleanall:
	rm -f $(OBJS) $(TARGET)
