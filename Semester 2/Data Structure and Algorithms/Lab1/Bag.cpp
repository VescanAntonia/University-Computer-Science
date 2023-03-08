#include "Bag.h"
#include "BagIterator.h"
#include <exception>
#include <iostream>
using namespace std;


Bag::Bag() {
	this->u = new int[1];
	this->p = new int[1];
	this->size_u = 0;
	this->size_p = 0;
	this->capacity_u = 1;
	this->capacity_p = 1;
}


void Bag::add(TElem elem) {
	// best case:theta(1), worst case: theta(number of el+number of distinct el), average case: theta(number of distinct elements)
	int position = -1;
	for (int i = 0; i < this->size_u; i++)    //we check if the element is already in the list of distinct elements and get its position
	{
		if (this->u[i] == elem)
		{
			position = i;
			break;
		}
	}
	if (position == -1)                            //if the element is not in the list of the distinct elements 
	{
		if (this->size_u == this->capacity_u)           //if the size of the unique elements is equal to the capacity we increase it
		{
			TElem* new_u = new int[this->capacity_u * 2]; 
			for (int i = 0; i < this->size_u; i++) {
				new_u[i] = this->u[i];                               //the new distinct elements take the values of the old ones
			}
			delete[] this->u;                   // we delete the old distinct elements
			this->u = new_u;                               //the old array takes the value of the new one
			this->capacity_u = this->capacity_u * 2;            //the capacity is increased
		}
		this->u[this->size_u++] = elem;           //we add the element and get its position int he new array
		position = this->size_u - 1;
	}

	if (this->size_p == this->capacity_p)
	{
		TElem* new_p = new int[this->capacity_p * 2];               //if the capacity of the position elements is equal to the size we increase it 
		for (int i = 0; i < this->size_p; i++)                // and create a new array with the old elements 
		{
			new_p[i] = p[i];
		}
		delete[] this->p;
		this->p = new_p;
		this->capacity_p = this->capacity_p * 2;

	}
	this->p[this->size_p++] = position;        //we add the position of the new added element to the position array
}


bool Bag::remove(TElem elem) {
	//best case: theta(nr of elements), worst case: theta(nr of elements+ nr of distinct elements), average case: theta(nr of elements)
	int first_pos = -1, last_pos = -1;
	for (int i = 0; i < this->size_p; i++) {
		if (this->u[this->p[i]] == elem) {             // we get the first position from the position array of the element to be removed in order to
			if (first_pos == -1) {                     // remove all its indexes from the array
				first_pos = i;
			}
			last_pos = i;
		}
	}

	if (last_pos == -1) {     // if the elements is not in the array we cannot remove it
		return false;
	}

	for (int i = last_pos; i+1 < this->size_p; i++)
	{                                              //we remove the index of the removed element
		this->p[i] = this->p[i + 1];
	}
	this->size_p--;      //resize the array

	if (last_pos == first_pos)
	{
		int index = -1;
		for (int i = 0; i < this->size_u; i++)           //if there is only one index for the element we get it index in the distinct elements array
		{
			if (this->u[i] == elem)
			{
				index = i;
				break;
			}
		}
		for (int i = index; i + 1 < this->size_u; i++)
		{                                              // we remove the element from the distinct array of elements
			this->u[i] = this->u[i + 1];
		}
		this->size_u--;
		for (int i = 0; i < this->size_p; i++)
		{                                         // we decrease the bigger indexes for the elements
			if (this->p[i] > index)
			{
				this->p[i]--;
			}
		}
	}
	return true; 
}


bool Bag::search(TElem elem) const {
	//Best case:theta(nr of elements), Worst case: theta(nr of elements), Average case: theta(nr of elements)
	for (int i = 0; i < this->size_p; i++)
	{
		if(this->u[this->p[i]]==elem)
		{
			return true;
		}
	}
	return false; 
}

int Bag::nrOccurrences(TElem elem) const {
	int nr_occurences = 0;
	for (int i = 0; i < this->size_p; i++)
	{
		if (this->u[this->p[i]] == elem)
		{
			nr_occurences++;
		}
	}
	return nr_occurences; 
}


int Bag::size() const {
	return this->size_p;
}


bool Bag::isEmpty() const {
	return (this->size_p == 0);
}

BagIterator Bag::iterator() const {
	return BagIterator(*this);
}


Bag::~Bag() {
	delete[] this->p;
	delete[] this->u;
}

int Bag::elementsWithMaximumFrequency() const
{
	//best case: theta(1), Worst case: theta(2*number of elements^2), Average case
	int maximumfrequency = 0, nroccurences=0, nrOfElements = 0, currentcount = 0;
	if (isEmpty())
		return 0;
	else
	{
		for (int i = 0; i < this->size_u; i++)
		{
			int current_nr_occurences = nrOccurrences(this->u[i]);
			if (current_nr_occurences > maximumfrequency)
				maximumfrequency = current_nr_occurences;

		}
		for (int i = 0; i < this->size_u; i++)
			if (nrOccurrences(this->u[i]) == maximumfrequency)
				nrOfElements++;
		//for (int i = 0; i < this->size_p; i++)
		//{
		//	int count = 0;
		//	for (int j = 0; j < this->size_p; j++)             //check what is the maximum number of appearences 
		//	{
		//		if (this->u[this->p[j]] == this->u[this->p[i]])
		//		{
		//			count++;
		//		}
		//		if (count > maximumfrequency)
		//		{
		//			maximumfrequency = count;
		//		}

		//	}
		//}
		//	for (int i = 0; i < this->size_p; i++)
		//	{
		//		for (int j = 0; j < this->size_p; j++)
		//		{
		//			if (this->u[this->p[j]] == this->u[this->p[i]])           //going through the array and take the elements that have the maximum frequency
		//			{
		//				currentcount++;                                       // and count them
		//			}

		//		}
		//		if (currentcount == maximumfrequency)
		//		{
		//			nrOfElements++;
		//		}
		//	}
	}
	return nrOfElements;

}
