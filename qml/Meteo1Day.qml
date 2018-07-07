import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    visible: true
    width: 320
    height: 240
    property string temp: "15"
    property string icon: "01d"
    property string humid: "32"
    property string wind: "15"
    property string rain: "8"
    /* Values normalisées entre -20 et 30 */
    property string graph1: "20"
    property string graph2: "15"
    property string graph3: "-6"
    property string graph4: "12"
    property string graph5: "20"
    property string graph6: "28"
    property string graph7: "22"
    /* Décalage pour la courbe */




    MouseArea {
            anchors.fill: parent
            onClicked: {main.changeView("retour Meteo4Days.qml");}
        }

    Rectangle {
        id: rectangle_info
        width: parent.width/2
        height: parent.height/2

        Column {
            spacing:2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "29°C"
                font.pointSize: 30
            }
            Text {
                text: "Humidité: " + humid + "%"
                color: "grey"
            }
            Text {
                text: "Précipitations: " + rain + "%"
                color: "grey"
            }
            Text {
                text: "Vent: " + wind + " km/h"
                color: "grey"
            }
        }
    }


    Item {
        id: rectangle_image
        width: parent.width/2
        height: parent.height/2
        anchors.left: rectangle_info.right

        Image {
            source: "/meteo/" + icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            scale:0.18
        }
    }


    /* Section courbe */
    Rectangle {
        id: canevas
        width: parent.width
        height: parent.height/2-20
        anchors.top: rectangle_image.bottom
        Canvas {
            anchors.fill:parent
            contextType: "2d"

            Path {
                id: myPath
                startX: -70; startY: 100

                /* start fill */
                PathCurve { x: -50; y: 30-graph1 }

                /* Values */
                PathCurve { x: parent.width/6; y: 30-graph2 }
                PathCurve { x: 2*parent.width/6; y: 30-graph3 }
                PathCurve { x: 3*parent.width/6; y: 30-graph4 }
                PathCurve { x: 4*parent.width/6; y: 30-graph5 }
                PathCurve { x: 5*parent.width/6; y: 30-graph6 }
                PathCurve { x: parent.width; y: 30-graph7 }

                /* end fill */
                PathCurve { x: parent.width+50; y: 30-graph7 }
                PathCurve { x: parent.width+70; y: 100 }
            }

            onPaint: {
                context.strokeStyle = "#ffcc00";
                context.fillStyle = "#FFCC80"
                context.globalAlpha = 0.8;
                context.path = myPath;
                context.lineWidth = 3;
                context.fill();
                context.stroke();
            }
        }
    }

    /* Section heures */
    Rectangle {
        width: parent.width
        height: parent.height/2-20
        anchors.top: canevas.bottom

        Row {
            width: parent.width
            height: parent.height
            Repeater {
                id: repeater_hours
                model:5
                Item {
                    width: parent.width/5
                    height: parent.height
                    property int hour: 12
                    // repeater_hours.itemAt(index).hour = newValue
                    Text {
                        text: (hour+index*3) % 24 + "h"
                        color: "grey"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }

}
