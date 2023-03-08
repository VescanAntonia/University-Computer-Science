#include "UI.h"
#include <stdio.h>
#include <stdlib.h>

UI* createUI(Controller* controller)
{
	UI* ui = (UI*)malloc(sizeof(UI));
	if (ui == NULL)
		return NULL;
	ui->controller = controller;
	return ui;
}

void destroyUi(UI* ui)
{
	if (ui == NULL)
		return;
	//first destroy the service
	destroyController(ui->controller);
	//free the UI memory
	free(ui);

}


int addUi(UI* ui)
{
	char type[50], destination[50];
	double price = 0;
	int day = 0, month = 0, year = 0;

	printf("Please input the type: ");
	int scanf_result = scanf("%49s", type);

	printf("Please input the destination: ");
	scanf_result = scanf("%49s", destination);         //reads the data

	printf("Please input the price: ");
	scanf_result = scanf("%lf", &price);

	printf("Please input the day: ");
	scanf_result = scanf("%d", &day);

	printf("Please input the month: ");
	scanf_result = scanf("%d", &month);

	printf("Please input the year: ");
	scanf_result = scanf("%d", &year);

	return add_new_offer(ui->controller, type, destination, price, day, month, year);
}

void deleteUi(UI* ui)
{
	char destination[50];
	int day = 0, month = 0, year = 0;
	printf("Please input the destination you would like to delete: ");
	int result = scanf("%49s", destination);

	printf("Please input the day: ");
	result = scanf("%d", &day);

	printf("Please input the month: ");
	result = scanf("%d", &month);

	printf("Please input the year: ");
	result = scanf("%d", &year);

	int deleted = deleteOffer(ui->controller, destination, day, month, year);
	if (deleted == 0)
		printf("Can't be deleted!");
	else
		printf("Deleted successfully!");
}

/// <summary>
/// updates a given offer
/// </summary>
/// <param name="ui"></param>
void updateUi(UI* ui)
{
	char type[50],destination[50];
	double price=0;
	int day = 0, month = 0, year = 0;
	printf("Please input the destination you would like to update: ");
	int result = scanf("%49s", destination);

	printf("Please input the day: ");
	result = scanf("%d", &day);

	printf("Please input the month: ");
	result = scanf("%d", &month);

	printf("Please input the year: ");
	result = scanf("%d", &year);


	printf("Please input the type to be updated: ");
	result = scanf("%49s", type);

	printf("Please input the price to be updated: ");
	result = scanf("%lf", &price);
	int updated = updateOffer(ui->controller,type, destination, price, day, month, year);
	if (updated == 0)
		printf("Can't be updated!");
	else
		printf("Updated successfully!");

}

void printMenu()
{
	printf("\n**********************************************************\n");
	printf("1 - add an offer.\n");
	printf("2 - list all offers.\n");
	printf("3 - delete an offer.\n");
	printf("4 - update an offer.\n");
	printf("5 - display all offers whose destination contain a given string sorted by price.\n");
	printf("6 - Display all offers of a given type, having their departure after a given date. \n");
	printf("7 - Undo.\n");
	printf("8 - Redo. \n");
	printf("0 - to exit.\n");
	printf("**********************************************************\n");
}



int readIntegerNumber(const char* message)
{
	char s[16] = { 0 };
	int res = 0;
	int flag = 0;
	int r = 0;

	while (flag == 0)
	{
		printf(message);
		int scanf_result = scanf("%15s", s);

		r = sscanf(s, "%d", &res);	// reads data from s and stores them as integer, if possible; returns 1 if successful
		flag = (r == 1);
		if (flag == 0)
			printf("Error reading number!\n");
	}
	return res;
}

void listAllOfferts(UI* ui)
{
	if (ui == NULL)
		return;
	OfferRepository* repo = get_repo(ui->controller);
	if (repo == NULL)
		return;

	for (int i = 0; i < get_repo_length(repo); i++)
	{
		//Offer* offer = get_element_position(repo, i);
		char OfferString[200];
		toString(repo->offers->elements[i], OfferString);
		printf("%d. %s\n",i+1, OfferString);
	}
}

