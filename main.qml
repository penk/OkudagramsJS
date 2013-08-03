import QtQuick 2.0
import "treemap-squarify.js" as Alg
import "okudagrams.js" as Okudagrams

Rectangle {
    id: root 
    width: 800
    height: 600
    color: "black"

    Component.onCompleted: Okudagrams.loadLayout("./example/layout.json");

    property variant colorScheme: ["#FF9900", "#CC99CC", "#9999CC", 
        "#CC6666", "#FFCC99", "#FF9966", "#9999FF", "#CC6699" ];

    property variant savedLayoutData: [""];
    Component {
        id: container
        Rectangle {
            border.width: 3 
            border.color: "black"
            clip: true 

            color: "black"
            property variant label: ""

/*
            Corner {
                anchors.margins: 3
                visible: parent.height > 200 && parent.width > 100 // rand and decide by weight 
                width: parent.width
                height: parent.height
                type: Math.floor(Math.random() * 4)
                cornerColor: (parent.height > 200 && parent.width > 100) ? colorScheme[Math.floor(Math.random() * colorScheme.length)] : "black"
            }
*/

            MouseArea { 
                anchors.fill: parent;
                onPressed:  { 
                    var arr = [];
                    for (var i = 0, l = Math.floor(Math.random() * 5) + 6; i < l; i++) {
                        arr.push(Math.round(Math.random() * l));
                    }
                    var data = new Array(arr);
                    savedLayoutData = data;
                    Okudagrams.reflowLayout(data);
                }
            }

            Text { 
            text: label; anchors.centerIn: parent; 
                font.pointSize: 20; 
                font.bold: true 
                }
        }
    }

    onWidthChanged: Okudagrams.reflowLayout(savedLayoutData);
    onHeightChanged: Okudagrams.reflowLayout(savedLayoutData); 

}
