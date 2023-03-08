#include "test3.h"

test3::test3(Service&serv1, QWidget *parent)
    : QWidget(parent), serv(serv1)
{
    ui.setupUi(this);
    this->populateList();
}

void test3::populateList()
{

}
