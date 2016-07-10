CC := g++
CPPFLAGS := -W -Wall --ansi --pedantic -std=c++0x -fPIC -g
LDFLAGS := -shared

SRCDIR := src
DEPDIR := .deps
BUILDDIR := .build
DOCDIR := doc

INCPATH := -I$(SRCDIR)
LIBS	:= 

TARGET := hsm-lang-parser
INSTALL_PATH := /usr/include/hsm/lang/parser

SRC := $(shell find $(SRCDIR) -name '*.cpp')
HDR := $(shell find $(SRCDIR) -name '*.h')
DEP := $(SRC:$(SRCDIR)/%.cpp=$(DEPDIR)/%.P)
OBJ := $(SRC:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

################################################################################

all: release

release: lib$(TARGET).so

debug: lib$(TARGET)-debug.so

install:
	./install.sh $(SRCDIR) $(INSTALL_PATH)
	! test -s lib$(TARGET).so || cp -p lib$(TARGET).so /usr/lib
	! test -s lib$(TARGET)-debug.so || cp -p lib$(TARGET)-debug.so /usr/lib
	
uninstall:
	./uninstall.sh $(SRCDIR) $(INSTALL_PATH)
	rm -f /usr/lib/lib$(TARGET).so
	rm -f /usr/lib/lib$(TARGET)-debug.so

lib$(TARGET).so: $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

lib$(TARGET)-debug.so: $(OBJ)
	$(CC) $(LDFLAGS) -g -o $@ $^ $(LIBS)

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(@D)
	@mkdir -p $(@D:$(BUILDDIR)%=$(DEPDIR)%)
	
	$(CC) -MMD -MF $(DEPDIR)/$*.d $(CPPFLAGS) $(INCPATH) -o $@ -c $<
	
	@cp $(DEPDIR)/$*.d $(DEPDIR)/$*.P; \
	sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
	-e '/^$$/ d' -e 's/$$/ :/' < $(DEPDIR)/$*.d >> $(DEPDIR)/$*.P; \
	rm -f $(DEPDIR)/$*.d

-include $(DEP)

.PHONY: clean mrproper install uninstall

clean:
	rm -r $(DEPDIR) $(BUILDDIR)

mrproper: clean
	rm -rf lib$(TARGET).so lib$(TARGET)-debug.so

