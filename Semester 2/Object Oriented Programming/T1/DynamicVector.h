#pragma once
#include<string>
//#include <iterator>

template <typename T>
class DynamicVector
{
private:
	T* elems;
	int size;
	int capacity;

public:
	//constructor for a DynamicVector;
	DynamicVector(int capacity = 10);

	DynamicVector(const DynamicVector& vectorToCopy);
	~DynamicVector();

	DynamicVector& operator = (const DynamicVector& vectorToAssign);

	void add(const T& elToAdd);

	int getSize() const;
	T* getAllElements() const;
	void setSize(int s) { size = s; }

	void remove(int position);
	void update(int position, const T& elToUpdate);

	int testExistUnicity(T e);
	int testExistByName(const std::string& name);

private:
	void resize(double factor = 2);

	//public:
	//	class iterator
	//	{
	//	private:
	//		T* ptr;
	//	public:
	//
	//	};
};

template<typename T>
inline DynamicVector<T>::DynamicVector(int capacity)
{
	this->size = 0;
	this->capacity = capacity;
	this->elems = new T[capacity];
}

template<typename T>
inline DynamicVector<T>::DynamicVector(const DynamicVector& v)
{
	this->size = v.size;
	this->capacity = v.capacity;
	this->elems = new T[this->capacity];
	for (int i = 0; i < this->size; i++)
		this->elems[i] = v.elems[i];
}

template<typename T>
inline DynamicVector<T>::~DynamicVector()
{
	delete[] this->elems;
}

template<typename T>
inline DynamicVector<T>& DynamicVector<T>::operator=(const DynamicVector& v)
{
	if (this == &v)
		return *this;

	this->size = v.size;
	this->capacity = capacity;
	delete[] this->elems;
	this->elems = new T[this->capacity];
	for (int i = 0; i < this->size; i++)
		this->elems[i] = v.elems[i];

	return *this;
}

template<typename T>
inline void DynamicVector<T>::add(const T& elToAdd)
{
	if (this->size == this->capacity)
		this->resize();
	this->elems[this->size] = elToAdd;
	this->size++;
}

template<typename T>
inline int DynamicVector<T>::getSize() const
{
	return this->size;
}

template<typename T>
inline T* DynamicVector<T>::getAllElements() const
{
	return this->elems;
}

template<typename T>
inline void DynamicVector<T>::remove(int position)
{
	for (int i = position; i < this->size; i++)
		this->elems[i] = this->elems[i + 1];
	this->size--;
}

template<typename T>
inline void DynamicVector<T>::update(int position, const T& elToUpdate)
{
	this->elems[position] = elToUpdate;
}

template<typename T>
inline int DynamicVector<T>::testExistUnicity(T e)
{
	for (int i = 0; i < this->size; i++)
	{
		if (this->elems[i].get_breed() == e.get_breed() && this->elems[i].get_name() == e.get_name())
			return i;
	}
	return -1;
}

template<typename T>
inline int DynamicVector<T>::testExistByName(const std::string& name)
{
	for (int i = 0; i < this->size; i++)
		{
			if (this->elems[i].get_name() == name)
				return i;
		}
	return -1;
}

//template<typename T>
//inline int DynamicVector<T>::testExistByName(const std::string& breed, const std::string& name)
//{
//	for (int i = 0; i < this->size; i++)
//	{
//		if (this->elems[i].get_breed() == breed && this->elems[i].get_name() == name)
//			return i;
//	}
//	return -1;
//}

template<typename T>
inline void DynamicVector<T>::resize(double factor)
{
	this->capacity *= static_cast<int>(factor);

	T* els = new T[this->capacity];
	for (int i = 0; i < this->size; i++)
		els[i] = this->elems[i];

	delete[] this->elems;
	this->elems = els;
}