//*****************************************************************
//  LinkedList.h
//  HashTable
//  Created by: Sage Aucoin on August 16th, 2016
//*****************************************************************

#ifndef LinkedList_h
#define LinkedList_h

#include <iostream>
#include <string>
using namespace std;

// List items are my way of implementing key value pairs in C++. They are basically a key with a pointer to the next item in the list.
struct Item{
	string key;
	Item * next;
};

class LinkedList{
	private:
		// Reference to list of data nodes.
		Item * head;

		// Holds the number of nodes in the list.
		int length;

	public:
		// Create the "head" node and init length to 0.
		LinkedList();

		// Places item at the end of the list.
		void insertItem(Item * newItem);

		// Removes itemKey from list.
		bool removeItem(string itemKey);

		// Searches for item with matching itemKey. Returns reference if something is found. If not, returns NULL pointer.
		Item * getItem(string itemKey);

		// Print out the contents of the list to the console.
		void printList();

		// Get the length of the list.
		int getLength();

	~LinkedList();
};
#endif