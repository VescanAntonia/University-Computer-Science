#include "Controller.h"
#include<stdlib.h>
#include <string.h>
#include <assert.h>

Controller* createController(OfferRepository* repo, OperationStack* undo_stack, OperationStack* redo_stack)
{
    Controller* controller = (Controller*)malloc(sizeof(Controller));
    if (controller == NULL)
        return NULL;
    controller->repo = repo;
    controller->undo_stack = undo_stack;
    controller->redo_stack = redo_stack;

    return controller;
}

void destroyController(Controller* controller)
{
    if (controller == NULL) 
        return;
    //first destroy the repository inside
    destroyRepo(controller->repo);
    //then free the memory
    free(controller);
}

//OfferRepository* getRepo(Controller* controller)
//{
//    return controller->repo;
//}

OfferRepository* filterByKeyword(Controller* controller, char key[])
{
    OfferRepository* repo = createRepo();
    for (int i = 0; i < controller->repo->offers->length; i++)
        if (strstr(getDestination(controller->repo->offers->elements[i]), key) != NULL)
            add(repo, controller->repo->offers->elements[i]);
    return repo;
    /*OfferRepository* tosort = createRepo();
    for (int i = 0; i < controller->repo->length; i++)
        add(tosort, controller->repo->offers[i]);
    for (int i = 0; i < controller->repo->length; i++)
    {
        for (int j = 0; j < controller->repo->length; j++)
        {
            if (tosort->offers[i]->price > tosort->offers[j]->price)
            {
                void* aux = &tosort->offers[i];
                tosort->offers[i] = tosort->offers[j];
                tosort->offers[j] = aux;
            }
        }
    }
    return tosort;*/


    /*int j = 0, aux = 0;
    for (int i = 0; i < controller->repo->length-1; i++)
    {
        
        if (strstr(controller->repo->offers[i]->destination, word) != NULL)
        {
            if (controller == NULL)
                return NULL;
            *vector[j] = controller->repo->offers[i]->price;
            j++;
        }
    }
    for (int l=0; l < j-1; l++)
    {
        for (int k = l; k < j; k++)
        {
            if (*vector[l] > *vector[k]) { aux = *vector[l]; *vector[l] = *vector[k], *vector[k] = aux; }
        }
    }*/
}

OfferRepository* get_repo(Controller* controller)
{
    return controller->repo;
}

OfferRepository* sort_repository(Controller* controller, OfferRepository* repo)
{
    int i, j;
    Offer* aux;
    for (i = 0; i < repo->offers->length-1; i++)
    {
        for (j = i + 1; j < repo->offers->length; j++)
        {
            if (repo->offers->elements[i] > repo->offers->elements[j])
            {
                aux = repo->offers->elements[j];
                repo->offers->elements[j] = repo->offers->elements[i];
                repo->offers->elements[i] = aux;
            }
        }
    }
    return repo;
}

int undo(Controller* controller)
{
    if (controller->undo_stack->length == 0)
        return 0;
    Operation* op = pop(controller->undo_stack);
    Operation* redo_op = operation_copy(op);
    if (strcmp(get_operation_type(redo_op), "add") == 0)
        redo_op->type = "delete";
    else if (strcmp(get_operation_type(redo_op), "delete") == 0)
        redo_op->type = "add";

    if (strcmp(get_operation_type(op), "add") == 0) {
        Offer* offer = copy_offer(get_operation_offer(op));
        deleteRepository(controller->repo, offer->destination, offer->day, offer->month, offer->year);

    }
    else if (strcmp(get_operation_type(op), "delete") == 0) {
        Offer* offer = copy_offer(get_operation_offer(op));
        add(controller->repo, offer);

    }
    else if (strcmp(get_operation_type(op), "update") == 0) {
        Offer* offer = copy_offer(get_operation_offer(op));
        redo_op->offer = copy_offer(updateRepository(controller->repo, offer));
    }
    push(controller->redo_stack, redo_op);
    destroy_operation(redo_op);
    destroy_operation(op);
    return 1;

}

int redo(Controller* controller)
{
    if (controller->redo_stack->length == 0)
        return 0;
    Operation* op = pop(controller->redo_stack);
    Operation* undo_op = operation_copy(op);
    if (strcmp(get_operation_type(undo_op), "add") == 0)
        undo_op->type = "delete";
    else if (strcmp(get_operation_type(undo_op), "delete") == 0)
        undo_op->type = "add";

    if (strcmp(get_operation_type(op), "add") == 0) {
        Offer* offer = copy_offer(get_operation_offer(op));
        deleteRepository(controller->repo, offer->destination, offer->day, offer->month, offer->year);

    }
    else if (strcmp(get_operation_type(op), "delete") == 0) {
        Offer* offer = copy_offer(get_operation_offer(op));
        add(controller->repo, offer);

    }
    else if (strcmp(get_operation_type(op), "update") == 0) {
        Offer* offer = copy_offer(get_operation_offer(op));
        undo_op->offer = copy_offer(updateRepository(controller->repo, offer));
    }
    push(controller->undo_stack, undo_op);
    destroy_operation(undo_op);
    destroy_operation(op);
    return 1;
}

