//*****************************************************************
//  HashTable.cpp
//  HashTable
//  Created by: Sage Aucoin on August 16th, 2016
//*****************************************************************

#include "HashTable.h"

HashTable::HashTable(int len) {
	// Let's keep the array size at 13 for this example.
	if (len <= 0) len = 13;
	array = new LinkedList[len];
	length = len;
}

// Returns an array location a.k.a. 'bucket' for a given item key.
int HashTable::hash(string itemKey) {
	int value = 0;
	for (int i = 0; i < itemKey.length(); i++)
		value += itemKey[i];
	return (value * itemKey.length()) % length;
}

// Add item to the Hash Table.
void HashTable::insertItem(Item * newItem) {
	int index = hash(newItem->key);
	array[index].insertItem(newItem);
}

// Deletes itemKey from Hash Table.
bool HashTable::removeItem(string itemKey) {
	int index = hash(itemKey);
	return array[index].removeItem(itemKey);
}

// Retrieve item from hash table that has the provided key.If no item is found, then return null pointer.
Item * HashTable::getItemByKey(string itemKey) {
	int index = hash(itemKey);
	return array[index].getItem(itemKey);
}

// Display table contents to console
void HashTable::printTable() {
	cout << endl << "Hash Table: " << endl;

	//Let's loop through the hash table and print all of the results.
	for (int i = 0; i < length; i++)
	{
		cout << "Bucket " << i + 1 << ": ";
		array[i].printList();
	}
	cout << endl;
}

// Prints a more visually friendly version of the hash table as a histogram that shows how many items are in each 'bucket'
void HashTable::printHistogram() {
	cout << endl << endl << "Hash Table Contains ";
	cout << getNumberOfItems() << " Items total" << endl;

	//Let's loop through the hash table and print all of the results.
	//Keep in mind that this is only really efficient for smaller tables since it's using O(n^2). If the function is running slow, reduce rows or just remove this feature.
	for (int i = 0; i < length; i++)
	{
		cout << i + 1 << ":\t";
		for (int j = 0; j < array[i].getLength(); j++)
			cout << " X";
		cout << endl;
	}
	cout << endl;
}

// Gets the count of 'buckets' in the hash table. I'm adding this in case we come up with a more dynamic solution for the size of the hash table.
int HashTable::getLength() {
	return length;
}

// Gets the count of items in the hash table.
int HashTable::getNumberOfItems() {
	int itemCount = 0;
	for (int i = 0; i < length; i++)
	{
		itemCount += array[i].getLength();
	}
	return itemCount;
}

// Destructor of all destructors.
HashTable::~HashTable() {
	delete[] array;
}