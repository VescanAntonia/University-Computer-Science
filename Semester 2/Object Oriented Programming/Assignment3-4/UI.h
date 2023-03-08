#pragma once
#include "Controller.h"

typedef struct
{
	Controller* controller;
}UI;

/// <summary>
/// creates the user interface
/// </summary>
/// <param name="controller"></param>
/// <returns></returns>
UI* createUI(Controller* controller);

/// <summary>
/// destroys the user interface
/// </summary>
/// <param name="ui"></param>
void destroyUi(UI* ui);

/// <summary>
/// starts the aplication
/// </summary>
/// <param name="ui"></param>
void startUI(UI* ui);
