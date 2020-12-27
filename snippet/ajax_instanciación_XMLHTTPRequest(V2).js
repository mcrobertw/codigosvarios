<script language="JavaScript" type="text/javascript">
function getXMLHTTPRequest(){
	var request=false;
	if(window.XMLHTTPRequest)
	{
		request=new XMLHTTPRequest();
	}else {
		if(window.ActiveXObject) /*Pregunta implicitamente si el navegador es internext explorer*/
		{
			try{
				request=new ActiveXObject("Msxml2.XMLHTTP");
			}catch(err1)
			{
				try{
					request=new ActiveXObject("Microsoft.XMLHTTP");
				}catch(error2)
				{
					request=false;
				}
			}
		}
	}

return request;
}