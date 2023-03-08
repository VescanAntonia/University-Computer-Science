#include "Ui.h"

UI::UI(Service& service):service{service}
{
}

void UI::start()
{
	while (true)
	{
		this->printMenu();
		std::cout << "Command: ";
		int com;
		std::cin >> com;
		if (com == 0)
			break;
		else if (com == 1)
			this->addBuilding();
		else if (com == 2)
			this->printAll();
		else
			std::cout << "Inavalid command! "<<std::endl;
	}
}

void UI::printMenu()
{
	std::cout << "1 - Add a building. "<<std::endl;
	std::cout << "2 - List all buildings. "<<std::endl;
	std::cout << "3 - Get the ones to be restored."<<std::endl;
	std::cout << "4 - Get the ones to be demolished."<<std::endl;
	std::cout << "0 - Exit. "<<std::endl;
}

void UI::printAll()
{
	std::vector<Building*> myData = this->service.getAllBuildings();
	for (auto myData : myData)
	{
		if (myData->getType() == "block")
		{
			std::cout << *((Block*)myData);
		}
		else if (myData->getType() == "house")
		{
			std::cout << *((House*)myData);
		}
	}
}

void UI::addBuilding()
{
	std::cout << "Type: ";
	std::string type;
	std::cin >> type;
	Building* b = nullptr;
	if (type == "block")
	{
		b = new Block{};
		b->setType(type);
		std::cout << "Address,yeat,nr ap, oc ap: ";
		std::cin >> *((Block*)b);
		this->service.AddBuilding(b);
	}
	else if (type == "house")
	{
		b = new House{};
		b->setType(type);
		std::cout << "Adress,year,hist: ";
		std::cin >> *((House*)b);
		this->service.AddBuilding(b);

	}
	else std::cout << "Invalid type! ";
}

//UI::~UI()
//{
//}
