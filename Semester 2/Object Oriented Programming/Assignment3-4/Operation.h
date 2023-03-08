#include <stdio.h>
#include <stdlib.h>
#include "DynamicArray.h"

typedef struct
{
	Offer* offer;
	char* type;
}Operation;

/// <summary>
/// creates an operation to be later performed
/// </summary>
/// <param name="offer"></param>
/// <param name="type"></param>
/// <returns></returns>
Operation* create_operation(Offer* offer, char* type);

/// <summary>
/// destroys the operation freeing the memory
/// </summary>
/// <param name="op"></param>
void destroy_operation(Operation* op);

/// <summary>
/// returns a copy for the given operation
/// </summary>
/// <param name="op"></param>
/// <returns></returns>
Operation* operation_copy(Operation* op);

/// <summary>
/// returns a word which is the type of the operation(add, delete,update)
/// </summary>
/// <param name="op"></param>
/// <returns></returns>
char* get_operation_type(Operation* op);

/// <summary>
/// gets the offer of the given operation
/// </summary>
/// <param name="op"></param>
/// <returns></returns>
Offer* get_operation_offer(Operation* op);

typedef struct
{
	Operation* operations[100];
	int length;
}OperationStack;

/// <summary>
/// creates a stack for the operations
/// </summary>
/// <returns></returns>
OperationStack* create_operation_stack();

/// <summary>
/// destroys the stack for the operation freeing the memory
/// </summary>
/// <param name="stack"></param>
void destroy_operation_stack(OperationStack* stack);

/// <summary>
/// pushes an operation onto the stack
/// </summary>
/// <param name="stack"></param>
/// <param name="op"></param>
void push(OperationStack* stack, Operation* op);

/// <summary>
/// returns an operation from the stack and pops it
/// </summary>
/// <param name="stack"></param>
/// <returns></returns>
Operation* pop(OperationStack* stack);



