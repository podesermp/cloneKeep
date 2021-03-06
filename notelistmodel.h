#ifndef NOTELISTMODEL_H
#define NOTELISTMODEL_H

#include <QCoreApplication>
#include <QAbstractListModel>
#include <QQmlEngine>
#include "note.h"

class NoteListModel:public QAbstractListModel{
    Q_OBJECT

public:
    enum Roles{
        Title = Qt::UserRole + 1,
        Description,
        Creator,
        Content,
        Email,
        Date,
        ColorPreference
    };
    Q_ENUM(Roles)

    explicit NoteListModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE void addNotes();
    static void registerTypes();

public slots:
    void insertNote( QString title,QString creator,
                     QString content, QString email);
    void deleteNote(int index);
private:
    QList<Note> m_notes;
};
#endif // NOTELISTMODEL_H
