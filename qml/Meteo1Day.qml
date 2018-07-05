import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    visible: true
    width: 320
    height: 240
    color: "white"
    property string temp_min: "15"
    property string temp_max: "25"
    property string icon: "09d"
    property string graph1: "8"
    property string graph2: "10"
    property string graph3: "17"
    property string graph4: "22"
    property string graph5: "28"
    property string graph6: "24"
    property string graph7: "16"
    property string decalage: "130"


    MouseArea {
            anchors.fill: parent
            onClicked: {main.changeView("retour Meteo4Days.qml");}
        }


    Rectangle {
        id: rectangle_image
        width: parent.width/2
        height: parent.height/2

        Image {
            source: "/meteo/" + icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            scale:0.20
        }
    }



    Rectangle {
        width: parent.width
        height: parent.height/2
        anchors.top: rectangle_image.bottom




        Canvas {
            anchors.fill:parent
            contextType: "2d"

            Path {
                id: myPath
                startX: 0; startY: decalage-graph1
                PathCurve { x: parent.width/6; y: decalage-graph2 }
                PathCurve { x: 2*parent.width/6; y: decalage-graph3 }
                PathCurve { x: 3*parent.width/6; y: decalage-graph4 }
                PathCurve { x: 4*parent.width/6; y: decalage-graph5 }
                PathCurve { x: 5*parent.width/6; y: decalage-graph6 }
                PathCurve { x: parent.width; y: decalage-graph7 }
            }

            onPaint: {
                context.strokeStyle = Qt.rgba(0,0,255);
                context.path = myPath;
                context.lineWidth = 80;
                context.stroke();
            }
        }
    }




}
