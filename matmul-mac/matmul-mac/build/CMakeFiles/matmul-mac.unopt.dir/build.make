# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build

# Include any dependencies generated for this target.
include CMakeFiles/matmul-mac.unopt.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/matmul-mac.unopt.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/matmul-mac.unopt.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/matmul-mac.unopt.dir/flags.make

CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o: CMakeFiles/matmul-mac.unopt.dir/flags.make
CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o: ../harness.cpp
CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o: CMakeFiles/matmul-mac.unopt.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o -MF CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o.d -o CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o -c /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/harness.cpp

CMakeFiles/matmul-mac.unopt.dir/harness.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/matmul-mac.unopt.dir/harness.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/harness.cpp > CMakeFiles/matmul-mac.unopt.dir/harness.cpp.i

CMakeFiles/matmul-mac.unopt.dir/harness.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/matmul-mac.unopt.dir/harness.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/harness.cpp -o CMakeFiles/matmul-mac.unopt.dir/harness.cpp.s

CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o: CMakeFiles/matmul-mac.unopt.dir/flags.make
CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o: ../matmul-mac.unopt.cpp
CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o: CMakeFiles/matmul-mac.unopt.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o -MF CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o.d -o CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o -c /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/matmul-mac.unopt.cpp

CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/matmul-mac.unopt.cpp > CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.i

CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/matmul-mac.unopt.cpp -o CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.s

# Object files for target matmul-mac.unopt
matmul__mac_unopt_OBJECTS = \
"CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o" \
"CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o"

# External object files for target matmul-mac.unopt
matmul__mac_unopt_EXTERNAL_OBJECTS =

matmul-mac.unopt: CMakeFiles/matmul-mac.unopt.dir/harness.cpp.o
matmul-mac.unopt: CMakeFiles/matmul-mac.unopt.dir/matmul-mac.unopt.cpp.o
matmul-mac.unopt: CMakeFiles/matmul-mac.unopt.dir/build.make
matmul-mac.unopt: /local/scratch/a/paranjav/openfhe-development/build/lib/libOPENFHEpke.so.1.2.3
matmul-mac.unopt: /local/scratch/a/paranjav/openfhe-development/build/lib/libOPENFHEbinfhe.so.1.2.3
matmul-mac.unopt: /local/scratch/a/paranjav/openfhe-development/build/lib/libOPENFHEcore.so.1.2.3
matmul-mac.unopt: CMakeFiles/matmul-mac.unopt.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable matmul-mac.unopt"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/matmul-mac.unopt.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/matmul-mac.unopt.dir/build: matmul-mac.unopt
.PHONY : CMakeFiles/matmul-mac.unopt.dir/build

CMakeFiles/matmul-mac.unopt.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/matmul-mac.unopt.dir/cmake_clean.cmake
.PHONY : CMakeFiles/matmul-mac.unopt.dir/clean

CMakeFiles/matmul-mac.unopt.dir/depend:
	cd /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build /local/scratch/a/paranjav/coyote-project/paper/rebuttal-benchmarks/matmul-mac/matmul-mac/build/CMakeFiles/matmul-mac.unopt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/matmul-mac.unopt.dir/depend

