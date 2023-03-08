#pragma once


typedef struct
{
	char* type;
	char* destination;
	double price;
	int day, month, year;
} Offer;
/// <summary>
/// Constructor for an Offer object
/// </summary>
/// <param name="type">The type of the offer</param>
/// <param name="destination">The destination for the offer</param>
/// <param name="price">The price of the offer</param>
/// <param name="day">The day of the offer</param>
/// <param name="month">The month of the offer</param>
/// <param name="year">The year of the offer</param>
/// <returns></returns>
Offer* createOffer(char* type, char* destination, double price, int day, int month, int year);
void destroyOffer(Offer* offer); // the memory is freed

/// <summary>
/// Getter for the type of the offer
/// </summary>
/// <param name="offer"> An offer</param>
/// <returns>The type of the offer</returns>
char* getType(Offer* offer);

/// <summary>
/// Getter for the destination
/// </summary>
/// <param name="offer">An offer</param>
/// <returns>The destination of the offer</returns>
char* getDestination(Offer* offer);

/// <summary>
/// Getter for the price
/// </summary>
/// <param name="offer">An offer</param>
/// <returns>The price of the offer</returns>
double getPrice(Offer* offer);

/// <summary>
/// Getter for the day
/// </summary>
/// <param name="offer">An offer</param>
/// <returns>The day of the offer</returns>
int getDay(Offer* offer);

/// <summary>
/// Getter for the month
/// </summary>
/// <param name="offer">An offer</param>
/// <returns>The month of the offer</returns>
int getMonth(Offer* offer);

/// <summary>
/// Getter for the year
/// </summary>
/// <param name="offer">An offer</param>
/// <returns>The year of the offer</returns>
int getYear(Offer* offer);

/// <summary>
/// Turns the given items into a string
/// </summary>
/// <param name="offer">An offer</param>
/// <param name="str">The string</param>
/// <returns>the string</returns>
void toString(Offer* offer, char str[]);

///creates a copy of the given offer and returns it
Offer* copy_offer(Offer* offer);