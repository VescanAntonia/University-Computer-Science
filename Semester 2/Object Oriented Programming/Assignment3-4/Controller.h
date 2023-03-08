#pragma once
#include "Repository.h"
#include "Operation.h"

typedef struct 
{
	OfferRepository* repo;
	OperationStack* undo_stack;
	OperationStack* redo_stack;
}Controller;

/// <summary>
/// creates the controller for the offers
/// </summary>
/// <param name="repo">the repo for the offers</param>
/// <param name="undo_stack">the undo stack for the offers</param>
/// <param name="redo_stack">the redo stack for the offers</param>
/// <returns></returns>
Controller* createController(OfferRepository* repo, OperationStack* undo_stack, OperationStack* redo_stack);

/// <summary>
/// destroys the controller
/// </summary>
/// <param name="controller"></param>
void destroyController(Controller* controller); 
/// <summary>
/// adds a new offer to the array
/// </summary>
/// <param name="controller">Pointer to the Controller.
/// <param name="type">the type of the offer</param>
/// <param name="destination">the destination of the offer</param>
/// <param name="price">the price of the offer</param>
/// <param name="day">the day of the offer</param>
/// <param name="month">the month</param>
/// <param name="year">the year</param>
/// <returns>1 - if the offer was successfully added or 0 otherwise</returns>
int add_new_offer(Controller* controller, char* type, char* destination, double price, int day, int month, int year);

/// <summary>
/// removes an offer from the array
/// </summary>
/// <param name="controller"></param>
/// <param name="destination"></param>
/// <param name="day"></param>
/// <param name="month"></param>
/// <param name="year"></param>
/// <returns></returns>
int deleteOffer(Controller* controller, char* destination, int day, int month, int year);

/// <summary>
/// updates an offer with the information given by the user
/// </summary>
/// <param name="controller"></param>
/// <param name="type"></param>
/// <param name="destination"></param>
/// <param name="price"></param>
/// <param name="day"></param>
/// <param name="month"></param>
/// <param name="year"></param>
/// <returns></returns>
int updateOffer(Controller* controller, char* type, char* destination, double price, int day, int month, int year);
//OfferRepository* getRepo(Controller* controller);

/// <summary>
/// filters the repo by the given string returning the elements which destination match the given string
/// </summary>
/// <param name="controller"></param>
/// <param name="key"></param>
/// <returns></returns>
OfferRepository* filterByKeyword(Controller* controller, char key[]);

/// <summary>
/// return the repo
/// </summary>
/// <param name="controller"></param>
/// <returns></returns>
OfferRepository* get_repo(Controller* controller);

/// <summary>
/// sorts the repository by the price in ascending order
/// </summary>
/// <param name="controller"></param>
/// <param name="repo"></param>
/// <returns></returns>
OfferRepository* sort_repository(Controller* controller, OfferRepository* repo);

/// <summary>
/// undoes the last permormed operation
/// </summary>
/// <param name="controller"></param>
/// <returns></returns>
int undo(Controller* controller);

/// <summary>
/// redoes the last performed operation
/// </summary>
/// <param name="controller"></param>
/// <returns></returns>
int redo(Controller* controller);

void testsOfferController();
