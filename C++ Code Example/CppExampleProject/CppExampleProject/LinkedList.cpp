//*****************************************************************
//  LinkedList.cpp
//  HashTable
//  Created by: Sage Aucoin on August 16th, 2016
//*****************************************************************

#include "LinkedList.h"

LinkedList::LinkedList() {
	//Implement head node
	head = new Item;
	head -> next = NULL;
	//Set length to 0
	length = 0;
}

// // Places item at the end of the list.
void LinkedList::insertItem(Item * newItem) {
	if (!head -> next)
	{
		head -> next = newItem;
		length++;
		return;
	}
	Item * firstItem = head;
	Item * secItem = head;
	while (secItem)
	{
		firstItem = secItem;
		secItem = firstItem -> next;
	}
	firstItem -> next = newItem;
	newItem -> next = NULL;
	length++;
}

//Removes itemKey from list.
bool LinkedList::removeItem(string itemKey) {
	if (!head -> next) return false;
	Item * firstItem = head;
	Item * secItem = head;
	while (secItem)
	{
		if (secItem -> key == itemKey)
		{	  
			firstItem -> next = secItem -> next;
			delete secItem;
			length--;
			return true;
		}
		firstItem = secItem;
		secItem = firstItem -> next;
	}
	return false;
}

// Searches for item with matching itemKey. Returns reference if something is found. If not, returns NULL pointer.
Item * LinkedList::getItem(string itemKey) {
	Item * firstItem = head;
	Item * secItem = head;
	while (secItem)
	{
		firstItem = secItem;
		if ((firstItem != head) && (firstItem -> key == itemKey))
			return firstItem;
		secItem = firstItem -> next;
	}
	return NULL;
}

// Print out the contents of the list to the console.
void LinkedList::printList() {
	if (length == 0)
	{
		cout << endl << "{ }" << endl;
		return;
	}
	Item * firstItem = head;
	Item * secItem = head;
	cout << endl << "{ ";
	while (secItem)
	{
		firstItem = secItem;
		if (firstItem != head)
		{
			cout << firstItem->key;
			if (firstItem -> next) cout << ", ";
			else cout << " ";
		}
		secItem = firstItem->next;
	}
	cout << "}" << endl;
}

// Get the length of the list.
int LinkedList::getLength() {
	return length;
}

// Destructor of all destructors!!!
LinkedList::~LinkedList() {
	Item * firstItem = head;
	Item * secItem = head;
	while (secItem)
	{
		firstItem = secItem;
		secItem = firstItem->next;
		if (secItem) delete firstItem;
	}
}