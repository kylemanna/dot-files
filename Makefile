#
# Symlink files from the local dot dir to $HOME.  Create parent directories if needed.
#
# Author: Kyle Manna <kyle [at] kylemanna [dot] com>
#
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Symlink everyfile except *.git, README.md and Makefile
SRC := $(shell find $(ROOT_DIR) -mindepth 1 \
	\( -path '*/.git' -o -name README.md -o -name Makefile \) -prune \
	-o \( -type f -o -type l \) -print)

DST := $(SRC:$(ROOT_DIR)/%=$(HOME)/%)

DST_DIRS := $(patsubst %/,%,$(sort $(dir $(DST))))

all: $(DST)

.SECONDEXPANSION:
$(DST): $$(patsubst $(HOME)/%,$(ROOT_DIR)/%, $$@) | $$(@D)
	ln -sf $< $@

$(DST_DIRS):
	mkdir -p $@

.PHONY: src dst dst_dirs
src:
	$(info SRC = $(SRC))
dst:
	$(info DST = $(DST))
dst_dirs:
	$(info DST_DIRS = $(DST_DIRS))
