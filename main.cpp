#include <QApplication>
#include "meteomanager.h"
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Load the QML and set the Context
    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));

    // MeteoManager update
    MeteoManager* meteoManager = new MeteoManager();
    meteoManager->update();

    engine.rootContext()->setContextProperty("meteoManager",meteoManager);

    QTimer *timer = new QTimer();
    QObject::connect(timer, SIGNAL(timeout()), meteoManager, SLOT(updateData()));
    timer->start(10000);
    return app.exec();
}
