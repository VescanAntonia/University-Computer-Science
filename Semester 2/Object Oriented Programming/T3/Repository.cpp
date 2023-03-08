#include "Repository.h"
#include <string>
#include "utils.h"
#include <fstream>


void Repository::readFile()
{
	std::ifstream f(this->fileName);
	elements.clear();
	std::string line;
	while (std::getline(f, line)) {
		auto fields = split(line, ',');
		//elements.emplace_back(fields[0], fields[1], fields[2]);
	}
}
Repository::Repository(std::string fileName1):fileName(fileName1)
{
	this->readFile();
}

const std::vector<Equation>& Repository::getAll() const
{
	return this->elements;
}
