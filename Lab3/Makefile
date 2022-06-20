CXX = g++
CXXFLAGS = -Wall -Werror -Wextra -pedantic -std=c++20 -g -fsanitize=address
LDFLAGS =  -fsanitize=address

SRC = Stack.cpp StackApp.cpp
OBJ = $(SRC:.cc=.o)
EXEC = Stack

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(LBLIBS)

run: 
	./$(EXEC)
clean:
	rm -rf $(EXEC)