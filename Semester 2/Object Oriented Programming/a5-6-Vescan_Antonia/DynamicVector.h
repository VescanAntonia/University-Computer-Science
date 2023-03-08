#pragma once
#include "Dog.h"

template <typename TElem>
class DynamicVector
{
private:
	TElem* elems;
	int size;
	int capacity;
	void resize();

public:
	//constructor for a DynamicVector;
	DynamicVector(int capacity);
	/// <summary>
	/// adds an element to the vector
	/// </summary>
	/// <param name="elToAdd"></param>
	void add(TElem elToAdd);
	/// <summary>
	/// gets the size of the dynamic vector
	/// </summary>
	/// <returns></returns>
	int getSize() const;
	/// <summary>
	/// gets the capacity of the vector
	/// </summary>
	/// <returns></returns>
	int getCap() const;
	/// <summary>
	/// gets all the elements of the dynamic vector
	/// </summary>
	/// <returns></returns>
	TElem* getAllElements() const;
	/// <summary>
	/// sets the size of the vector
	/// </summary>
	/// <param name="s"></param>
	void setSize(int s) { size = s; }
	/// <summary>
	/// removes the element from the given position
	/// </summary>
	/// <param name="position"></param>
	void remove(int position);
	/// <summary>
	/// updates the elements from the given pos
	/// </summary>
	/// <param name="position"></param>
	/// <param name="elToUpdate"></param>
	void update(int position, TElem elToUpdate);
	/// <summary>
	/// checks if there is another dog with the same information
	/// </summary>
	/// <param name="e"></param>
	/// <returns></returns>
	int testExistUnicity(TElem e);
	/// <summary>
	/// checks if there is another dog with the same name and breed
	/// </summary>
	/// <param name="breed"></param>
	/// <param name="name"></param>
	/// <returns></returns>
	int testExistByBreedAndName(const std::string& breed, const std::string& name);
	/// <summary>
	/// gets the elements
	/// </summary>
	/// <returns></returns>
	TElem* getElement();
	///<summary>
	///destructor
	/// </summary>
	/// <returns></returns>
	~DynamicVector();
};

template<typename TElem>
inline DynamicVector<TElem>::DynamicVector(int capacity)
{
	if (capacity <= 0)
		throw "Incorrect capacity! ";
	this->size = 0;
	this->capacity = capacity;
	this->elems = new TElem[capacity];
}


//template<typename T>
//inline DynamicVector<T>& DynamicVector<T>::operator=(const DynamicVector& v)
//{
//	if (this == &v)
//		return *this;
//
//	this->size = v.size;
//	this->capacity = capacity;
//	delete[] this->elems;
//	this->elems = new T[this->capacity];
//	for (int i = 0; i < this->size; i++)
//		this->elems[i] = v.elems[i];
//
//	return *this;
//}

template<typename TElem>
inline void DynamicVector<TElem>::add(TElem elToAdd)
{
	if (this->size == this->capacity)
		this->resize();
	this->elems[this->size] = elToAdd;
	this->size++;
}

template<typename TElem>
inline int DynamicVector<TElem>::getSize() const
{
	return this->size;
}

template<typename TElem>
inline int DynamicVector<TElem>::getCap() const
{
	return this->capacity;
}

template<typename TElem>
inline TElem* DynamicVector<TElem>::getAllElements() const
{
	return this->elems;
}

template<typename TElem>
inline void DynamicVector<TElem>::remove(int position)
{
	for (int i = position; i < this->size-1; i++)
		this->elems[i] = this->elems[i + 1];
	this->size--;
}

template<typename TElem>
inline void DynamicVector<TElem>::update(int position, TElem elToUpdate)
{
	this->elems[position] = elToUpdate;
}

template<typename TElem>
inline int DynamicVector<TElem>::testExistUnicity(TElem e)
{
	for (int i = 0; i < this->size; i++)
	{
		if (this->elems[i].get_breed() == e.get_breed() && this->elems[i].get_name() == e.get_name())
			return i;
	}
	return -1;
}

template<typename TElem>
inline int DynamicVector<TElem>::testExistByBreedAndName(const std::string& breed, const std::string& name)
{
	for (int i = 0; i < this->size; i++)
	{
		if (this->elems[i].get_breed() == breed && this->elems[i].get_name() == name)
			return i;
	}
	return -1;
}

template<typename TElem>
inline TElem* DynamicVector<TElem>::getElement()
{
	return this->elems;
}

template<typename TElem>
inline void DynamicVector<TElem>::resize()
{
	auto* newElems = new TElem[this->capacity * 2];
	for (int i = 0; i < this->size; i++)
	{
		newElems[i] = this->elems[i];
	}
	delete[] this->elems;
	this->elems = newElems;
	this->capacity *= 2;
	/*this->capacity *= static_cast<int>(factor);

	T* els = new T[this->capacity];
	for (int i = 0; i < this->size; i++)
		els[i] = this->elems[i];

	delete[] this->elems;
	this->elems = els;*/
}


template<typename TElem>
inline DynamicVector<TElem>::~DynamicVector()
{
	delete[] this->elems;
}