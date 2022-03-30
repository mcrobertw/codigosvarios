<%@ Control Language="vb" debug="true"%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data.Odbc" %>

<script runat="server">

Public dbConnection as object, accessRights as string
Public LastErrorMsg as String
Public defaultDB as String = "Northwind"
Public const dbDialect     = "Access"   ' What kind of database are we connecting to?

Public Function OpenDB()
  try
    select case dbDialect
      case "Access": dbConnection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & server.mappath("../data/" & defaultDB & ".mdb") & ";User ID=;Password=;")
      case "TSQL":   dbConnection = new SqlConnection("Data Source=matt-c2d;User ID=userid;Password=password;Initial Catalog=" & defaultDB & ";")
      case "Oracle": dbConnection = new OleDbConnection("Provider=OraOLEDB.Oracle;Data Source=XE;User ID=" & defaultDB & ";Password=Password;")
      case "MySQL":  dbConnection = new OdbcConnection("DRIVER={MySQL ODBC 3.51 Driver};SERVER=localhost;DATABASE=" & defaultDB & ";USER=userid;PASSWORD=password;")
      case "DB2":    dbConnection = new OleDbConnection("Provider=IBMDADB2;Data Source=NORTHWND;Protocol=local;CurrentSchema=SCHEMA;User ID=userid;Password=password;")
    end select
    dbConnection.Open()
    OpenDB=true
  Catch ex As Exception
    OpenDB=false
    LastErrorMsg=ex.Message
  end try
end function

Public function OpenApp()
  OpenApp=false
  if not OpenDB then exit function
  accessRights="rw"  ' CHECK APPLICATION SECURITY HERE  (in this example, "r" gives read-only access and "rw" gives read/write access)
  if IsNothing(accessRights) OrElse left(accessRights,1)<>"r" then
    LastErrorMsg="You do not have permission to access this application"
  else
    OpenApp=true
  end if
end function

Public function OpenGridForm(oLiveGrid as object)
  OpenGridForm=false
  if not OpenApp() then
    response.write("ERROR: " & LastErrorMsg)
    response.end
    exit function
  end if
  oLiveGrid.dbConnection=Me.dbConnection
  oLiveGrid.dbDialect=Me.dbDialect

  '-------------------------------
  ' set application-wide defaults
  '-------------------------------
  'oLiveGrid.dataProvider="ricoXMLquery.aspx"
  'oLiveGrid.highlightElem="menuRow"
  'oLiveGrid.menuEvent="contextmenu"
  'Session.Timeout=60

  '-------------------------------
  ' set security rights
  '-------------------------------
  dim CanModify as Boolean=CBool(accessRights="rw")
  oLiveGrid.canAdd=CanModify
  oLiveGrid.canEdit=CanModify
  oLiveGrid.canDelete=CanModify

  OpenGridForm=true
end function

Public sub CloseApp()
  if IsNothing(dbConnection) then exit sub
  dbConnection.Close()
  dbConnection = Nothing
end sub

Sub Page_Unload(Sender As object, e As EventArgs)
  Me.CloseApp()
End Sub

</script>
