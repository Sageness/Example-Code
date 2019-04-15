//*****************************************************************
//  CppExampleProject.cpp
//  Created by: Sage Aucoin on August 16th, 2016
//*****************************************************************

#include "HashTable.h"

int main() {
	cout << "Hello Mr. Snee." << endl << "Thank you for taking the time to review some C++ code that I wrote." << endl;
	cout << "This example includes examples of two encapsulated classes as well as hash table functionality including adding, deleting and searching." << endl;
	cout << "I hope that you enjoy it!" << endl << "-----------------------------------------------------" << endl << "Press enter to proceed." << endl;
	cin.get();
	// Create 26 Items to store in the Hash Table.
	//The second part that is being set to NULL is the 'value' which will later be set to the next item in the list when it's added to the hash table.
	Item * A = new Item{ "Apple", NULL };
	Item * B = new Item{ "Banana", NULL };
	Item * C = new Item{ "Caterpillar", NULL };
	Item * D = new Item{ "Dog", NULL };
	Item * E = new Item{ "Elephant", NULL };
	Item * F = new Item{ "Fedora", NULL };
	Item * G = new Item{ "Goosebumps", NULL };
	Item * H = new Item{ "House", NULL };
	Item * I = new Item{ "Insects", NULL };
	Item * J = new Item{ "Jam", NULL };
	Item * K = new Item{ "Kite", NULL };
	Item * L = new Item{ "Limestone", NULL };
	Item * M = new Item{ "Mountaineering", NULL };
	Item * N = new Item{ "Night", NULL };
	Item * O = new Item{ "Open Sesame", NULL };
	Item * P = new Item{ "Potatoes", NULL };
	Item * Q = new Item{ "Quantum Mechanics", NULL };
	Item * R = new Item{ "Rrrrrrrrrrawr", NULL };
	Item * S = new Item{ "Snakes", NULL };
	Item * T = new Item{ "Tizzy Tube", NULL };
	Item * U = new Item{ "Underworld", NULL };
	Item * V = new Item{ "Volcanic Ash", NULL };
	Item * W = new Item{ "Who When What Why", NULL };
	Item * X = new Item{ "XXX", NULL };
	Item * Y = new Item{ "Yellow", NULL };
	Item * Z = new Item{ "Zest of Lemon", NULL };

	// Create a Hash Table of 13 Linked List elements.
	HashTable table;

	cout << "Adding 3 Items (\"Apple\", \"Banana\", \"Caterpillar\") to Hash Table." << endl;
	table.insertItem(A);
	table.insertItem(B);
	table.insertItem(C);
	cout << "Now let's print our table." << endl << "Press enter to print the table." << endl;
	cin.get();
	table.printTable();
	cout << "Press enter to proceed and print the histogram to show which buckets in our hash table were filled." << endl;
	cin.get();
	table.printHistogram();
	cout << "Now let's try to delete a row from our hash table." << endl << "Press enter to remove \"Apple\" from the table." << endl;
	cin.get();
	table.removeItem("Apple");
	cout << "The item was successfully removed! Let's print the table to make sure!" << endl << "Press enter to print the table." << endl;
	cin.get();
	table.printTable();
	cout << "Notice that \"Apple\" has been removed!!! How exciting!!!" << endl << "Press enter to print the table histogram." << endl;
	cin.get();
	table.printHistogram();
	cin.get();
	cout << "Now let's get a little crazy and add 23 items to our hashtable and search it using one of the keys." << endl << "Press enter to proceed and print the results." << endl;
	cin.get();

	// Add 23 items to Hash Table.
	table.insertItem(D);
	table.insertItem(E);
	table.insertItem(F);
	table.insertItem(G);
	table.insertItem(H);
	table.insertItem(I);
	table.insertItem(J);
	table.insertItem(K);
	table.insertItem(L);
	table.insertItem(M);
	table.insertItem(N);
	table.insertItem(O);
	table.insertItem(P);
	table.insertItem(Q);
	table.insertItem(R);
	table.insertItem(S);
	table.insertItem(T);
	table.insertItem(U);
	table.insertItem(V);
	table.insertItem(W);
	table.insertItem(X);
	table.insertItem(Y);
	table.insertItem(Z);
	table.printTable();
	cout << "Looks great! Now lets print the histogram." << endl;
	cin.get();
	table.printHistogram();
	cout << "Let's try to find the item at the key \"Snakes\"." << endl;
	cin.get();
	Item * result = table.getItemByKey("Snakes");
	cout << "The value at key \"Snakes\" is: " << result->key << endl;
	cout << "Thank you for checking out my hash table C++ code example. I hope that you enjoyed it." << endl << "Hope to hear from you soon," << endl << "Sage Aucoin";
	cin.get();
	return 0;
}

