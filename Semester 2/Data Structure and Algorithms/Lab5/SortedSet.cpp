#include "SortedSet.h"
#include <cmath>
#include <iostream>
#include "SortedSetIterator.h"
#define emptyVal -1
using namespace std;


void SortedSet::resize()
{
	//O(n)
	TElem* newInfo = new TComp[this->capacity * 2];
	for (int index = 0; index < this->capacity; index++)
		newInfo[index] = this->info[index];                           //coppy the old information and resize the array corespondingly

	int* new_child_lft = new int[this->capacity * 2];
	int* newParents = new int[this->capacity * 2];
	int* new_child_rgt = new int[this->capacity * 2];
	for (int i = 0; i < this->capacity; i++)

	{
		new_child_lft[i] = this->child_l[i];
		new_child_rgt[i] = this->child_r[i];
		newParents[i] = this->parents[i];
	}

	for (int i = this->capacity; i < this->capacity * 2 - 1; i++)
	{
		new_child_lft[i] = i + 1;
		new_child_rgt[i] = -1;
	}
	new_child_rgt[this->capacity * 2 - 1] = -1;
	new_child_lft[this->capacity * 2 - 1] = -1;

	this->firstEmpty = this->capacity;
	this->capacity *= 2;

	delete[] this->info;
	delete[] this->child_l;
	delete[] this->child_r;
	delete[] this->parents;

	this->info = newInfo;
	this->child_l = new_child_lft;
	this->child_r = new_child_rgt;
	this->parents = newParents;
}

SortedSet::SortedSet(Relation r) {
	//O(n)
	this->r = r;
	this->capacity = 10;
	this->info = new TComp[capacity];
	this->child_l = new int[capacity];
	this->child_r = new int[capacity];
	this->parents = new int[capacity];
	this->numberOfElements = 0;
	this->firstEmpty = 0;
	this->root = -1;

	for (int index = 0; index < this->capacity - 1; index++)
	{
		this->parents[index] = -1;
		this->child_r[index] = -1;
		this->child_l[index] = index + 1;
	}

	this->child_r[this->capacity - 1] = -1;
	this->child_l[this->capacity - 1] = -1;
	this->parents[this->capacity - 1] = -1;
}


bool SortedSet::add(TComp elem) {
	//O(n)
	if (this->firstEmpty == -1)
		resize();
	if (this->search(elem) == true)
	{
		//the element is already in the set, we return false because it shouldn't be added
		this->info[firstEmpty] = elem;
		return false;
	}
		
	// the new firstEmpty position is stored
	int nextFirstEmpty = this->child_l[firstEmpty];

	// initializing the new node on the firstEmpty position
	this->info[firstEmpty] = elem;
	this->child_l[firstEmpty] = -1;
	this->child_r[firstEmpty] = -1;
 
	int currentPosition = root;    //searching for the place to insert the new el
	int parent = -1;

	while (currentPosition != -1)  // We stop when we reach a leaf; the parent represents the leaf we stop at
	{
		parent = currentPosition;

		if (r(elem, info[currentPosition]))
			currentPosition = child_l[currentPosition];
		else
			currentPosition = child_r[currentPosition];
	}


	if (root == -1)   // if it is empty it becomes the root
		root = firstEmpty;

	else if (r(elem, info[parent]))    // decide if the new element is a left child or a right child
		child_l[parent] = firstEmpty;
	else
		child_r[parent] = firstEmpty;

	this->parents[this->firstEmpty] = parent; // The parent of the root initilized to -1

	firstEmpty = nextFirstEmpty;

	numberOfElements++;
	return true;
}


