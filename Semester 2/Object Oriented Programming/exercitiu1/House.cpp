#include "House.h"
#include <iostream>
#include <sstream>
#include <string>
using namespace std;

House::House(std::string adress, std::size_t year, bool hist) :
	Building{ adress,year }, hist{ hist }

{
}

House::House()
{
}

House::~House()
{
}

bool House::getHist() const
{
	return this->hist;
}

bool House::MustBeRestore()
{
	if (2022-this->year >= 100)
		return true;
	return false;
}

bool House::CanBeDemolished()
{
	if (this->hist)
		return false;
	return true;
}

std::string House::toString()
{
	std::stringstream buffer;
	buffer << "House Address: " << this->adress << " year: " << this->year << " historical " << this->hist << std::endl;
	return buffer.str();
	//auto yearStr = to_string(this->year);
	//return "House adress: " + this->adress + " | Year: " + yearStr + " | Hist: " + to_string(this->hist); 
}

std::ostream& operator<<(std::ostream& os, const House& b)
{
	return os << "House  Year: " << b.year << " Address: " << b.adress << " Hist: " << b.hist << '\n';

}

std::istream& operator>>(std::istream& is, House& b)
{
	return is >> b.adress >> b.year >> b.hist;
}
