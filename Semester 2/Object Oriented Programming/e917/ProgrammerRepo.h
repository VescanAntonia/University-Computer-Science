#pragma once
#include "Programmer.h"
#include <vector>

class ProgrammerRepo {
private:
	std::vector<Programmer> data;
	void loadData();
	void saveData();
public:
	ProgrammerRepo() { this->loadData(); }
	std::vector<Programmer> get() { return this->data; }
	~ProgrammerRepo() {}
};