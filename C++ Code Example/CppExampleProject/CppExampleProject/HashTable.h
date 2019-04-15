//*****************************************************************
//  HashTable.h
//  HashTable
//  Created by: Sage Aucoin on August 16th, 2016
//*****************************************************************

#ifndef HashTable_h
#define HashTable_h

#include "LinkedList.h"

class HashTable{
	private:
		LinkedList * array;
		
		// This is going to hold the number of buckets in the array.
		int length;

		// Returns an array location a.k.a. 'bucket' for a given item key.
		int hash(string itemKey);

	public:

		//TODO: Come up with a more dynamic way of allocating array size.
		// Let's keep the array size at 13 for this example.
		HashTable(int len = 13);

		// Add item to the Hash Table.
		void insertItem(Item * newItem);

		// Deletes itemKey from Hash Table.
		bool removeItem(string itemKey);

		// Retrieve item from hash table that has the provided key. If no item is found, then return null pointer.
		Item * getItemByKey(string itemKey);

		// Display table contents to console
		void printTable();

		// Prints a more visually friendly version of the hash table as a histogram that shows how many items are in each 'bucket'
		void printHistogram();

		// Gets the count of 'buckets' in the hash table. I'm adding this in case we come up with a more dynamic solution for the size of the hash table.
		int getLength();

		// Gets the count of items in the hash table.
		int getNumberOfItems();

	~HashTable();
};

#endif