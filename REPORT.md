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
