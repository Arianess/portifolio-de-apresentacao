/* Common values for the ReadyState of the XMLHttpRequest object */
var READYSTATE_UNINITIALIZED = 0;
var READYSTATE_LOADING = 1;
var READYSTATE_LOADED = 2;
var READYSTATE_INTERACTIVE = 3;
var READYSTATE_COMPLETE = 4;

/* Common values for HTTP status codes */
var HTTPSTATUS_OK = 200;

var CurrentParent = null;



// Utility function to obtain a valid XMLHttpRequest object.
function CreateXmlHttpRequestObject()
{

    var xmlObj;
    if (window.ActiveXObject)
    {
        try
        {
           xmlObj = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e)
        {
           xmlObj = new ActiveXObject("Msxml2.XMLHTTP");
        }
    }
    else
        xmlObj = new XMLHttpRequest();
        
    return xmlObj;
}

function AddEvent(eventTarget, eventName, eventHandler)
{
	if(eventTarget.addEventListener)
	{
		eventTarget.addEventListener(eventName,eventHandler,false);
	}
	else if (eventTarget.attachEvent)
	{
		eventTarget.attachEvent('on'+eventName,eventHandler);

	}
}

PasswordStrengthControl = function(element)
{
	this._clientID = element;
	
	this._text = document.getElementById(element+'_text');
	
	this._leftBar = document.getElementById(element+'_leftBar');
	this._rightBar = document.getElementById(element+'_rightBar');
	
}

PasswordStrengthControl.prototype = {

	initialize : function(target) {
	
		var etarget = document.getElementById(target);
		
		AddEvent(etarget,'keyup', this._keyPressHandler);
		
		CurrentParent = this;
		
	},
	
	_checkPasswordStrength : function(password) {
	
		var xmlHttpObj = CreateXmlHttpRequestObject();
	
		if(xmlHttpObj)
		{
			xmlHttpObj.open("GET", "https://www.google.com/accounts/RatePassword?Passwd="+password, true )
			
			xmlHttpObj.onreadystatechange = function() { 
				if ( xmlHttpObj.readyState == READYSTATE_COMPLETE && xmlHttpObj.status == HTTPSTATUS_OK)
				{
					if(password.length <= 6)
					{
						CurrentParent._leftBar.className = 'leftBar0';
						CurrentParent._rightBar.className = 'rightBar0';
						CurrentParent._text.className = 'text0';
						CurrentParent._text.innerText = 'Too Short';
						if(password.length == 0)
							CurrentParent._text.innerText = '';
					}
					else
					{
						switch(xmlHttpObj.responseText)
						{
							case '1':
								CurrentParent._leftBar.className = 'leftBar1';
								CurrentParent._rightBar.className = 'rightBar1';
								CurrentParent._text.className = 'text1';
								CurrentParent._text.innerText = 'Weak';
								break;
							case '2':
								CurrentParent._leftBar.className = 'leftBar2';
								CurrentParent._rightBar.className = 'rightBar2';
								CurrentParent._text.className = 'text2';
								CurrentParent._text.innerText = 'Fair';
								break;
							case '3':
								CurrentParent._leftBar.className = 'leftBar3';
								CurrentParent._rightBar.className = 'rightBar3';
								CurrentParent._text.className = 'text3';
								CurrentParent._text.innerText = 'Good';
								break;
							case '4':
								CurrentParent._leftBar.className = 'leftBar4';
								CurrentParent._rightBar.className = 'rightBar4';
								CurrentParent._text.className = 'text4';
								CurrentParent._text.innerText = 'Strong';
								break;
							
						}
					}
				}
			}
			xmlHttpObj.send(null);
		}
	
	},
	
	_keyPressHandler : function(e)
	{
		var txtBox = null
		if(e.currentTarget)
		{
			txtBox = e.currentTarget;
		}
		else if (e.srcElement)
		{
			txtBox = e.srcElement;
		}
		CurrentParent._checkPasswordStrength(txtBox.value);
		
	}	

}

