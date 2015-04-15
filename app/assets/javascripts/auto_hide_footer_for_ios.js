//依赖eventhelper.js
//需要参与自动检测的dom元素需要标记class为: auto_hide_footer_for_ios

const className_target = "auto_hide_footer_for_ios"
addOnLoadEventHandler(onLoadForAutoHideFooterForIOS);

function onLoadForAutoHideFooterForIOS(){
	var ua = navigator.userAgent;
	if (ua.indexOf("iPhone") <= 0 && ua.indexOf("iPad") <= 0){
		return;
	}
	var footer = document.getElementById("footer");
	if (footer == null){
		return;
	}

	var tags = tags || document.getElementsByTagName("*");
	var list = [];
	for(var k in tags){
		var tag = tags[k];
		var tagClassName = tag.className;
		if (tagClassName != null){
			if(tagClassName.indexOf(className_target) >= 0) {
				addTargetOnFocusEventHandler(tag, onFocusTarget);
				addTargetOnTouchStartEventHandler(tag, onTouchStartTarget);
				addTargetOnBlurEventHandler(tag, onBlurTarget);
			}
		}
		
	}
};


function onTouchStartTarget(){
	footer.style.display = "none";
}
function onFocusTarget(){
	footer.style.display = "none";
}
function onBlurTarget(){
	footer.style.display = "block";
}