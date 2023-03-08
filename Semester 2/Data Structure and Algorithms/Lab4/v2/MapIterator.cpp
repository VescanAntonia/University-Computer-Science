#include "Map.h"
#include "MapIterator.h"
#include <exception>
using namespace std;


MapIterator::MapIterator(Map& d) : map(d)
{
    // tetha(1)
    this->first();
}

void MapIterator::first() {
    // tetha(1)
    // set the currentElementIndex to the head of the map
    this->currentElementIndex = this->map.head;
}

void MapIterator::next() {
    // tetha(1)
    // we check if the index is valid, and throw an exception if not
    if(!this->valid())
        throw std::exception();
    // otherwise,we move to the next element
    this->currentElementIndex = this->map.elems[this->currentElementIndex].next;
}

TElem MapIterator::getCurrent(){
    // tetha(1)
    // return the current element
    // if the index is not valid, throw an exception
    if(!this->valid())
        throw std::exception();
    // return the current element
    return this->map.elems[this->currentElementIndex].value;
}

bool MapIterator::valid() const {
    // tetha(1)
    // checks if the currentElementIndex points to a valid element
    return this->currentElementIndex !=  -1;
}



