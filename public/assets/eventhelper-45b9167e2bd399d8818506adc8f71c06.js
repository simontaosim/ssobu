//使用eventhelper则禁止js中直接修改事件回掉，只允许在html中直接指定（优先级问题）

function addOnLoadEventHandler(handler) { 
	var oldHandler = window.onload; 
	if (typeof window.onload != 'function') { 
		window.onload = handler; 
	} else { 
		window.onload = function() { 
			oldHandler(); 
			handler(); 
		} 
	} 
}

function addTargetOnFocusEventHandler(target, handler) {
	var oldHandler = target.onfocus;
	if (typeof target.onfocus != 'function') {
		target.onfocus = handler;
	}
	else {
		target.onfocus = function() {
			oldHandler();
			handler();
		}
	}
}

function addTargetOnBlurEventHandler(target, handler) {
	var oldHandler = target.onblur;
	if (typeof target.onblur != 'function') {
		target.onblur = handler;
	}
	else {
		target.onblur = function() {
			oldHandler();
			handler();
		}
	}
}

function addTargetOnTouchStartEventHandler(target, handler)	{
	var oldHandler = target.ontouchstart;
	if (typeof target.ontouchstart != 'function') {
		target.ontouchstart = handler;
	}
	else {
		target.ontouchstart = function() {
			oldHandler();
			handler();
		}
	}
}
;
