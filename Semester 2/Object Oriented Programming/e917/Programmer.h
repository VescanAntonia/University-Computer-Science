#pragma once
#include <string>

class Programmer {
private:
	std::string name;
	int numberRevisedFiles;
	int totalNrOfFiles;
public:
	Programmer() {}
	Programmer(const std::string& name, int nrRevised, int totalnr):name{name}, numberRevisedFiles{nrRevised}, totalNrOfFiles{totalnr}{}
	std::string getName()const { return this->name; };
	int getNumberRevised()const { return this->numberRevisedFiles; };
	int getTotalFiles()const { return this->totalNrOfFiles; }
	friend std::istream& operator>>(std::istream& in, Programmer& p);
	friend std::ostream& operator<<(std::ostream& out, Programmer& p);
};