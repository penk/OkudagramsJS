import QtQuick 2.0

Item {
    id: corner

    clip: true
    property variant type: 0
    rotation: (type == 2 || type == 3) ? 180 : 0 
    property variant cornerColor: "#CC6666"

    Rectangle {
        //visible: (type == 0 || type == 2)
        width: parent.width + radius 
        height: parent.height + radius 
        radius: 30
        color: cornerColor
        border.width: 3 
        border.color: "black"
        anchors { 
            right: (type == 0 || type == 2) ? parent.right : undefined; 
            bottom: parent.bottom 
            left: (type == 1 || type == 3) ? parent.left : undefined 
        }
/*
        anchors {
            right: (type == 0 || type == 3 ) ? parent.right : undefined 
            bottom: (type == 0 || type == 1) ? parent.bottom : undefined 
            left: (type == 1 || type == 2 ) ? parent.left : undefined 
            top: (type == 2 || type == 3) ? parent.top : undefined 
        }
*/

        Rectangle {
            radius: 15
            color: "black"
            anchors {      
                right: (type == 0 || type == 2 ) ? parent.right : undefined 
                left: (type == 1 || type == 3) ? parent.left : undefined 

                bottom: parent.bottom 
                rightMargin: (type == 0 || type == 2 ) ? 70 : undefined
                leftMargin: (type == 1 || type == 3) ? 70 : undefined
                bottomMargin: 10 
            }
            height: parent.height + 30
            width: parent.width + 30
        }

    }

    Rectangle {
        visible: false //(type == 1 || type == 3)
        width: parent.width + radius 
        height: parent.height + radius 
        radius: 30
        color: cornerColor
        anchors { left: parent.left; bottom: parent.bottom }

        Rectangle {
            radius: 15
            color: "black"
            anchors {
                left: parent.left
                bottom: parent.bottom 
                leftMargin: 70
                bottomMargin: 10 
            }
            height: parent.height + 30
            width: parent.width + 30
        }

    }
}
