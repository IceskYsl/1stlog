function $(id) {
	return document.getElementById(id);
}
function resizeup(obj) {
	var newheight = parseInt($(obj).style.height, 10) + 50;
	$(obj).style.height = newheight + 'px';
}
function resizedown(obj) {
	var newheight = parseInt($(obj).style.height, 10) - 50;
	if(newheight > 0) {
		$(obj).style.height = newheight + 'px';
	}
}
function addattachfrom() {
	var newnode = $('attachbodyhidden').firstChild.cloneNode(true);
	$('attachbody').appendChild(newnode);
}
function removeattachfrom() {
	$('attachbody').childNodes.length > 1 && $('attachbody').lastChild ? $('attachbody').removeChild($('attachbody').lastChild) : 0;
}
function checkall(form) {
	for (var i=0;i<form.elements.length;i++) {
		var e = form.elements[i];
		if (e.name != 'chkall')
		e.checked = form.chkall.checked;
    }
}