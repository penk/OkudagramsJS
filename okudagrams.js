function reflowLayout(data) {
    var layout = Alg.Treemap.generate(data, width, height);

    // container type & border type
    function handleContainers(element, index, array) {
        if (typeof(root.children[index]) === "undefined") {
            container.createObject(root, { 
                x: element[0], y: element[1], 
                width: element[2]-element[0], height: element[3]-element[1], 
                color: colorScheme[Math.floor(Math.random() * colorScheme.length)]
                //label: data[0][index]
            });
        } else { 
            root.children[index].x = element[0];
            root.children[index].y = element[1];
            root.children[index].width = element[2]-element[0];
            root.children[index].height = element[3]-element[1];
            root.children[index].color = colorScheme[Math.floor(Math.random() * colorScheme.length)];
            root.children[index].label = data[0][index]
        }
    }
    // FIXE: handle remaining elements 
    for (var i = 0; i < layout.length; i++) {
        layout[i].forEach(handleContainers);
    }

    // append items into container
    var i = 0;
    for (var block in jsonItems) {
        root.children[i].label = block;
        i++;
    }
}

function loadLayout(jsonFile) {
    var xhr = new XMLHttpRequest();
    var i = 0, layoutData = [[]];
    var weights = { "action": 30, "list": 10, "button": 50, 
        "photo": 350, "textarea": 400, "input": 40 }

    xhr.open("GET", jsonFile, true); 
    xhr.onreadystatechange = function()
    {
        var res; 
        if ( xhr.readyState == xhr.DONE) {
            try { res = JSON.parse(xhr.responseText); } catch (e) { console.error(e) } 
            if (typeof res !== 'object') { console.log('Failed to load layout'); }

            jsonItems = res;
            //console.log(JSON.stringify(jsonItems, null, 4));
            for (var block in res) {
                layoutData[0][i] = 0;
                for (var element in res[block]) {
                    // FIXME: single level blocks only, no nested 
                    var item = res[block][element].length;
                    //console.log(block, 'item: ', item, 'weights: ', weights[element])
                    layoutData[0][i] += item * weights[element];
                }
                i++ 
            }
                savedLayoutData = layoutData;
                reflowLayout(layoutData);
        }
    }
    xhr.send();
}
