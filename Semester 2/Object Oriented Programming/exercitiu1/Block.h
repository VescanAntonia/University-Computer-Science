#pragma once
#include "Building.h"

class Block : public Building {
private:
	std::size_t nr_apart;
	std::size_t ocup_apart;
public:
	Block();
	Block(std::string adress, std::size_t year, std::size_t nrap, std::size_t ocap);
	~Block();
	std::size_t getNrAp() const;
	std::size_t getOcAp() const;
	bool MustBeRestore() override;
	bool CanBeDemolished() override;
	std::string toString() override;
	friend std::ostream& operator<<(std::ostream& os, const Block& b);
	friend std::istream& operator>>(std::istream& is, Block& b);

};