#pragma once
#include <vector>
#include "Equations.h"
#include <string>

class Repository {
private:
	std::vector<Equation> elements;
	std::string fileName;
	void readFile();
public:
	Repository(std::string fileName);
	const std::vector<Equation>& getAll()const;
};