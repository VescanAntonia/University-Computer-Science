#include "Repo.h"
#include "Service.h"
#include "Ui.h"
#include <iostream>

int main()
{
	Repository repo{};
	Service* service = new Service{ repo };
	UI* ui = new UI{ *service };
	ui->start();
	return 0;
}