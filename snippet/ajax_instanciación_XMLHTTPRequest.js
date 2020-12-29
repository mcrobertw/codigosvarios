<script language="JavaScript" type="text/javascript">
function getXMLHTTPRequest(){
	try{
		req=new new XMLHttpRequest(); /*p.e. firefox*/
	}catch(err1){
		try{
			req=new ActiveXObject("Msxml2.XMLHTTP");/*Algunas versiones de I.E.*/
		}catch(err2){
			try{
				req=new ActiveXObject("Microsoft.XMLHTTP");/*Algunas versiones de I.E.*/
			}catch(err3){
				req=false;
			}
		}
	}
	return req;
}

var http=getXMLHTTPRequest();
</script>