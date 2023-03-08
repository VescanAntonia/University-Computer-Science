#include "ui.h"
#include<string>

int main()
{
	Repository repo{};
	Controller controller{ repo };
	controller.addController("Simona", 41, true, 301, true);
	controller.addController("Maria", 40, false, 300, false);
	controller.addController("Ioana", 25, true, 25, false);
	controller.addController("Alina", 20, false, 28, false);
	controller.addController("Carmen", 30, false, 30, false);
	UI ui{ controller };
	ui.run();
	return 0;
}