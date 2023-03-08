#include "ListIterator.h"
#include "IteratedList.h"
#include <exception>
using namespace std;

ListIterator::ListIterator(const IteratedList& list) : list(list) {
	//theta(1)
	if(this->list.isEmpty())
		this->current = nullptr;
	else
	{
		this->current = list.elms.head;
	}
}

void ListIterator::first() {
	//theta(1)
	this->current = list.elms.head;
}

void ListIterator::next() {
	//theta(1)
	if (!this->valid()) throw exception();
	this->current = this->current->next;
}

bool ListIterator::valid() const {
	//theta(1)
	return this->current != nullptr;
}

TElem ListIterator::getCurrent() const {
	//theta(1)
	if (this->current == nullptr) throw exception();
	return this->current->info;
}



