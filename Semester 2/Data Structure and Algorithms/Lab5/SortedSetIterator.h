#pragma once
#include "SortedSet.h"
#include <stack>

//DO NOT CHANGE THIS PART
class SortedSetIterator
{
	friend class SortedSet;
private:
	const SortedSet& multime;
	SortedSetIterator(const SortedSet& m);

	int currentNode;
	std::stack<int> st;

public:
	void first();
	void next();
	TElem getCurrent();
	bool valid() const;
};

