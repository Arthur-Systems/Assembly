CXX = as
CXXFLAGS = -m32 -g 
LDFLAGS = 

LINK = ld
LINKFLAGS =  -macosx_version_min 10.7 -no_pie 


SRC = 
OBJ = $(SRC:.cc=.o)
ENTRY = _main
EXEC = Assembler

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(LBLIBS)

link:
	$(LINK) $(LINKFLAGS) -e $(ENTRY) $(OBJ) -o $(EXEC)


clean:
	rm -rf $(OBJ) $(EXEC)

	#ld -macosx_version_min 10.7 -no_pie -e _main hello.obj -o foo
	# as -m32 -g -o hello.obj -c samp-raw.asm 