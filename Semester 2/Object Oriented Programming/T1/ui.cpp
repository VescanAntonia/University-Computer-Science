#include "ui.h"
#include<string>
#include <iostream>
using namespace std;


void UI::run()
{
	while (true)
	{
		UI::print_menu();
		int command{ 0 };
		cout<< " Enter the command: " << endl;
		cin >> command;
		cin.ignore();
		if (command == 0)
			break;
		switch (command)
		{
		case 1:
			UI::list_ui();
			break;
		case 2:
			UI::remove_ui();
			break;
		}
	}
}

void UI::print_menu()
{
	cout << "0 - Exit. "<< endl;
	cout << " 1 - List. "<<endl;
	cout << " 2 - Remove. " << endl;
	cout << " 3 - Quarantine." << endl;
}

void UI::remove_ui()
{
	cout << " Insert the name of the patient you would like to remove: ";
	std::string name;
	getline(cin, name);
	int removed = this->ctrl.removeController(name);
	if (removed == 0)
		cout << "  Could not remove. ";
	else
		cout << " Removed successfully. ";
}

void UI::list_ui()
{
	Patient* patients = this->ctrl.get_patientscontroller();
	int nr = this->ctrl.getNRelController();
	if (nr == 0)
		cout << "No patients. ";
	for (int i = 0; i < nr; i++)
	{
		cout << i + 1 << "." << patients[i].convert() << endl;
	}
}
