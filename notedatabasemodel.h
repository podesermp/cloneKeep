#ifndef NOTEDATABASEMODEL_H
#define NOTEDATABASEMODEL_H
#include <QtSql/QSqlTableModel>
#include "database.h"
#include "note.h"


class NoteDatabaseModel: public QSqlTableModel{
    Q_OBJECT
public:
    enum Roles{
        id = Qt::UserRole + 1,
        Title,
        Description,
        Creator,
        Content,
        Email,
        Date,
        ColorPreference,
        LastModify
    };
    Q_ENUM(Roles)
    explicit NoteDatabaseModel(QObject *parent = nullptr, Database *database = new Database());
    void configureRoles();
    void registerRoleCollumns(int role, QByteArray collumnNames);
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
//    void setdata(const QModelIndex &index, const QVariant &value, int role)const override;

    //Q_INVOKABLE void newRow(Note n_nota);
    Q_INVOKABLE void newRow(QString title, QString creator, QString content, QString email);
    Q_INVOKABLE void deleteRow(QString id);

    Q_INVOKABLE QHash<int, QByteArray> roleNames() const;


//    bool updateRowInTable(int row, const QSqlRecord &values) override;
//    bool insertRowIntoTable(const QSqlRecord &values)override;
//    bool deleteRowFromTable(int row)override;

private:
    Database m_db;
    QHash<int, QByteArray> m_roleCollumns;
};

#endif // NOTEDATABASEMODEL_H
