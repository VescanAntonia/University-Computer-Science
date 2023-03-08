#include "MultiMapIterator.h"
#include "MultiMap.h"


MultiMapIterator::MultiMapIterator(const MultiMap& c): col(c) {
	//TODO - Implementation
    for (int i = 0; i < col.hashSize; i++) {
        if (col.table[i] != nullptr) {
            this->currentHashPosition = i;
            break;
        }
    }
    // if the position was found, put the current on the first node and first value
    if (this->currentHashPosition < col.hashSize) {
        this->current = col.table[this->currentHashPosition];
        this->currentArrayPosition = 0;
    }
}

TElem MultiMapIterator::getCurrent() const{
	//TODO - Implementation
    if (!valid()) throw exception();
    return TElem{ this->current->key, this->current->values[this->currentArrayPosition] };
}

bool MultiMapIterator::valid() const {
	//TODO - Implementation
    return this->currentHashPosition < col.hashSize&& this->current != nullptr;
}

void MultiMapIterator::next() {
	//TODO - Implementation
    if (!valid())
        throw exception();
    // if there is a valid next node in the current linked list
    if (this->current->next != nullptr) {
        //  jump on the next node, if the current value is the last on the array
        if (this->currentArrayPosition == this->current->length - 1) {
            this->current = this->current->next;
            this->currentArrayPosition = 0;
        }
        else // else, just take the next value
            this->currentArrayPosition++;
    }
    else {
        // there is no next valid node in the linked list
        if (this->currentArrayPosition < this->current->length - 1)
            // there are values following in the array
            this->currentArrayPosition++;
        else { // the current array position is last position in the array
            this->currentHashPosition++;
            while (this->currentHashPosition < col.hashSize and col.table[this->currentHashPosition] == nullptr)
                // search for another hashPosition
                this->currentHashPosition++;
            if (this->currentHashPosition == col.hashSize)
                // no valid position found
                this->current = nullptr;
            else {
                // valid position found, select the first value
                this->current = col.table[this->currentHashPosition];
                this->currentArrayPosition = 0;
            }
        }
    }
}

void MultiMapIterator::first() {
	//TODO - Implementation
    for (int i = 0; i < col.hashSize; i++) {
        if (col.table[i] != nullptr) {
            this->currentHashPosition = i;
            break;
        }
    }
    // get the data of first node and first value
    this->current = col.table[this->currentHashPosition];
    this->currentArrayPosition = 0;
}

