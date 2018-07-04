import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    anchors.fill: parent
    property string temp_min: ""
    property string temp_max: ""
    property string icon: ""

    Rectangle {
        width: parent.width
        height: 2*parent.height/3
        anchors.top: parent.top
        Image {
            source: "/meteo/" + icon
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
            id: temp1_big
            text: temp_max
            font.family: "Helvetica"
            font.pointSize: 24
            color: "red"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: temp2_big
            text: temp_min
            font.family: "Helvetica"
            font.pointSize: 24
            color: "blue"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: temp1_big.bottom
        }
    }
}

