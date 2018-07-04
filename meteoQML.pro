TEMPLATE = app

QT += qml quick widgets

RESOURCES += qml/qml.qrc \
    ressources/src.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    testobject.h \
    meteomanager.h \
    meteobeans.h

SOURCES += main.cpp \
    testobject.cpp \
    meteomanager.cpp \
    meteobeans.cpp

