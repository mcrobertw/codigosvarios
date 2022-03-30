Partial Class AltTable
Inherits System.Web.UI.UserControl

public TblName as string
public TblAlias as string
public Delim as string = ","
public arFields() as string
public arData() as string

Public Property FieldList() As String
  Get
    Return String.join(Delim,arFields)
  End Get
  Set(ByVal Value As String)
    arFields=Value.split(Delim)
  End Set
End Property

Public Property FieldData() As String
  Get
    Return String.join(Delim,arData)
  End Get
  Set(ByVal Value As String)
    arData=Value.split(Delim)
  End Set
End Property

End Class
