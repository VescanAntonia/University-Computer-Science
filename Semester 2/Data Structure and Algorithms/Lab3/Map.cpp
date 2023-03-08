#include "Map.h"
#include "MapIterator.h"

int Map::resize() const
{
	return length==capacity;
}

void Map::grow()
{
	capacity *= 2;
	auto newBuffer = new Node[capacity];

	for (int i = 0; i < length; ++i)
		newBuffer[i] = array[i];

	for (int i = length; i < capacity; ++i)
		newBuffer[i] = { NULL_TELEM,-1,i + 1 };

	newBuffer[capacity - 1].next = -1;
	firstEmpty = length;

	delete[] array;
	array = newBuffer;
}

int Map::searchindex(TKey c) const
{
	for (auto current = head; current != -1; current = array[current].next)
		if (array[current].value.first == c)
			return current;

	return -1;
}

Map::Map() {
	capacity = 8;
	array = new Node[8];

	for (int i = 0; i < 8; ++i)
		array[i] = { NULL_TELEM, -1, i + 1 };

	array[7].next = -1;

	length = 0;

	head = tail = -1;
	firstEmpty = 0;
}

Map::~Map() {
	delete[] array;
}

TValue Map::add(TKey c, TValue v){
	auto oldIndex = searchindex(c);

	if (oldIndex != -1) {
		auto old = array[oldIndex].value.second;
		array[oldIndex].value.second = v;

		return old;
	}

	if (resize())
		grow();

	auto nextEmpty = array[firstEmpty].next;

	array[firstEmpty] = { {c, v}, tail, -1 };

	if (tail != -1)
		array[tail].next = firstEmpty;

	tail = firstEmpty;
	if (head == -1)
		head = firstEmpty;

	firstEmpty = nextEmpty;
	++length;

	return NULL_TVALUE;
}

TValue Map::search(TKey c) const{
	auto index = searchindex(c);
	return index != -1 ? array[index].value.second : NULL_TVALUE;
}

TValue Map::remove(TKey c){
	auto index = searchindex(c);

	if (index == -1)
		return NULL_TVALUE;

	auto old = array[index].value.second;

	if (index != head)
		array[array[index].prev].next = array[index].next;
	else
		head = array[index].next;

	if (index != tail)
		array[array[index].next].prev == array[index].prev;
	else tail = array[index].prev;

	array[index] = { NULL_TELEM,-1,firstEmpty };
	firstEmpty = index;
	--length;

	return old;
}


int Map::size() const {
	return length;
}

bool Map::isEmpty() const{
	return length == 0;
}

MapIterator Map::iterator() const {
	return MapIterator(*this);
}



