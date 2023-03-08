#include <exception>
#include "BagIterator.h"
#include "Bag.h"

using namespace std;


BagIterator::BagIterator(const Bag& c): bag(c)
{
	//Best case: theta(1), Worst case: theta(1), Average case: theta(1)
	this->index = 0;
}

void BagIterator::first() {
	//Best case: theta(1), Worst case: theta(1), Average case: theta(1)
	this->index = 0;
}


void BagIterator::next() {
	//Best case: theta(1), Worst case: theta(1), Average case: theta(1)
	if (this->index >= this->bag.size())
	{
		throw exception();
	}
	this->index++;
}


bool BagIterator::valid() const {
	//Best case: theta(1), Worst case: theta(1), Average case: theta(1)
	return (this->index < this->bag.size());
}


TElem BagIterator::getCurrent() const
{
	if (this->valid() == false)
	{
		throw exception();
	}
	return this->bag.u[this->bag.p[this->index]];
}
