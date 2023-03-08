#include "HTMLRepo.h"
#include <fstream>

HTMLRepo::HTMLRepo(const std::vector<Dog>& adoptionList, const std::string& userFilename)
{
	this->adoptionList = adoptionList;
	this->userFilename = userFilename;
}

std::vector<Dog>& HTMLRepo::getAllUserRepo()
{
	return this->adoptionList;
}

unsigned int HTMLRepo::getNrElems()
{
	return this->adoptionList.size();
}

unsigned int HTMLRepo::getCapacity()
{
	return this->adoptionList.capacity();
}

void HTMLRepo::addUserRepo(const Dog& dog)
{
	this->adoptionList.push_back(dog);
	this->writeToFile();
}

void HTMLRepo::writeToFile()
{
	std::ofstream fout(this->userFilename);
	fout << "<!DOCTYPE html>\n<html><head><title>Adoption List</title></head><body>\n";
	fout << "<table border=\"1\">\n";
	fout << "<tr><td>Breed<</td><td>Name</td><td>Age></td><td>Link</td></tr>\n";
	for (const Dog& dog : this->adoptionList) {
		fout << "<tr><td>" << dog.get_breed() << "</td>" << "<td>" << dog.get_name() << "</td>" << "<td>" << std::to_string(dog.get_age()) << "</td>" << "<td><a href=\"" << dog.get_photograph() << "\">" << dog.get_photograph() << "</a></td>" << '\n';
	}
	fout << "</table></body></html>";
	fout.close();
}

std::string& HTMLRepo::getFilename()
{
	return this->userFilename;
}

HTMLRepo::~HTMLRepo() = default;
