#include "SortedSetIterator.h"
#include <exception>

using namespace std;

SortedSetIterator::SortedSetIterator(const SortedSet& m) : multime(m), st{ std::stack<int>{} }
{
	//theta(1)
	first();
}


void SortedSetIterator::first() {
	//O(n)
	this->currentNode = multime.root;

	st = std::stack<int>{};

	// We go to the leftmost node and push on the stack all the nodes on the way
	while (currentNode != -1)
	{
		st.push(currentNode);
		currentNode = multime.child_l[currentNode];
	}

	if (!st.empty())
	{
		currentNode = st.top();
	}

	else
		currentNode = -1;
}


void SortedSetIterator::next() {
	//O(n)
	if (!valid())
		throw std::exception("Invalid iterator");


	int node = st.top();
	st.pop();


	if (multime.child_r[node] != -1)
	{
		node = multime.child_r[node];
		while (node != -1)
		{
			st.push(node);
			node = multime.child_l[node];
		}
	}

	if (!st.empty())
		currentNode = st.top();

	else
		currentNode = -1;
}


TElem SortedSetIterator::getCurrent()
{
	//theta(1)
	if (!valid())
		throw std::exception("Invalid iterator");

	return multime.info[currentNode];
}

bool SortedSetIterator::valid() const {
	//theta(1)
	return currentNode != -1;
}

