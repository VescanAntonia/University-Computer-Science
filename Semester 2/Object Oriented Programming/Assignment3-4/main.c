#include "Repository.h"
#include "Controller.h"
#include "UI.h"
#include <crtdbg.h>

int main()
{
	//testsOfferRepo();
	OfferRepository* repo = createRepo();
	OperationStack* undo_stack = create_operation_stack();
	OperationStack* redo_stack = create_operation_stack();
	Controller* serv = createController(repo, undo_stack, redo_stack);
	add_new_offer(serv, "seaside", "Greece", 150, 2, 5, 2022);
	add_new_offer(serv, "seaside", "Barcelona", 300, 1, 6, 2022);
	add_new_offer(serv, "seaside", "Italy", 200, 7, 6, 2022);
	add_new_offer(serv, "mountain", "Italy", 400, 8, 10, 2022);
	add_new_offer(serv, "mountain", "Switzerland", 250, 20, 7, 2023);
	add_new_offer(serv, "city break", "Madrid", 300, 19, 6, 2022);
	add_new_offer(serv, "city break", "Paris", 350, 25, 7,2022);
	add_new_offer(serv, "city break", "Amsterdam", 300, 20, 8,2022);
	add_new_offer(serv, "city break", "London", 250, 11, 6, 2022);
	add_new_offer(serv, "city break", "Budapest", 300, 10, 9, 2022);
	UI* ui = createUI(serv);
	startUI(ui);
	destroyUi(ui);
	_CrtDumpMemoryLeaks();
	return 0;
}