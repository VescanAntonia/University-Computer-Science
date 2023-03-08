#include "Operation.h"

Operation* create_operation(Offer* offer, char* type)
{
    Operation* op = (Operation*)malloc(sizeof(Operation));
    op->offer = copy_offer(offer);
    op->type = (char*)malloc(sizeof(char) * strlen(type) + 1);
    strcpy(op->type, type);

    return op;
}

void destroy_operation(Operation* op)
{
    if (op == NULL)
        return;
    destroyOffer(op->offer);
    free(op);
}

Operation* operation_copy(Operation* op)
{
    Operation* new_op = create_operation(get_operation_offer(op), get_operation_type(op));
    return new_op;
}

char* get_operation_type(Operation* op)
{
    if (op == NULL)
        return -1;
    return op->type;
}

Offer* get_operation_offer(Operation* op)
{
    return op->offer;
}

OperationStack* create_operation_stack()
{
    OperationStack* stack = (OperationStack*)malloc(sizeof(OperationStack));
    stack->length = 0;
    return stack;
}

void destroy_operation_stack(OperationStack* stack)
{
    for (int i = 0; i < stack->length; i++)
    {
        destroy_operation(stack->operations[i]);
    }
    free(stack);
}

void push(OperationStack* stack, Operation* op)
{
    if (stack->length == 100)
        return;
    stack->operations[stack->length] = operation_copy(op);
    stack->length++;
}

Operation* pop(OperationStack* stack)
{
    if (stack->length == 0)
        return NULL;
    Operation* op = stack->operations[stack->length - 1];
    stack->length--;
    return op;
}
