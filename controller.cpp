#include "controller.h"
#include <QDebug>

Controller::Controller(QObject *parent){

}

void Controller::setModel(Model *model){
    m_model = model;
}

void Controller::mudarNome(QString nome){
}
