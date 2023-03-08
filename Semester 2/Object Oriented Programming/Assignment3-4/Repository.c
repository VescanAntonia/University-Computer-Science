#include "Repository.h"
#include <stdlib.h>
#include <string.h>
#include <assert.h>

//OfferRepository* createRepo()
//{
//    OfferRepository* repo = malloc(sizeof(OfferRepository));
//    if (repo == NULL)
//        return NULL;
//    repo->length = 0;
//
//    return repo;
//}

OfferRepository* createRepo()
{
    OfferRepository* repo = (OfferRepository*)malloc(sizeof(OfferRepository));
    if (repo == NULL)
        return NULL;

    repo->offers = CreateArray(20);
    if (repo->offers == NULL)
        return NULL;
    return repo;
}

void destroyRepo(OfferRepository* repo)
{
    // If we decide that the repository takes hold of the memory allocated for the planets, 
    // then first destroy all the planets in the repository
    //if (repo == NULL) 
      //  return;
    DestroyArray(repo->offers);
    //repo->array = NULL;
    free(repo);
}

int add(OfferRepository* repo, TElement t)
{
    //first checking for a offer with the same destination, then return 0 if there exists one or adds the offer otherwise
    
    /*/for (int i = 0; i < repo->length; i++) {
        if ((strcmp(repo->offers[i]->destination, offer->destination) == 0) && ((repo->offers[i]->day==offer->day)&&(repo->offers[i]->month== offer->month)&&(repo->offers[i]->year== offer->year))) {
            return 0;
        }
    }
    repo->offers[repo->length] = offer;
    repo->length++;
    return 1;*/
    if (search_by_destination(repo->offers, t->destination, t->day, t->month, t->year) == -1)
    {
        AddElement(repo->offers, t);
        return 1;
    }
    else
        return 0;
}

//int get_repo_length(OfferRepository* repo)
//{
//    return repo->length;
//}


int get_repo_length(OfferRepository* repo)
{
    return get_length(repo->offers);
}

Offer* get_element_position(OfferRepository* repo, int position)
{
 
    if (repo == NULL)
        return NULL;
    if (position < 0 || position >= repo->offers->length)
        return NULL;
    return repo->offers->elements[position];
    //return get(repo->offers, position);

}

//Offer* searchByDestAndDate(OfferRepository* repo, char* destination, int day, int month, int year)
//{
//    if (repo == NULL)
//        return NULL;
//    for (int i = 0; i < repo->length; i++) {
//        if (strcmp(repo->offers[i]->destination, destination) == 0 && repo->offers[i]->day == day && repo->offers[i]->month == month && repo->offers[i]->year == year)
//            return i;
//
//    }
//    return -1;
//}


Offer* deleteRepository(OfferRepository* repo, char* destination, int day, int month, int year)
{
    /*int pos = searchByDestAndDate(repo->offers, destination, day, month, year);
    if (pos == -1)
        return NULL;
    destroyOffer(repo->offers[pos]);
    for (int i = pos; i < repo->length; i++) {
        repo->offers[i] = repo->offers[i + 1];
    }
    repo->length--;
    return 1;*/
    int pos = search_by_destination(repo->offers, destination, day, month, year);
    if (pos == -1)
        return NULL;
    Offer* new_offer = copy_offer(repo->offers->elements[pos]);
    RemoveElement(repo->offers, pos);
    return new_offer;
}

Offer* updateRepository(OfferRepository* repo, TElement newElement)
{
    int position = search_by_destination(repo->offers, newElement->destination, newElement->day, newElement->month, newElement->year);
    //if (position < 0 || position >= repo->offers->length)
    if (position<0 || position>=repo->offers->length)
        return NULL;
    Offer* new_offer = copy_offer(repo->offers->elements[position]);
    update_array(repo->offers, position, newElement);
    //strcpy(repo->offers->elements[position]->type, t->type);
    //repo->offers->elements[position]->price = t->price;
    return new_offer;
}

//Offer* updateElement(OfferRepository* repo,char* type, char* destination, double price, int day, int month, int year)
//{
    /*int pos = searchByDestAndDate(repo->offers, destination, day, month, year);
    if (pos == -1)
        return NULL;
    strcpy(repo->offers[pos]->type , type);
    repo->offers[pos]->price = price;
    return 1;*/
//}


//Tests
void initOfferRepoForTests(OfferRepository* repo)
{
    //this function initializes the repo for the tests
    Offer* offer = createOffer("seaside", "Greece", 150, 2, 5, 2022);
    add(repo, offer);
}

void testAdd()
{
      //test for the add function
    OfferRepository* repo = createRepo();
    initOfferRepoForTests(repo);
    assert(get_repo_length(repo) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2022);
    assert(add(repo, offer) == 1);
    assert(get_repo_length(repo) == 2);

    assert(add(repo, offer) == 0);
    destroyRepo(repo);
}

void testdelete()
{
    //test for delete
    OfferRepository* repo = createRepo();
    initOfferRepoForTests(repo);
    assert(get_repo_length(repo) == 1);
    assert(deleteRepository(repo, "greece", 2, 5, 2022)==1);
    assert(get_repo_length(repo) == 0);
    assert(deleteRepository(repo, "greece", 2, 5, 2022) == 0);
    destroyRepo(repo);
}

void testupdate()
{
    //test for update
    OfferRepository* repo = createRepo();
    initOfferRepoForTests(repo);
    assert(get_repo_length(repo) == 1);
    //assert(deleteRepository(repo, "italy", 2, 5, 2022) == 0);
    destroyRepo(repo);
}

void testGetLength()
{
    OfferRepository* repo = createRepo();
    initOfferRepoForTests(repo);
    assert(get_repo_length(repo) == 1);
}
void testsOfferRepo()
{
    testAdd();
    testdelete();
    testupdate();
    testGetLength();
}