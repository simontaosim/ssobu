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
		if(tag.className == className_target) {
			addTargetOnFocusEventHandler(tag, onFocusTarget);
			addTargetOnBlurEventHandler(tag, onBlurTarget);
		}
	}
};

function onFocusTarget(){
	footer.style.display = "none";
}
function onBlurTarget(){
	footer.style.display = "block";
}
;
