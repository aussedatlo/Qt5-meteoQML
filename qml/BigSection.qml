import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    anchors.fill: parent

    Rectangle {
        width: parent.width
        height: 2*parent.height/3
        anchors.top: parent.top
        Image {
            id: root
            source: "/meteo/03d"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            scale:0.23
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height/3
        anchors.bottom: parent.bottom


        Text {
            id: temp1
            text: "20"
            font.family: "Helvetica"
            font.pointSize: 24
            color: "red"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: temp2
            text: "12"
            font.family: "Helvetica"
            font.pointSize: 24
            color: "blue"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: temp1.bottom
        }
    }
}

