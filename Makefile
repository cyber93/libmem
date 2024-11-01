# SPDX-License-Identifier: Apache-2.0
# ******************************************************************************
#
# @file			Makefile
#
# @brief        Makefile for Libmem library
#
#
# @date         Nov 2024
# @author       Han Deok, Lee <cyber93@gmail.com>
#
# ******************************************************************************

CC=gcc
CFLAGS?= -g3 -O0 -Wall -Wextra
MACROS?=
INCLUDE_DIR?=/usr/local/include
LIB_DIR?=/usr/local/lib
INCLUDE_PATH=-I $(INCLUDE_DIR) 
LIB_PATH=-L $(LIB_DIR)
LIBS=-lcxl -ldaxctl
TARGET=mem


all: lib$(TARGET).a

mem: cli.c options.c options.h libmem.o log.o
	$(CC) $^ $(CFLAGS) $(MACROS) $(INCLUDE_PATH) $(LIB_PATH) $(LIBS) -o $@ 

lib$(TARGET).a: libmem.o log.o
	ar rcs $@ $^

libmem.o: libmem.c libmem.h
	$(CC) -c $< $(CFLAGS) $(MACROS) $(INCLUDE_PATH) -o $@ 

log.o: log.c log.h
	$(CC) -c $< $(CFLAGS) $(MACROS) $(INCLUDE_PATH) -o $@

clean:
	rm -rf ./*.o ./*.a mem

doc: 
	doxygen

install: lib$(TARGET).a 
	sudo cp lib$(TARGET).a $(LIB_DIR)/
	sudo cp lib$(TARGET).h $(INCLUDE_DIR)/$(TARGET).h

uninstall:
	sudo rm $(LIB_DIR)/lib$(TARGET).a
	sudo rm $(INCLUDE_DIR)/lib$(TARGET).h

.PHONY: all clean doc install uninstall

# Variables 
# $^ 	Will expand to be all the sensitivity list
# $< 	Will expand to be the frist file in sensitivity list
# $@	Will expand to be the target name (the left side of the ":" )
# -c 	gcc will compile but not try and link 
