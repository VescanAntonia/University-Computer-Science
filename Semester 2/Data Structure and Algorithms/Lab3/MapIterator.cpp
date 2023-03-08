#include "Map.h"
#include "MapIterator.h"
#include <exception>
using namespace std;


MapIterator::MapIterator(const Map& d) : map(d)
{
	current = map.head;
}


void MapIterator::first() {
	current = map.head;
}


void MapIterator::next() {
	if (!valid())
		throw exception();
	current = map.array[current].next;
}


TElem MapIterator::getCurrent(){
	if (!valid())
		throw exception();
	return map.array[current].value;
}


bool MapIterator::valid() const {
	return current != -1;
}



