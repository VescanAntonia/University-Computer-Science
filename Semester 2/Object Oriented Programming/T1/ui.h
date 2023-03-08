#pragma once
#include "Controller.h"

class UI
{
private:
	Controller ctrl;
public:
	/// <summary>
	/// constructor for the ui
	/// </summary>
	/// <param name="c"></param>
	UI(const Controller& c) : ctrl(c) {};
	/// <summary>
	/// function for running the aplication
	/// </summary>
	void run();
private:
	/// <summary>
	/// printing the menufor the user
	/// </summary>
	static void print_menu();
	/// <summary>
	/// removes the given patient
	/// </summary>
	void remove_ui();
	/// <summary>
	/// list the list of patients
	/// </summary>
	void list_ui();
};