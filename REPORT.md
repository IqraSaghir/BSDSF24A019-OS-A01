## Feature 2: Multi-file Build

### 1. Explain the linking rule in the Makefile: `$(TARGET): $(OBJECTS)`. How does it differ from a Makefile rule that links against a library?

The rule `$(TARGET): $(OBJECTS)` means that the final executable depends on all the object files of the project.

In our Makefile, `$(TARGET)` is `bin/client` and `$(OBJECTS)` contains:

- `obj/main.o`
- `obj/mystrfunctions.o`
- `obj/myfilefunctions.o`

The linker combines these object files to create the final executable `bin/client`.

In a library-based Makefile, the executable is linked with a library instead of directly listing all the individual object files. For example, later in the project, the object files can be combined into `lib/libmyutils.a`, and the client can then be linked against that library.

Therefore, in this feature we directly link the object files, while in a library-based build we link the executable with a library file.

### 2. What is a git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?

A Git tag is a name attached to a specific commit. It is useful for marking important versions or stable points in a project's history.

For example, in this project we created the tag `v0.1.1-multifile` to mark the completed multi-file build version.

A simple tag only points to a commit. An annotated tag is stored as a separate Git object and contains additional information such as the tag message, tagger, and date.

In this project, an annotated tag was created using:

`git tag -a v0.1.1-multifile -m "Version 1.0 - Basic multifile compilation"`

### 3. What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries like the client executable to it?

A GitHub Release provides a way to publish a specific version of a project based on a Git tag. It gives users a clear and stable version that they can access without searching through the project's commit history.

Attaching a binary such as `client` allows users to obtain the already-compiled executable directly instead of compiling the source code themselves.

For this project, the `v0.1.1-multifile` release includes the compiled `client` executable produced from the multi-file C project.
## Feature 3: Static Library Build

### 1. Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?

In Part 2, the object files for the main program and utility functions were directly linked together to create the executable.

The Makefile used:

- `OBJECTS = obj/main.o obj/mystrfunctions.o obj/myfilefunctions.o`
- `$(CC) $(OBJECTS) -o $(TARGET)`

In Part 3, the utility object files are first combined into a static library.

The Makefile introduces:

- `LIBRARY = lib/libmyutils.a`
- `MAIN_OBJECT = obj/main.o`
- `LIB_OBJECTS = obj/mystrfunctions.o obj/myfilefunctions.o`

The following rule creates the static library:

`$(LIBRARY): $(LIB_OBJECTS)`

`ar rcs $(LIBRARY) $(LIB_OBJECTS)`

The final executable is then linked with the main object file and the static library:

`$(TARGET): $(MAIN_OBJECT) $(LIBRARY)`

`$(CC) $(MAIN_OBJECT) $(LIBRARY) -o $(TARGET)`

Therefore, Part 2 directly links all object files, while Part 3 first packages the utility object files into `libmyutils.a` and then links the main program against that library.

### 2. What is the purpose of the ar command? Why is ranlib often used immediately after it?

The `ar` command is used to create and modify archive files. In this project, it combines `mystrfunctions.o` and `myfilefunctions.o` into the static library `lib/libmyutils.a`.

The command used in our Makefile is:

`ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o`

The `ranlib` command creates or updates the symbol index of a static library. This index helps the linker find symbols inside the library efficiently.

In modern GNU `ar`, the `s` option in `ar rcs` creates the symbol index automatically, so a separate `ranlib` command was not required in our Makefile.

### 3. When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works?

When we ran `nm` on `bin/client_static`, the symbols for `wordCount` and `mygrep` were present because these functions are used by `main.c`.

However, `mystrlen` was not shown because `main.c` does not call `mystrlen()`.

This demonstrates that during static linking, the linker includes the required code from the static library in the final executable. Functions that are not required by the program do not necessarily appear in the final executable.
## Feature 4: Dynamic Library Build

### 1. What is Position-Independent Code (-fPIC) and why is it a fundamental requirement for creating shared libraries?

Position-Independent Code (PIC) is code that can execute correctly regardless of the memory address where it is loaded. Shared libraries can be loaded at different memory addresses by different processes, so they need to be position-independent.

In this project, we used the `-fPIC` option when compiling `mystrfunctions.c` and `myfilefunctions.c`. This made their object files suitable for creating the shared library `libmyutils.so`.

### 2. Explain the difference in file size between your static and dynamic clients. Why does this difference exist?

Our static client `bin/client_static` was 17K, while the dynamic client `bin/client_dynamic` was 16K.

The static executable is larger because the required library code is copied into the executable during static linking. In dynamic linking, the library code remains in the separate `libmyutils.so` file and is loaded when the program runs.

The difference is small in our project because the library and program are both small.

### 3. What is the LD_LIBRARY_PATH environment variable? Why was it necessary to set it for your program to run, and what does this tell you about the responsibilities of the operating system's dynamic loader?

`LD_LIBRARY_PATH` is an environment variable that tells the dynamic loader which additional directories to search for shared libraries.

We used:

`export LD_LIBRARY_PATH=./lib`

because our `libmyutils.so` was stored inside the project's `lib` directory, which was not one of the system's normal library search locations.

Before setting it, `./bin/client_dynamic` could not find `libmyutils.so`. After setting it, the program ran successfully.

The command `ldd bin/client_dynamic` confirmed:

`libmyutils.so => ./lib/libmyutils.so`

This shows that the dynamic loader is responsible for finding and loading the shared libraries required by a dynamically linked program.
