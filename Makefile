CC = gcc
CFLAGS = -Wall -Wextra -Iinclude
PICFLAGS = -fPIC

STATIC_TARGET = bin/client_static
DYNAMIC_TARGET = bin/client_dynamic

STATIC_LIBRARY = lib/libmyutils.a
DYNAMIC_LIBRARY = lib/libmyutils.so

MAIN_OBJECT = obj/main.o
LIB_OBJECTS = obj/mystrfunctions.o obj/myfilefunctions.o

$(STATIC_TARGET): $(MAIN_OBJECT) $(STATIC_LIBRARY)
	$(CC) $(MAIN_OBJECT) $(STATIC_LIBRARY) -o $(STATIC_TARGET)

$(STATIC_LIBRARY): $(LIB_OBJECTS)
	ar rcs $(STATIC_LIBRARY) $(LIB_OBJECTS)

$(DYNAMIC_TARGET): $(MAIN_OBJECT) $(DYNAMIC_LIBRARY)
	$(CC) $(MAIN_OBJECT) -Llib -lmyutils -o $(DYNAMIC_TARGET)

$(DYNAMIC_LIBRARY): $(LIB_OBJECTS)
	$(CC) -shared $(LIB_OBJECTS) -o $(DYNAMIC_LIBRARY)

obj/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o obj/main.o

obj/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) $(PICFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) $(PICFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions.o

clean:
	rm -f obj/*.o lib/libmyutils.a lib/libmyutils.so bin/client_static bin/client_dynamic
