#include "test3.h"
#include <QtWidgets/QApplication>
#include "Service.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Repository repo("Equations.txt");
    Service serv(repo);
    test3 gui{ serv,nullptr };
    gui.show();
    return a.exec();
}