bool SortedSet::remove(TComp elem) {
	//O(n)
	int currentPosition = this->root;
	bool exists = this->search(elem);   // check if the element exist to see if we can remove it than decide the case
	if (exists != false){ {
		while (currentPosition != -1) {
			if (elem == info[currentPosition]) {
				break;
			}
			else {
				if (r(elem, info[currentPosition]))
					currentPosition = child_l[currentPosition];
				else
					currentPosition = child_r[currentPosition];
			}
			}
	}
	if (child_l[currentPosition] == -1 && child_r[currentPosition] == -1) {
		//the case where it has no descendants
		if (currentPosition == this->root)
		{
			this->root = -1;
		}

		else
		{
			// We decide whether the node to delete was a left child or right child
			if (r(this->info[currentPosition], this->info[this->parents[currentPosition]]))
				this->child_l[parents[currentPosition]] = -1;
			else
				this->child_r[parents[currentPosition]] = -1;

		}
	}

	else if (child_l[currentPosition] == -1)
		// the case where it has a right descendant
	{
		if (currentPosition == this->root)
		{
			this->root = child_r[currentPosition];
		}

		else
		{
			parents[child_r[currentPosition]] = parents[currentPosition];

			if (r(this->info[currentPosition], this->info[parents[currentPosition]]))
				this->child_l[parents[currentPosition]] = child_r[currentPosition];
			else
				this->child_r[parents[currentPosition]] = child_r[currentPosition];
		}
	}

	else if (child_r[currentPosition] == -1)
		// the case where it has a left descendant
	{
		if (currentPosition == this->root)
		{
			this->root = child_l[currentPosition];
		}

		else
		{
			parents[child_l[currentPosition]] = parents[currentPosition];

			if (r(this->info[currentPosition], this->info[parents[currentPosition]]))
				this->child_l[parents[currentPosition]] = child_l[currentPosition];
			else
				this->child_r[parents[currentPosition]] = child_l[currentPosition];
		}
	}

	else
		// the case where it has two descendants
	{
		int currentMaxNode = this->child_l[currentPosition];
		int previousMaxNode = currentPosition;

		while (this->child_r[currentMaxNode] != -1)
		{
			previousMaxNode = currentMaxNode;
			currentMaxNode = this->child_r[currentMaxNode];
		}

		// Change the info in the node to be deleted
		this->info[currentPosition] = this->info[currentMaxNode];

		// Delete the maximum node
		if (this->child_l[currentMaxNode] == -1)
		{
			if (currentPosition == this->root)
			{
				this->root = -1;
			}
			else
			{
				// We decide whether the current node to delete was a left child or right child
				if (r(this->info[currentPosition], this->info[this->parents[currentPosition]]))
					this->child_l[parents[currentPosition]] = -1;
				else
					this->child_r[parents[currentPosition]] = -1;

			}
		}
		else
		{
			if (currentPosition == this->root)
			{
				this->root = child_l[currentPosition];
			}

			else
			{
				parents[child_l[currentPosition]] = parents[currentPosition];

				if (r(this->info[currentPosition], this->info[parents[currentPosition]]))
					this->child_l[parents[currentPosition]] = child_l[currentPosition];
				else
					this->child_r[parents[currentPosition]] = child_l[currentPosition];
			}
		}
	}

	this->numberOfElements -= 1;

	return true;

		
	}
	return false;
}


bool SortedSet::search(TComp elem) const {
	//O(n)
	// We start from the root
	int currentPosition = root;
	while (currentPosition != -1)   // until we reach a leaf or find the element
	{
		if (info[currentPosition] == elem)
			return true;
		else if (r(elem, info[currentPosition]))
			currentPosition = child_l[currentPosition];      // Here we determine which child will become the current position
		else
			currentPosition = child_r[currentPosition];
	}
	return false;
}


int SortedSet::size() const {
	//theta(1)
	return this->numberOfElements;
}



void SortedSet::filter(Condition cond)
{
	int currentPos = this->root;
	for (int i = 0; i < this->capacity; i++)
	{
		if (cond(this->info[i]) == false) {
			this->remove(this->info[i]);
		}
	}
}

bool SortedSet::isEmpty() const {
	//theta(1)
	return this->numberOfElements == 0;
}

bool SortedSet::isSmaller(int val)
{
	return val < 5;
}


SortedSetIterator SortedSet::iterator() const {
	//theta(1)
	return SortedSetIterator(*this);
}


SortedSet::~SortedSet() {
	//theta(1)
	delete[] info;
	delete[] child_l;
	delete[] child_r;
	delete[] parents;
}


