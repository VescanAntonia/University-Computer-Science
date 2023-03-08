#pragma once
#include <exception>


template <typename T>
class DynamicVector
{
    friend class Map;
    friend class MapIterator;
private:
    int capacity{}, actualSize{};
    T* vectorElements;

public:
    DynamicVector(int capacity = 10);
    DynamicVector(const DynamicVector& newVector);
    ~DynamicVector();
    T& operator[](int position);
    const T& operator[](int position) const;
    DynamicVector& operator=(const DynamicVector& newVector);
    void resize(int resizeFactor = 2);
};

// tetha(1)
template<typename T>
inline DynamicVector<T>::DynamicVector(int capacity)
{
    this->actualSize = 0;
    this->capacity = capacity;
    this->vectorElements = new T[capacity];
}

// tetha(n)
template<typename T>
inline DynamicVector<T>::DynamicVector(const DynamicVector& newVector)
{
    this->actualSize = newVector.actualSize;
    this->capacity = newVector.capacity;
    this->vectorElements = new T[this->capacity];
    for (int i = 0; i < this->capacity; i++)
        this->vectorElements[i] = newVector.vectorElements[i];
}


// tetha(1)
template<typename T>
inline DynamicVector<T>::~DynamicVector()
{
    delete[] this->vectorElements;
}

// tetha(1)
template<typename T>
inline T& DynamicVector<T>::operator[](int position)
{
    if(position >= this->capacity || position < 0)
        throw std::exception();
    return this->vectorElements[position];
}

// BC tetha(1) WC theta(n) AC O(n)
template<typename T>
inline DynamicVector<T>& DynamicVector<T>::operator=(const DynamicVector& newVector)
{
    if (this == &newVector)
        return *this;

    this->capacity = newVector.capacity;
    this->actualSize = newVector.actualSize;
    delete[] this->vectorElements;
    this->vectorElements = new T[this->capacity];
    for (int i = 0; i < this->capacity; i++)
        this->vectorElements[i] = newVector.vectorElements[i];

    return *this;
}


// O(n)
template<typename T>
inline void DynamicVector<T>::resize(int resizeFactor)
{
    int oldCapacity = this->capacity;
    this->capacity *= resizeFactor;
    T* newVector = new T[this->capacity];
    for (int i = 0; i < oldCapacity; i++)
        newVector[i] = this->vectorElements[i];
    delete[] this->vectorElements;
    this->vectorElements = newVector;
}

// tetha(1)
template<typename T>
const T &DynamicVector<T>::operator[](int position) const {
    if(position >= this->capacity || position < 0)
        throw std::exception();
    return this->vectorElements[position];
}