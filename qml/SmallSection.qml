import QtQuick 2.4
import QtQuick.Controls 1.2

Rectangle {
    border.width: 1
    border.color: "red"
    height: parent.height/3
    width: parent.width

    TextMetrics {
        id: text_min
        text: "20"
        font.family: "Arial"
        font.pixelSize: 20
    }

    TextMetrics {
        id: text_max
        text: "25"
        font.family: "Arial"
        font.pixelSize: 20
    }

    Rectangle {
        id: rectangle_pic
        width: 2*(parent.width/3)
        height: parent.height

        Image {
            id: root
            source: "/meteo/03d"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            scale:0.15
        }
    }

    Rectangle {
        width: parent.width/3
        height: parent.height
        anchors.left: rectangle_pic.right

        Rectangle {
            width: text_min.width + text_max.width
            height: text_min.height + text_max.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: temp_max
                text: text_max.text
                font: text_max.font
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
            }

            Text {
                id: temp_min
                text: text_min.text
                font: text_min.font
                anchors.top: temp_max.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "blue"
            }
        }



    }
}
