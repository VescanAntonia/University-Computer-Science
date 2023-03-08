#pragma once
#include "Domain.h"
#include <stddef.h>

typedef Offer* TElement;

typedef struct
{
	int length;
	int capacity;
	TElement* elements;
}DynamicArray;

/// <summary>
/// Constructor for a DynamicArray object
/// </summary>
/// <param name="capacity">The capacity size of the DynamicArray</param>
/// <returns>The new DynamicArray object</returns>
DynamicArray* CreateArray(int capacity);

/// <summary>
/// Copy constructor for a DynamicArray object
/// </summary>
/// <param name="source">The array to be copied</param>
/// <returns>A copy of the given DynamicArray</returns>
///void DuplicateArray(DynamicArray source, DynamicArray* destination);

/// <summary>
/// Destructor for a DynamicArray
/// </summary>
/// <param name="array">The array to be destroyed</param>
void DestroyArray(DynamicArray* array);

/// <summary>
/// Reallocator for the dynamic array of a array
/// </summary>
/// <param name="array">The array to be modified</param>
void ReallocateArray(DynamicArray* array);

/// <summary>
/// Adds a new element to the DynamicArray
/// </summary>
/// <param name="array">The dynamic array where to add the element</param>
/// <param name="newElemnt">The new element to be added</param>
void AddElement(DynamicArray* array, TElement newElement);

/// <summary>
/// Removes an element from the DynamicArray
/// </summary>
/// <param name="array">The dynamic array from where to remove the element</param>
/// <param name="position">The position of the element</param>
void RemoveElement(DynamicArray* array, int position);

/// <summary>
/// Copies the elements of the source array in the destination array
/// </summary>
/// <param name="sourceArray">The source array</param>
/// <param name="destinationArray">The destination array</param>
//void Copy(DynamicArray sourceArray, DynamicArray* destinationArray);

/// <summary>
/// gets the length of the dynamic array
/// </summary>
/// <param name="array">The </param>
/// <returns></returns>
int get_length(DynamicArray* array);

/// <summary>
/// updates the given element as required by the user
/// </summary>
/// <param name="array"></param>
/// <param name="pos"></param>
/// <param name="new_element"></param>
void update_array(DynamicArray* array, int pos, TElement newElement);

/// <summary>
/// looks for the given destination and date in the dynamic array and returns the position
/// </summary>
/// <param name="array"></param>
/// <param name="destination"></param>
/// <param name="day"></param>
/// <param name="month"></param>
/// <param name="year"></param>
int search_by_destination(DynamicArray* array, char* destination, int day, int month, int year);