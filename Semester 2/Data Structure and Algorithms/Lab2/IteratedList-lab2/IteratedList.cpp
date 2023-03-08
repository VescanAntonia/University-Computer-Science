#include "ListIterator.h"
#include "IteratedList.h"
#include <exception>
using namespace std;

IteratedList::IteratedList() {
	//theta(1)
	this->elms.head = nullptr;
	this->elms.tail = nullptr;
	this->nrElements = 0;
}

//IteratedList::IteratedList(int capacity) {
//	//theta(1)
//	this->elms.head = nullptr;
//	this->elms.tail = nullptr;
//	this->capacity = capacity;
//	this->nrElements = 0;
//}

int IteratedList::size() const {
	//theta(1)
	return this->nrElements;
}

bool IteratedList::isEmpty() const {
	//theta(1)
	return (this->size() == 0);
}

ListIterator IteratedList::first() const {
	//theta(1)
	return ListIterator(*this);
}

TElem IteratedList::getElement(ListIterator pos) const {
	//theta(1)
	return pos.getCurrent();
}

TElem IteratedList::remove(ListIterator& pos) {
	//BC: if the given pos is not valid, Theta(1); WC: we parse the whole list, so Theta(n) ; AC:O(n)
	if (!pos.valid())  //we check if pos is valid
		throw std::exception();

	TElem elem = pos.current->info;  //we take the current node for the given pos

	// search for the prev node
	Node* currentNode = this->elms.head;    //the current head of the node 
	Node* prevNode = nullptr;  //init the prev Node to null pointer

	while (currentNode != nullptr && currentNode != pos.current) {
		prevNode = currentNode;                                    //we remove changing the nodes position in the list
		currentNode = currentNode->next;
	}

	// we remove the current node
	if (currentNode != nullptr && prevNode == nullptr) // actually deleting the head
		this->elms.head = this->elms.head->next;     
	else if (currentNode != nullptr) { 
		prevNode->next = currentNode->next; //reallocating the nodes 
		currentNode->next = nullptr;
	}

	this->nrElements--; //decreasing the nr of elements beacause we removed one elements
	return elem;
	//TElem currentNode = pos.current->info;
	//DLL* crr = pos.current->info;
	/*Node* currentNode = this->elms.head;
	while(currentNode != nullptr && currentNode->info!= getElement(pos))
	{
		currentNode = currentNode->next;
	}
	bool deletedNode;
	if (currentNode != nullptr)
	{
		if (currentNode == this->elms.head)
		{
			if (currentNode == this->elms.tail)
			{
				this->elms.head = nullptr;
				this->elms.tail = nullptr;
			}
			else
			{
				this->elms.head = this->elms.head->next;
				this->elms.head->prev = nullptr;
			}
		if (currentNode == this->elms.tail)
		{
			this->elms.tail = this->elms.tail->prev;
			this->elms.tail->next = nullptr; 
		}
		else
		{
			currentNode->prev = currentNode->prev;
			currentNode->next = currentNode->next;
		}
		free(currentNode);
		deletedNode = true;

		}
		else
			deletedNode = false;
	}
	this->nrElements--;
	return pos.current->info;*/

}

ListIterator IteratedList::search(TElem e) const{

	//  O(n)
	ListIterator it = this->first();
	while (it.current != nullptr) {
		if (it.current->info != e)
			it.next();
		else
			break;
	}
	return it;
}

bool IteratedList::isFULL() const
{
	//theta(1)
	return (this->nrElements>=this->capacity);
}

TElem IteratedList::setElement(ListIterator pos, TElem e) {
	//O(1)
	if (!pos.valid())  // check if pos valid
		throw std::exception();
	Node* pn = pos.current; // get the current el on the given pos
	if (pn == nullptr) throw exception();
	else {
		TElem old;
		old = pn->info;   //we set the new node with the new info
		pn->info = e;
		return old;
	}
	this->elms.head->next;
}

void IteratedList::addToPosition(ListIterator& pos, TElem e) {
	//theta(1)
	if (!pos.valid())
		throw exception();
	
	//if (isFULL())
		//this->capacity = this->capacity * 2;
	
	this->nrElements++;
	Node* newNode = new Node();
	newNode->info = e;   //give the newNode the value of the el
	newNode->next = NULL; // give the next pointer the value null
	newNode->prev = NULL;   //do the same for the prev
	newNode->next = pos.current->next;  //give the next pointer the current next node
	pos.current->next = newNode;    //add the element to the given position
	pos.next();    //go to the next node using the iterator

	//Node* temp = new Node();
	//temp = this->elms.head;
	//int i = 1;
	//while (i < pos.list.nrElements - 1)
	//{
	//	temp = temp->next;
	//	i++;
	//}
}

void IteratedList::addToEnd(TElem e) {
	//BC:theta(1), WC:theta(nr elements); AC: O(n)
	//if (isFULL())
		//this->capacity = this->capacity * 2;
	this->nrElements++;
	Node* newNode = new Node();  //init a new node
	Node* last = elms.head;   //take the last one
	newNode->info = e;   //give the new node the info of the el
	newNode->next = NULL;  //give the  next ptr the null value
	/*newNode->info = e;
	newNode->next = nullptr;
	newNode->prev = nullptr;*/

	/*this->tail->next = newNode;
	newNode->prev = tail;
	tail = newNode;*/
	if (elms.head == NULL)  // If the Linked List is empty, then make the new node as head
	{
		newNode->prev = NULL;
		elms.head = newNode;
		return;
	}
	while (last->next != NULL)   //else we go through the whole list 
		last = last->next;
	last->next = newNode;  // change the next ptr of the last node 
	newNode->prev = last; // Make last node as previous of the new node
}

void IteratedList::addToBeginning(TElem e)
{
	//theta(1)
	Node* new_node = new Node();
	if (isFULL())
		this->capacity = this->capacity * 2;
	new_node->info = e;  //we put in the new node the given el info

	new_node->next = elms.head;
	new_node->prev = NULL;

	
	if (elms.head != NULL)  // change the previous head node to new node
		elms.head->prev = new_node;
	elms.head = new_node;  //move the value of the head to point to the new added node
	this->nrElements++;
	//Node* newNode = new Node();
	//newNode->info = e;
	////this->elms.head->prev = newNode;
	//newNode->next = elms.head;
	//newNode->prev = nullptr;
	//if (elms.head != nullptr)
	//	elms.head->prev = newNode;
	//elms.head = newNode;
	////this->elms.head = newNode;
	//this->nrElements++;
}

IteratedList::~IteratedList() {
	while (this->elms.head != nullptr) {
		Node* p = this->elms.head;
		this->elms.head = this->elms.head->next;
		delete p;
	}
}
