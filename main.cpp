#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include "testobject.h"
#include "meteomanager.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    TestObject to;

    // Load the QML and set the Context
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    engine.rootContext()->setContextProperty("testObject",&to);

    // MeteoManager update
    MeteoManager* meteoManager = new MeteoManager();
    meteoManager->update();

    engine.rootContext()->setContextProperty("meteoManager",meteoManager);

    QTimer *timer = new QTimer();
    QObject::connect(timer, SIGNAL(timeout()), meteoManager, SLOT(updateData()));
    timer->start(10000);

    return app.exec();
}
