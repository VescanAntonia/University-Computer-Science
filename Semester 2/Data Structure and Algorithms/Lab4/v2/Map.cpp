
#include "Map.h"
#include "MapIterator.h"


Map::Map() {

    // tetha(1)
    // 
    // constructor
    this->capacity = 10;
    this->elems = DynamicVector<Node>(this->capacity + 1);
    // we keep the head and tail of the list, as well as the index of the first empty node
    this->head = -1;
    this->tail = -1;
    this->firstEmpty = 1;
    // set the corresponding links for keeping track of empty nodes. At the beginning all the nodes are empty and
    // the next field points to the next empty node
    for(int i = 1; i< this->capacity; i++)
        this->elems[i].next = i + 1;
    this->elems[this->capacity].next = -1;
}

TValue Map::add(TKey c, TValue v){
    // O(n)
    int indexOfKey = this->searchindex(c);
    // if the key already exists in the map, we update its value and return its old value
    if(indexOfKey != -1)
    {
        auto oldValue = this->elems[indexOfKey].value.second;
        this->elems[indexOfKey].value.second = v;
        return oldValue;
    }
    // allocate a new element at a given index
    int indexOfNewElement = this->allocate();
    //if we couldn't allocate a new element (array is full), then resize and allocate again
    if(indexOfNewElement == -1){
        this->resize();
        indexOfNewElement = this->allocate();
    }
    // if we managed to allocate a new element
    if(indexOfNewElement != -1) {
        // create a TElem and store it in the newly allocated element
        TElem newElement;
        newElement.first = c;
        newElement.second = v;
        this->elems[indexOfNewElement].value = newElement;
        // add the element at the end
        // set the links accordingly
        // if the list is empty, add the element at the end and that's it
        if (this->tail == -1) {
            this->tail = indexOfNewElement;
            this->elems[indexOfNewElement].next = -1;
        }
        // otherwise, (element is not tail) set the links accordingly. the element gets added at the end
        else{
            this->elems[this->tail].next = indexOfNewElement;
            this->elems[indexOfNewElement].next = -1;
            this->tail = indexOfNewElement;
        }
        // increase the size
        this->elems.actualSize++;
    }
    // if the head is also -1, set the head to the new element
    if(this->head == -1)
        this->head = indexOfNewElement;
    return NULL_TVALUE;
}

TValue Map::search(TKey c) const{
    //BC tetha(1), WC tetha(n), AC O(n)
    int current = this->head;
    while(current != -1 && this->elems[current].value.first != c)
        current = this->elems[current].next;
    if(current != -1)
        return this->elems[current].value.second;
    return NULL_TVALUE;
}

TValue Map::remove(TKey c){
    // O(n)
    int indexOfKey = this->searchindex(c);
    // if we found the element
    if(indexOfKey != -1){
        // if the element is both tail and head, we just make the list empty (head = tail = -1)
        if(indexOfKey == this->head && indexOfKey == this->tail)
        {
            this->head = -1;
            this->tail = -1;
        }
        // otherwise, if it is only head, we set the head to be next element.
        else if(indexOfKey == this->head) {
            this->head = this->elems[head].next;
        }

        else if(indexOfKey == this->tail){
            this->tail = this->getprev(tail);
            this->elems[tail].next = -1;
        }
        // otherwise (the element is neither tail nor head), set the links accordingly.
        else{
            int previousNode = this->getprev(indexOfKey);
            int nextNode = this->elems[indexOfKey].next;
            this->elems[previousNode].next = nextNode;
        }
        // save the old value to return it
        auto oldValue = this->elems[indexOfKey].value.second;
        // free the node
        this->free(indexOfKey);
        // decrease the size
        this->elems.actualSize --;
        // return the old value
        return  oldValue;
    }
    // if the list is empty after removing the element, we set the index of first empty and make the links between
    // empty nodes
    if(this->size() == 0)
    {
        this->head = -1;
        this->tail = -1;
        this->firstEmpty = 1;
        for(int i = 1; i< this->capacity; i++)
            this->elems[i].next = i + 1;
        this->elems[this->capacity].next = -1;
    }
    return NULL_TVALUE;
}


int Map::size() const {
    // tetha(1)
    return this->elems.actualSize;
}

bool Map::isEmpty() const{
    // tetha(1)
    return this->elems.actualSize == 0;
}

MapIterator Map::iterator(){
    // tetha(1)
    return MapIterator(*this);
}

int Map::updateValues(Map& m)
{
    //O(n)
    int count = 0;
    int current = m.head;
    while (current != -1)
    {
        if (m.search(this->elems[current].value.first)!=-1)
        {
            int indexOfKey = this->searchindex(m.search(this->elems[current].value.first));
            auto oldValue = this->elems[indexOfKey].value.second;
            int indexOfNewValue = m.searchindex(m.search(this->elems[current].value.first));
            auto newValue = m.elems[indexOfNewValue].value.second;
            this->elems[indexOfKey].value.second = m.elems[indexOfNewValue].value.second;
            count++;
        }
        current = this->elems[current].next;
    }
    return count;
}


int Map::allocate() {
    // tetha(1)
    // we allocate the new node at the index of the first empty node
    int newElement = this->firstEmpty;
    // if there is an empty node
    if(newElement != -1) {
        // we set the first empty node to the next one
        this->firstEmpty = this->elems[this->firstEmpty].next;
        // we remove the link of our newly allocated node
        this->elems[newElement].next = -1;
    }
    // returns its index
    return  newElement;
}

int Map::searchindex(TKey c) const
{
    // WC tetha(n) WC tetha(n) AC O(n)
    int current = this->head;
    while (current != -1 && this->elems[current].value.first != c)
        current = this->elems[current].next;
    return current;
}

void Map::free(int position) {
    // tetha(1)
    this->elems[position].next = this->firstEmpty;
    this->firstEmpty = position;
}


void Map::resize() {
    // O(n)
    // resize the array
    this->elems.resize();
    // save the old capacity
    int oldCapacity = this->capacity;
    // update the capacity
    this->capacity *= 2;
    // initialize the links of the empty nodes
    for(int i = oldCapacity + 1; i < this->capacity; i++) {
        this->elems[i].next = i + 1;
    }
    this->elems[this->capacity - 1].next = -1;
    // first empty element will be the first newly allocated node
    this->firstEmpty = oldCapacity + 1;
}

int Map::getprev(int index) {
    //O(n)
    int current = this->head;
    // search for and return previous element of a given index
    while(current != -1 && this->elems[current].next != index)
        current = this->elems[current].next;
    if(current != -1)
        return current;
    return NULL_TVALUE;
}