int add_new_offer(Controller* controller, char* type, char* destination, double price, int day, int month, int year)
{
    Offer* offer = createOffer(type,destination,price, day, month, year);
    
    int res = add(controller->repo, offer);
    if (res == 0)    //if the offer was not added destroy it
        destroyOffer(offer);
    if (res == 1)
    {
        Operation* op = create_operation(offer, "add");
        push(controller->undo_stack, op);
        destroy_operation(op);
        destroy_operation_stack(controller->redo_stack);
        controller->redo_stack = create_operation_stack();

    }
    
    return res;
}

int deleteOffer(Controller* controller, char* destination, int day, int month, int year)
{
    Offer* res = deleteRepository(controller->repo, destination,day,month,year); 
    if (res != NULL) {
        Operation* op = create_operation(res, "delete");
        push(controller->undo_stack, op);
        destroy_operation(op);
        destroy_operation_stack(controller->redo_stack);
        controller->redo_stack = create_operation_stack();
        return 1;
    }
    return 0;
}

int updateOffer(Controller* controller, char* type, char* destination, double price, int day, int month, int year)
{
    Offer* new_offer = createOffer(type, destination, price, day, month, year);
 
    Offer* res = updateRepository(controller->repo, new_offer);
    if (res != NULL) {
        Operation* op = create_operation(res, "update");
        push(controller->undo_stack, op);
        destroy_operation(op);
        destroy_operation_stack(controller->redo_stack);
        controller->redo_stack = create_operation_stack();
        return 1;
    }
    return 0;
}

void initOfferControllerForTests(Controller* controller)
{
    //this function initializes the repo for the tests
    Offer* offer = createOffer("seaside", "Greece", 150, 2, 5, 2022);
    add(controller->repo, offer);
}

void testUndo()
{
    //test for the add function
    OfferRepository* repo = createRepo();
    OperationStack* undo_stack = create_operation_stack();
    OperationStack* redo_stack = create_operation_stack();
    Controller* controller = createController(repo, undo_stack, redo_stack);
    initOfferControllerForTests(repo);
    assert(get_repo_length(repo) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2022);
    assert(add(repo, offer) == 1);
    undo(controller);
    assert(get_repo_length(repo) == 0);
    destroyRepo(repo);
    destroyController(controller);
}

void testRedo()
{
    OfferRepository* repo = createRepo();
    OperationStack* undo_stack = create_operation_stack();
    OperationStack* redo_stack = create_operation_stack();
    Controller* controller = createController(repo, undo_stack, redo_stack);
    initOfferControllerForTests(repo);
    assert(get_repo_length(repo) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2022);
    assert(add(repo, offer) == 1);
    undo(controller);
    assert(get_repo_length(repo) == 0);
    redo(controller);
    assert(get_repo_length(repo) == 1);
    destroyRepo(repo);
    destroyController(controller);
}

void testSortRepo()
{
    OfferRepository* repo = createRepo();
    OperationStack* undo_stack = create_operation_stack();
    OperationStack* redo_stack = create_operation_stack();
    Controller* controller = createController(repo, undo_stack, redo_stack);
    initOfferControllerForTests(repo);
    assert(get_repo_length(repo) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2022);
    assert(add(repo, offer) == 1);
    sort_repository(controller, repo);
    assert(repo->offers->elements[0]->price==150);
    assert(repo->offers->elements[1]->price == 300);
    destroyRepo(repo);
    destroyController(controller);
}

void testFilterKeyboard()
{
    OfferRepository* repo = createRepo();
    OperationStack* undo_stack = create_operation_stack();
    OperationStack* redo_stack = create_operation_stack();
    Controller* controller = createController(repo, undo_stack, redo_stack);
    initOfferControllerForTests(repo);
    assert(get_repo_length(repo) == 1);
    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2022);
    assert(add(repo, offer) == 1);
    assert(get_repo_length(repo) == 2);
    filterByKeyword(controller, "Budapest");
    assert(get_repo_length(repo) == 1);
    destroyRepo(repo);
    destroyController(controller);
}

void testsOfferController()
{
    testUndo();
    testRedo();
    testSortRepo();
    testFilterKeyboard();
}
