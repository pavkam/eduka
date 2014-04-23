
var nodes		= new Array();;
var openNodes	= new Array();
var icons		= new Array(6);

// Incarca toate iconogramele
function preloadIcons() {
	icons[0] = new Image();
	icons[0].src = "../images/book-green-close.gif";
	icons[1] = new Image();
	icons[1].src = "../images/book-green-open.gif";
/*	icons[2] = new Image();
	icons[2].src = "images/book-page.jpg";
*/
}
// Creaza Tree
function createTree(arrName, startNode, openNode) {
	nodes = arrName;
	if (nodes.length > 0) {
		preloadIcons();
		if (startNode == null) startNode = 0;
		if (openNode != 0 || openNode != null) setOpenNodes(openNode);
	
		if (startNode !=0) {
			var nodeValues = nodes[getArrayId(startNode)].split("|");
		}
	
		var recursedNodes = new Array();
		addNode(startNode, recursedNodes);
	}
}
// Returneaza pozitia nodului in masiv
function getArrayId(node) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==node) return i;
	}
}
// Pune in masiv nodurile care vor fi deschide
function setOpenNodes(openNode) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==openNode) {
			openNodes.push(nodeValues[0]);
			setOpenNodes(nodeValues[1]);
		}
	} 
}
// Verifica daca nodul este deschis
function isNodeOpen(node) {
	for (i=0; i<openNodes.length; i++)
		if (openNodes[i]==node) return true;
	return false;
}
// Verifica daca nodul are itemi
function hasChildNode(parentNode) {
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) return true;
	}
	return false;
}
// Verifica daca nodul este ultimul
function lastSibling (node, parentNode) {
	var lastChild = 0;
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode)
			lastChild = nodeValues[0];
	}
	if (lastChild==node) return true;
	return false;
}
// Adauga un nod nou la Tree
function addNode(parentNode, recursedNodes) {
  //  document.write("<p class=\"mainmenu" +  "\">");
	for (var i = 0; i < nodes.length; i++) {

		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) {

			var ls	= lastSibling(nodeValues[0], nodeValues[1]);
			var hcn	= hasChildNode(nodeValues[0]);
			var ino = isNodeOpen(nodeValues[0]);

			for (g=0; g<recursedNodes.length; g++) {
				    document.write("<img src=\"../images/pxm.gif\" align=\"absbottom\" alt=\"\" hspace=\"2\" vspace=\"1\" width='16' height='16'/>");
					}

			if (ls) recursedNodes.push(0);
			else recursedNodes.push(1);

			if (hcn) 
			{/*begin*/
				if (ls) document.write("<a onmousedown=\"javascript: oc(" + nodeValues[0] + ", 1);\">");
				else document.write("<a onmousedown=\"javascript: oc(" + nodeValues[0] + ", 0);\">");
				document.write("<img id=\"join" + nodeValues[0] + "\" src=\"../images/");
				if (ino) document.write("book-green-open");
				else document.write("book-green-close");
				document.write(".gif\" align=\"absbottom\" hspace=\"2\" vspace=\"1\" alt=\"Deschide/Inchide nodul\" /></a>");		
			}/*end*/
						
		    if (hcn)
			{/*begin*/
			    // Inceput link
			    document.write("<a onmousedown=\"javascript: oc(" + nodeValues[0] + ", 1);" + "\"class=\"mainmenu"  + "\">");
			    if (hcn) {}
			    else
			    {/*begin*/ 
			        if (ino) document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../images/book-docm-activ" + "" + ".gif\" align=\"absbottom\"  hspace=\"2\" vspace=\"1\" alt=\"Item\"  border=\"0\" />");
			        else  document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../images/book-docm" + "" + ".gif\" align=\"absbottom\" hspace=\"2\" vspace=\"1\"  alt=\"Item\" border=\"0\" />");
			    }/*end*/			
			    if (ino) document.write("<b>");
			    document.write(nodeValues[2]);
			    if (ino) document.write("</b>");           
				// sfarsit link
			    document.write("</a><br />");
			}/*end*/
			else 
			{/*begin*/
			    // Inceput link
			    document.write("<a href=\""  + nodeValues[3] + "\"class=\"mainmenu"  + "\">");
			    if (hcn) {}
			    else
				{/*begin*/ 
			        if (ino) document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../images/book-docm-activ" + "" + ".gif\" align=\"absbottom\" hspace=\"2\" vspace=\"1\"  alt=\"Item\"  border=\"0\" />");
			        else document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../images/book-docm" + "" + ".gif\" align=\"absbottom\" hspace=\"2\" vspace=\"1\"  alt=\"Item\" border=\"0\" />");
			    }/*end*/						
			    if (ino) document.write("<b>");
			    document.write(nodeValues[2]);
			    if (ino) document.write("</b>");
			    // sfarsit link
			    document.write("</a><br />");
			}/*end*/		
			if (hcn) {
				document.write("<div id=\"div" + nodeValues[0] + "\"");
					if (!ino) document.write(" style=\"display: none;\"");
				document.write(">");
				addNode(nodeValues[0], recursedNodes);
				document.write("</div>");
			}
			recursedNodes.pop();
		}
	}
}
// Deschide sau inchide nodul
function oc(node, bottom) {
	var theDiv = document.getElementById("div" + node);
	var theJoin = document.getElementById("join" + node);
	var theIcon = document.getElementById("icon" + node);
	
	if (theDiv.style.display == 'none') {
		theJoin.src = icons[1].src;
		theDiv.style.display = '';
	} else {
		if (bottom==1) theJoin.src = icons[0].src;
		else theJoin.src = icons[0].src;
		theDiv.style.display = 'none';
	}
}

if(!Array.prototype.push) {
	function array_push() {
		for(var i=0;i<arguments.length;i++)
			this[this.length]=arguments[i];
		return this.length;
	}
	Array.prototype.push = array_push;
}
if(!Array.prototype.pop) {
	function array_pop(){
		lastElement = this[this.length-1];
		this.length = Math.max(this.length-1,0);
		return lastElement;
	}
	Array.prototype.pop = array_pop;
}