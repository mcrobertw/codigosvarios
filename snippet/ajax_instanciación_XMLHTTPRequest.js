<script language="JavaScript" type="text/javascript">
function getXMLHTTPRequest(){
	try{
		req=new new XMLHttpRequest();
	}catch(err1){
		try{
			req=new ActiveXObject("Msxml2.XMLHTTP");
		}catch(err2){
			try{
				req=new ActiveXObject("Microsoft.XMLHTTP");
			}catch(err3){
				req=false;
			}
		}
	}
	return req;
}

var http=getXMLHTTPRequest();