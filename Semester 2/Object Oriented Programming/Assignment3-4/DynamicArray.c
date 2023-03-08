#include "DynamicArray.h"
#include <stdlib.h>
#include <stdio.h>

DynamicArray* CreateArray(int capacity)
{
    DynamicArray* array = (DynamicArray*)malloc(sizeof(DynamicArray));

    if (array == NULL)
        return NULL;

    array->elements = (TElement*)malloc(sizeof(TElement)*capacity);
    array->length = 0; 
    array->capacity = capacity;
    
    //if (array->elements == NULL)
    //{
      //  free(array);   //???
        //return NULL;
    //}

    return array;
}

//void DuplicateArray(DynamicArray source, DynamicArray* destination)
//{
//    TElement* ptr = realloc(destination->elements, source.maxLength * sizeof(TElement));
//    destination->elements = ptr;
//    if (destination->elements == NULL)
//    {
//        destination->maxLength = 0;
//        destination->length = 0;
//    }
//
//    Copy(source, destination);
//}

void DestroyArray(DynamicArray* array)
{
    //if (array == NULL)
      //  return NULL;

    free(array->elements);
    //array->elements = NULL;

    free(array);
}

void ReallocateArray(DynamicArray* array)
{
    array->capacity = array->capacity * 2;
    /*if (array->elements == NULL)
        return;
    TElement* elemPtr = array->elements;
    TElement* ptr = realloc(array->elements, newMaxLength * sizeof(TElement));
    array->maxLength = newMaxLength;
    array->elements = (TElement*)ptr;*/
}


void AddElement(DynamicArray* array, TElement newElement)
{
    //if (array == NULL)
      //  return;
   // if (array->elements == NULL)
     //   return;

    if (array->length == array->capacity)
        ReallocateArray(array);

    array->elements[array->length] = newElement;
    array->length++;
}

void RemoveElement(DynamicArray* array, int position)
{
    for (int i = position; i < array->length - 1; i++)
        array->elements[i] = array->elements[i + 1];
    array->length--;
    /*if (array == NULL)
        return;
    if (array->elements == NULL)
        return;

    if (position > array->length)
        return;
    for (size_t i = position + 1; i < array->length; ++i)
        array->elements[i - 1] = array->elements[i];

    array->length--;*/
}

int get_length(DynamicArray* array)
{
    return array->length;
}

void update_array(DynamicArray* array, int pos, TElement newElement)
{
    array->elements[pos] = newElement;
}

int search_by_destination(DynamicArray* array, char* destination, int day, int month, int year)
{
    if (array == NULL||destination == NULL)
    {
        return NULL;
    }
    for (int i = 0; i < array->length; i++) {
        if (strcmp( destination, array->elements[i]->destination) == 0 && day== array->elements[i]->day &&  month== array->elements[i]->month && year == array->elements[i]->year)
            return i;
    }
    return -1;
}

//TElement get(DynamicArray* array, int pos)
//{
//    return array->elements[pos];
//}
