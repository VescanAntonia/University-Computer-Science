#pragma once
#include "DynamicArray.h"
#include <stddef.h>

typedef struct 
{
	DynamicArray* offers;
} OfferRepository;

/// <summary>
/// Creates an offer repository
/// </summary>
/// <returns></returns>
OfferRepository* createRepo();

/// <summary>
/// Destroys a given offer repository
/// </summary>
/// <param name="repo"></param>
void destroyRepo(OfferRepository* repo);

/// <summary>
/// Adds a given offer to the list of offers
/// </summary>
/// <param name="repo">the offer repository</param>
/// <param name="t">the element to be added</param>
/// <returns></returns>
int add(OfferRepository* repo, TElement t);

/// <summary>
/// returns the number of elements in the array
/// </summary>
/// <param name="repo">the offer repo</param>
/// <returns></returns>
int get_repo_length(OfferRepository* repo);


/*
	Returns the offer on the given position in the offer vector.
	Input:	repo - the offer repository;
			position - integer, the position;
	Output: the offer on the given potision, or an "empty" offer.
*/
//Offer* get_element_position(OfferRepository* repo, int position);


/// <summary>
/// deletes the the element with the given destination and date from the array
/// </summary>
/// <param name="repo">the offer repository</param>
/// <param name="destination">the destination of the offer</param>
/// <param name="day">the day of the offer</param>
/// <param name="month">the month of the given offer</param>
/// <param name="year">the year of the given offer</param>
/// <returns></returns>
Offer* deleteRepository(OfferRepository* repo, char* destination, int day, int month, int year);
/// <summary>
/// updates the given element in the array with the given price and type
/// </summary>
/// <param name="repo">the offer repository</param>
/// <param name="t">the element</param>
/// <returns></returns>
Offer* updateRepository(OfferRepository* repo, TElement t);
///tests for the repository
void testsOfferRepo();