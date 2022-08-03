CXX = g++
CXXFLAGS = -Wall -Werror -Wextra -pedantic -std=c++9 -g -fsanitize=address
LDFLAGS =  -fsanitize=address

SRC = DigitApp.cpp DigitPrt.cpp
OBJ = $(SRC:.cc=.o)
EXEC = mainapp

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(LBLIBS)

run: 
	./$(EXEC)
clean:
	rm -rf $(EXEC)