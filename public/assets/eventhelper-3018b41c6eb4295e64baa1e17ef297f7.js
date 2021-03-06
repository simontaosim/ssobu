function addOnLoadEventHandler(target, handler) { 
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
;
