#pragma once
#include <string>

class Building {
protected:
	std::string adress;
	size_t year;
	std::string type;
public:
	Building(std::string adress, std::size_t year);
	Building();
	~Building();
	std::string getAdress()const;
	size_t getYear() const;
	std::string getType()const;
	virtual bool MustBeRestore() = 0;
	virtual bool CanBeDemolished() = 0;
	void setType(std::string type);
	virtual std::string toString();

};