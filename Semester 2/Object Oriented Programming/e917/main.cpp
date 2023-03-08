#include "GUI.h"
#include "Repository.h"
#include "ProgrammerRepo.h"
#include "ProgrammerRepo.h"
#include "Service.h"
#include <QtWidgets/QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Repository repo{};
    ProgrammerRepo p{};
    Service serv{ repo };
    for (int i = 0; i < p.get().size();++i) {
        GUI* pw = new GUI{serv, p.get()[i]};
        pw->show();
    }
    //GUI w;
    //w.show();
    return a.exec();
}
