#include "notedatabasemodel.h"
#include <QCoreApplication>
#include <QModelIndex>
#include <QQmlEngine>
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>
#include <QUuid>
#include "note.h"

NoteDatabaseModel::NoteDatabaseModel(QObject *parent, Database *database):QSqlTableModel(parent, database->database()){
    setTable("nota");
    this->configureRoles();
    this->select();
    this->setEditStrategy(QSqlTableModel::OnRowChange);
}

void NoteDatabaseModel::configureRoles(){
    registerRoleCollumns(id, "id");
    registerRoleCollumns(Title, "title");
    registerRoleCollumns(Description, "description");
    registerRoleCollumns(Creator, "creator");
    registerRoleCollumns(Content, "content");
    registerRoleCollumns(Email, "email");
    registerRoleCollumns(ColorPreference, "colorPreference");
    registerRoleCollumns(ColorPreference, "lastModify");
}

QHash<int, QByteArray> NoteDatabaseModel::roleNames() const{
    return m_roleCollumns;
}

QVariant NoteDatabaseModel::data(const QModelIndex &index, int role) const
{
    if(m_roleCollumns.contains(role)) {
        int column = fieldIndex(m_roleCollumns.value(role));
        QModelIndex itemListIndex = QSqlTableModel::index(index.row(), column);
        return QSqlTableModel::data(itemListIndex);
    }
    return QVariant();
}

void NoteDatabaseModel::newRow(QString title, QString creator, QString content, QString email){

    QString id = QUuid().createUuid().toString().replace("{", "").replace("}", "");
    Note *n_note = new Note(title, creator, content, email);
    QSqlQuery insertQuery(QSqlTableModel::database());

    insertQuery.prepare("insert into nota(id, title, creator, content, email, description, colorPreference, lastModify)"
                            "VALUES (:id, :title, :creator, :content, :email, :description, :colorPreference, :lastModify)"
                            );
    insertQuery.bindValue(":id", id);
    insertQuery.bindValue(":title", title);
    insertQuery.bindValue(":creator", creator);
    insertQuery.bindValue(":content", content);
    insertQuery.bindValue(":email", email);
    insertQuery.bindValue(":description", n_note->description);
    insertQuery.bindValue(":colorPreference", n_note->colorPreference);
    insertQuery.bindValue(":lastModify", n_note->lastModify);
    insertQuery.exec();
    select();
}

void NoteDatabaseModel::deleteRow(QString id){

    QSqlQuery deleteQuery(QSqlTableModel::database());
    deleteQuery.prepare("delete from nota where id = :id");
    deleteQuery.bindValue(":id", id);
    deleteQuery.exec();
    select();
}

void NoteDatabaseModel::registerRoleCollumns(int role, QByteArray collumnNames){
    m_roleCollumns.insert(role, collumnNames);
}

void registerTypes() {
    qmlRegisterType<NoteDatabaseModel>("Models", 1,0, "NoteDatabaseModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerTypes);
