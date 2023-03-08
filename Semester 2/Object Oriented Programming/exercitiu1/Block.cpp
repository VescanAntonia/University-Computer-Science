#include "Block.h"
//#include <fstream>
//#include <string>
#include <sstream>
#include <iostream>
using namespace std;

Block::Block()
{
}

Block::Block(std::string adress, std::size_t year, std::size_t nrap, std::size_t ocap) :
	Building{adress, year}, nr_apart{nrap},ocup_apart{ocap}

{
	std::cout<<this->adress;
	/*this->adress = adress;
	this->year = year;
	this->nr_apart = nrap;
	this->ocup_apart = ocup_apart;*/
}

Block::~Block()
{
}

std::size_t Block::getNrAp() const
{
	return this->nr_apart;
}

std::size_t Block::getOcAp() const
{
	return this->ocup_apart;
}

bool Block::MustBeRestore()
{
	if ((2022 - this->year) < 40)
		return false;
	int per = this->ocup_apart * 100 / this->nr_apart;
	if (per >= 80) {
		std::cout << "Restored";
		return true;
	}
	return false;
}

bool Block::CanBeDemolished()
{
	int per = this->ocup_apart * 100 / this->nr_apart;
	if (per < 5) {
		std::cout << "Demolished";
		return true;
	}
	return false;
}

std::string Block::toString()
{
	std::stringstream buffer;
	buffer << "Block Address: " << this->adress << " year: " << this->year << " nr of app: " << this->nr_apart << " oc ap: " << this->ocup_apart << std::endl;
	return buffer.str();
	/*auto nrapString = to_string(this->nr_apart);
	auto ocapString = to_string(this->ocup_apart);
	auto yearStr = to_string(this->year);
	return "Block adress: " + this->adress + " | Year: " + yearStr + " | Total apartments: " + nrapString+" | Ocup ap: "+ocapString;*/
}

std::ostream& operator<<(std::ostream& os, const Block& b)
{
	return os << "Block  Year: " << b.year << " Address: " << b.adress << " Nr Ap: " << b.nr_apart << " Ap Oc: " << b.ocup_apart<< '\n';
}

std::istream& operator>>(std::istream& is, Block& b)
{
	return is >> b.adress >> b.year >> b.nr_apart >> b.ocup_apart;
}
