#include "model.h"
#include <QDebug>

Model::Model(QObject *parent){

}

QString Model::name(){
    qDebug()<< "name()[Model] ";
    return m_name;
}

void Model::setName(QString name){
    qDebug()<< "setName()[Model]: " << name;
    if(m_name == name){
        qDebug()<< "Mesmo nome[Model]" << name;
        return ;
    }
    m_name = name;
    emit nameChanged(m_name);
    qDebug()<< "emitiu signal nameChanged[Model]";
}
