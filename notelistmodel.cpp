#include "notelistmodel.h"
#include <QCoreApplication>

NoteListModel::NoteListModel(QObject *parent){

}

int NoteListModel::rowCount(const QModelIndex &parent) const{
    return m_notes.size();
}

QVariant NoteListModel::data(const QModelIndex &index, int role) const{
    if(!index.isValid()){
        return QVariant();
    }
    switch(role){
    case Title:
        return m_notes.at(index.row()).title;
        break;
    case Description:
        return m_notes.at(index.row()).content;
        break;
    case Creator:
        return m_notes.at(index.row()).creator;
        break;
    case Content:
        return m_notes.at(index.row()).description;
        break;
    case Email:
        return m_notes.at(index.row()).email;
        break;
    case Date:
        return m_notes.at(index.row()).date;
        break;
    case ColorPreference:
        return m_notes.at(index.row()).colorPreference;
        break;
    default:
        return QVariant();
    }

    return QVariant();
}

QHash<int, QByteArray> NoteListModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[Title] = "title";
    roles[Description] = "description";
    roles[Creator] = "creator";
    roles[Content] = "content";
    roles[Email] = "email";
    roles[Date] = "date";
    roles[ColorPreference] = "colorPreference";
    return roles;
}

void NoteListModel::insertNote(QString title, QString creator,
                               QString content, QString email){

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_notes.append(Note(title, creator, content, email));
        endInsertRows();
}

void NoteListModel::deleteNote(int index){
    beginRemoveRows(QModelIndex(), index, index);
    m_notes.removeAt(index);
    endRemoveRows();
}

void NoteListModel::addNotes(){
    beginResetModel();
    m_notes.clear();
    m_notes.append(Note("Titulo um", "Marcos Paulo", "Aqui tem o conteudo da nota um", "marcospaulorocharodrigues12@gmail.com"));
    m_notes.append(Note("Titulo dois", "Marcos Paulo", "Aqui tem o conteudo da nota dois", "marcospaulorocharodrigues12@gmail.com"));
    m_notes.append(Note("Titulo tres", "Marcos Paulo", "Aqui tem o conteudo da nota tres", "marcospaulorocharodrigues12@gmail.com"));
    endResetModel();
}

static void registerTypes() {
    qmlRegisterType<NoteListModel>("Models", 1,0, "NoteListModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerTypes);
