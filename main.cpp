#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "model.h"
#include "controller.h"




int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Model *model = new Model();
    Controller *controller = new Controller();
    controller->setModel(model);

    engine.rootContext()->setContextProperty("myModel", model);
    engine.rootContext()->setContextProperty("myController", controller);




    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
