CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

TARGET = bin/client_static
LIBRARY = lib/libmyutils.a

MAIN_OBJECT = obj/main.o
LIB_OBJECTS = obj/mystrfunctions.o obj/myfilefunctions.o

$(TARGET): $(MAIN_OBJECT) $(LIBRARY)
	$(CC) $(MAIN_OBJECT) $(LIBRARY) -o $(TARGET)

$(LIBRARY): $(LIB_OBJECTS)
	ar rcs $(LIBRARY) $(LIB_OBJECTS)

obj/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o obj/main.o

obj/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions.o

clean:
	rm -f obj/*.o lib/libmyutils.a bin/client_static
