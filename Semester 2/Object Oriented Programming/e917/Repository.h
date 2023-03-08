#pragma once
#include "SourceFile.h"
#include <vector>

class Repository {
private:
	std::vector<SourceFile> data;
	void loadData();
	void saveData();
public:
	Repository() { this->loadData(); }
	std::vector<SourceFile> get() { return this->data; }
	void add(SourceFile s);
	~Repository() { }
};