#ifndef MODEL_H
#define MODEL_H

#include <QObject>

class Model:public QObject{
Q_OBJECT

public:

    explicit Model(QObject *parent = nullptr);
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

    QString name();
    void setName(QString name);

signals:
    void nameChanged(QString name);

private:
    QString m_name;
};

#endif // MODEL_H

