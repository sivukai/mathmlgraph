//-------------------------------------------------------------
//	Created by: Ionel Alexandru 
//	Mail: ionel.alexandru@gmail.com
//	Site: www.learn-math.info
//---------------------------------------------------------------

var nbFlash = 0;

function getElement(id) {
	return document.getElementById ? document.getElementById(id) : document.all[id];
}

function resizeFlash(name, w, h){
	var obj = getElement("Div" + name);
	obj.style.width = parseFloat(w);
	obj.style.height = parseFloat(h);
}


