#include <exception>
#include "ListIterator.h"
#include "IteratedList.h"

IteratedList::IteratedList() {
    this->linkedList.head = nullptr;
    this->sizeList = 0;
}

int IteratedList::size() const {
    return this->sizeList;
} // Theta(1)

bool IteratedList::isEmpty() const {
    if (this->sizeList == 0)
        return true;
    return false;
} // Theta(1)

ListIterator IteratedList::first() const {
    return ListIterator(*this);
} // Theta(1)

TElem IteratedList::getElement(ListIterator pos) const {
    return pos.getCurrent();
} // Theta(1)

TElem IteratedList::remove(ListIterator& pos) {
    // check if valid
    if (!pos.valid())
        throw std::exception();

    TElem elem = pos.currentElement->data;

    // search for prev node
    DLLNode* currentNode = this->linkedList.head;
    DLLNode* prevNode = nullptr;

    while (currentNode != nullptr && currentNode != pos.currentElement) {
        prevNode = currentNode;
        currentNode = currentNode->next;
    }

    // remove the current node
    if (currentNode != nullptr && prevNode == nullptr) // delete the head
        this->linkedList.head = this->linkedList.head->next;
    else if (currentNode != nullptr) {
        prevNode->next = currentNode->next;
        currentNode->next = nullptr;
    }

    this->sizeList--;
    return elem;
} //BC: pos is not valid, Theta(1). WC: we go to the end: Theta(n) => complexity: O(n)


ListIterator IteratedList::search(TElem e) const {
    ListIterator it = this->first();
    while (it.currentElement != nullptr) {
        if (it.currentElement->data != e)
            it.next();
        else
            break;
    }
    return it;
} // Complexity: O(n)


TElem IteratedList::setElement(ListIterator pos, TElem e) {
    if (!pos.valid())
        throw std::exception();
    TElem old = pos.getCurrent();
    pos.currentElement->data = e;
    return old;
} // Theta(1)

void IteratedList::addToBeginning(TElem e) {
    this->sizeList++;
    DLLNode* new_node = new DLLNode();

    /* 2. put in the data */
    new_node->data = e;

    /* 3. Make next of new node as head
    and previous as NULL */
    new_node->next = linkedList.head;
    new_node->prev = NULL;

    /* 4. change prev of head node to new node */
    if (linkedList.head != NULL)
        linkedList.head->prev = new_node;

    /* 5. move the head to point to the new node */
    linkedList.head = new_node;
}
 // Theta(1)

void IteratedList::addToPosition(ListIterator& pos, TElem e) {
    if (!pos.valid())
        throw std::exception();

    this->sizeList++;
    DLLNode* newNode = new DLLNode();
    newNode->data = e;
    newNode->next = NULL;
    newNode->prev = NULL;
    newNode->next = pos.currentElement->next;
    pos.currentElement->next = newNode;
    pos.next();
} // Theta(1)

void IteratedList::addToEnd(TElem e) {
    this->sizeList++;
    DLLNode* new_node = new DLLNode();

    DLLNode* last = linkedList.head; /* used in step 5*/

    /* 2. put in the data */
    new_node->data = e;

    /* 3. This new node is going to be the last node, so
        make next of it as NULL*/
    new_node->next = NULL;

    /* 4. If the Linked List is empty, then make the new
        node as head */
    if (linkedList.head == NULL)
    {
        new_node->prev = NULL;
        linkedList.head = new_node;
        return;
    }

    /* 5. Else traverse till the last node */
    while (last->next != NULL)
        last = last->next;

    /* 6. Change the next of last node */
    last->next = new_node;

    /* 7. Make last node as previous of new node */
    new_node->prev = last;

  
}
//BC:theta(1), WC:theta(size)=>Complexity: O(n)

IteratedList::~IteratedList() {
    DLLNode* current = this->linkedList.head;
    while (current != nullptr) {
        DLLNode* next = current->next;
        delete current;
        current = next;
    }
} //BC:theta(1), WC:theta(size)=>Complexity: O(n)

// returns the last index of a given element
// if the element is not in the list it returns an invalid TPosition
ListIterator IteratedList::lastIndexOf(TElem elem) const {
    ListIterator it = this->first();
    ListIterator aux = this->first();
    aux.currentElement = nullptr;

    while (it.currentElement != nullptr) {
        if (it.currentElement->data == elem)
            aux.currentElement = it.currentElement;
        it.next();
    }
    return aux;
} // Best case: Theta(1) , when the list is empty. Worst case: Theta(size), when is not in the list.
// => Complexity O(size) < O(n)
