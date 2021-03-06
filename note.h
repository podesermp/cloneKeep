#ifndef NOTE_H
#define NOTE_H

#include <QString>

class Note{
public:
    Note();
    Note(const QString &title, const QString &creator,
         const QString &content, const QString &email);

    QString title;
    QString description;
    QString creator;
    QString content;
    QString email;
    QString date;
    QString colorPreference;
};

#endif // NOTE_H

