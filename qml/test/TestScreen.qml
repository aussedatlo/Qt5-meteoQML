import QtQuick 2.3
import QtQuick.Controls 1.2

import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    visible: true
    width: 320
    height: 240
    color: "grey"

    Canvas {
        id: c
        width: 400; height: 200
        contextType: "2d"

        Component {
            id: comp
            PathCurve { }
        }

        property var paths : [
            //comp.createObject(c, {"x": 75, "y": 75} )
        ]

        Path {
            id: myPath
            startX: 0; startY: 100
            pathElements: paths
        }

        onPaint: {
            context.strokeStyle = Qt.rgba(.4,.6,.8);
            context.path = myPath;
            context.lineWidth = 3;
            context.stroke();
        }

        Component.onCompleted: {
            var i
            for (i=0; i<8; i++)
                paths.push(comp.createObject(c, {"x": i*50, "y": Math.floor(Math.random()*30) + 1} ))
            paths[3] = comp.createObject(c, {"x": 150, "y": 80} )
            myPath.pathElements = paths
        }
    }
}
