<%@ Control Language="VB"
    CodeFile="LiveGrid.ascx.vb" 
    Inherits="LiveGrid" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="Column"   Src="GridColumn.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Panel"    Src="GridPanel.ascx" %>
<%@ Register TagPrefix="Rico" TagName="AltTable" Src="AltTable.ascx" %>
<%@ Register TagPrefix="Rico" TagName="sqlParse" Src="sqlParse.ascx" %>
<%@ Register TagPrefix="Rico" TagName="sqlCompatibilty" Src="sqlCompatibilty.ascx" %>

<script type='text/javascript'>
<%=Me.init_Script %>
<%=Me.globalInitScript%>
</script>

<%=Me.DebugString%>
<%=Me.Bookmark%>
<table id='<%=Me.UniqueId %>'>
<thead>
<asp:placeholder runat='server' id='LiveGridHeadingsTop' />
<tr id='<%=Me.UniqueId %>_hdg_main'>
<asp:placeholder runat='server' id='LiveGridHeadingsMain' />
</tr>
<asp:placeholder runat='server' id='LiveGridHeadingsBottom' />
</thead>
</table>