//void filterByDestination(UI* ui)
//{
//	char str[50], s[170];
//	printf("Insert the word to look for into the destinations: ");
//	int res = scanf("%s", str);
//	if (strcmp(str, "null") == 0)
//		listAllOfferts(ui);
//	else
//	{
//		int i;
//		OfferRepository* repo = filterByKeyword(ui->serv, str);
//		if (get_repo_length(repo) == 0)
//			printf("Sorry, no matching strings. \n");
//		else
//		{
//			for(i=0;i<repo->length;i++)
//			{
//				toString(repo->offers[i], s);
//				printf("%s\n", s);
//			}
//		}
//	}
//}


void filterByDestination(UI* ui)
{
	char word[50], OfferString[100];
	printf("Insert the word to look for into the destinations: ");
	int res=scanf("%49s", word);
	if (strcmp(word, "null") == 0)
		listAllOfferts(ui);
	else
	{
		OfferRepository* repoToSort = filterByKeyword(ui->controller, word);
		if (get_repo_length == 0)
			printf(" There are no items matching the given string. ");
		else
		{
			repoToSort = sort_repository(ui->controller, repoToSort);
			for (int i = 0; i < repoToSort->offers->length; i++)
			{
				
					toString(repoToSort->offers->elements[i], OfferString);
					printf("%d. %s\n", i + 1, OfferString);
				
			}
		}
	}
}

void filterByType(UI* ui)
{
	char given_type[50], MatchingStrings[100];
	int day, month, year;
	printf(" Insert the type the elements should have: ");
	int res2 = scanf("%49s", given_type);
	printf(" Insert the day: ");
	res2 = scanf("%d", &day);
	printf(" Insert the month: ");
	res2 = scanf("%d", &month);
	printf(" Insert the year: ");
	res2 = scanf("%d", &year);
	for (int j = 0; j < ui->controller->repo->offers->length; j++)
	{
		if (strstr(ui->controller->repo->offers->elements[j]->type, given_type) != NULL && ((ui->controller->repo->offers->elements[j]->day > day && ui->controller->repo->offers->elements[j]->month >= month && ui->controller->repo->offers->elements[j]->year >= year) || (ui->controller->repo->offers->elements[j]->day < day && ui->controller->repo->offers->elements[j]->month > month && ui->controller->repo->offers->elements[j]->year >= year) || (ui->controller->repo->offers->elements[j]->day <= day && ui->controller->repo->offers->elements[j]->month <= month && ui->controller->repo->offers->elements[j]->year > year)))
		{
			toString(ui->controller->repo->offers->elements[j], MatchingStrings);
			printf("%d. %s\n", j + 1, MatchingStrings);
		}
	}
}

int validCommand(int command)
{
	if (command >= 0 && command <= 8)
		return 1;
	return 0;
}

void startUI(UI* ui)
{
	while (1)
	{
		printMenu();
		int command=readIntegerNumber("Input command: ");
		while (validCommand(command) == 0)
		{
			printf("Please input a valid comand!\n");
			command = readIntegerNumber("Input command: ");
		}
		if (command == 0)
		{
			break;
		}
		switch (command)
		{
		case 1:
		{
			int res = addUi(ui);
			if (res == 1)
				printf("Offer successfully added.\n");
			else
				printf("Error! Offer could not be added. ");
			break;
		}
		case 2:
		{
			listAllOfferts(ui);
			break;
		}
		case 3:
		{
			deleteUi(ui);
			break;
		}
		case 4:
		{
			updateUi(ui);
			break;
		}
		case 5:
		{
			filterByDestination(ui);
			break;
		}
		case 6:
		{
			filterByType(ui);
			break;
		}
		case 7:
		{
			int res = undo(ui->controller);
			if (res == 0)
				printf(" Undo is not possible.");
			else
				printf(" Undo done successfully! ");
			break;
		}
		case 8:
		{
			int res = redo(ui->controller);
			if (res == 0)
				printf(" Redo is not possible.");
			else
				printf(" Redo done successfully! ");
			break;
		}
		}

	}
}
