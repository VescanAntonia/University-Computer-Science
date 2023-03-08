#include "Domain.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>


Offer* createOffer(char* type, char* destination, double price, int day, int month, int year)
{
    Offer* offer = (Offer*)malloc(sizeof(Offer));
    if (offer == NULL)
        return NULL;
    offer->type = malloc(sizeof(char) * (strlen(type) + 1));
    if (offer->type != NULL)
        strcpy(offer->type, type);
    offer->destination = malloc(sizeof(char) * (strlen(destination) + 1));
    if (offer->destination != NULL)
        strcpy(offer->destination, destination);

    offer->price = price;
    offer->day = day;
    offer->month = month;
    offer->year = year;


    return offer;
}

void destroyOffer(Offer* offer)
{
    if (offer == NULL)
        return;
    // free the memory which was allocated for the component fields
    free(offer->type);
    free(offer->destination);
    
    //free the memory which was allocated for the offer structure
    free(offer);
}

char* getType(Offer* offer)
{
    if (offer == NULL)
        return NULL;
    return  offer->type;
}

char* getDestination(Offer* offer)
{
    if (offer == NULL)
        return NULL;
    return offer->destination;
}

double getPrice(Offer* offer)
{
    if (offer == NULL)
        return -1;
    return offer->price;
}

int getDay(Offer* offer)
{
    if (offer == NULL)
        return -1;
    return offer->day;
}

int getMonth(Offer* offer)
{
    if (offer == NULL)
        return -1;
    return offer->month;
}

int getYear(Offer* offer)
{
    if (offer == NULL)
        return -1;
    return offer->year;
}

void toString(Offer* offer, char str[])
{
    if (offer == NULL)
        return NULL;
    sprintf(str, " Vacatiton type:%s Destination: %s Price: %.2lf. Day: %d Month: %d Year: %d ", offer->type, offer->destination, offer->price, offer->day, offer->month, offer->year); //sends formatted output to a string pointed to, by str.
}

Offer* copy_offer(Offer* offer)
{
    Offer* new_offer = createOffer(offer->type, offer->destination, offer->price, offer->day, offer->month, offer->year);
    return new_offer;
}


