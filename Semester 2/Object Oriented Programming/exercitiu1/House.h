#pragma once
#include <string>
#include "Building.h"

class House :public Building {
private:
	bool hist;
public:
	House(std::string adress, std::size_t year, bool hist);
	House();
	~House();

	bool getHist() const;

	bool MustBeRestore() override;
	bool CanBeDemolished() override;
	std::string toString()override;
	friend std::ostream& operator<<(std::ostream& os, const House& b);
	friend std::istream& operator>>(std::istream& is, House& b);

};