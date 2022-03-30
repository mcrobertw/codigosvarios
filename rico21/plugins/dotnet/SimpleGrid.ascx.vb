Imports System.Data

Partial Class SimpleGrid
Inherits System.Web.UI.UserControl

Private _gridHeading As ITemplate = Nothing
Protected HdgContainer As New GridContainer()

Public columns as New ArrayList()
Public gridVar as String
Public optionsVar as String   ' name of grid options js var
Public FilterLocation as Integer = -2
Public FilterAllToken as String
Public FilterBoxMaxLen as Integer = -1
Public FilterAnchorLeft as Boolean = false  ' when matching text box values, should they match beginning of string (true) or anywhere in string (false)?
Public UsingMinRico as Boolean = True   ' using minified version of Rico?


Sub Page_Init()
  gridVar=Me.UniqueId & "['grid']"
  optionsVar=Me.UniqueId & "['options']"

  If Not (_gridHeading Is Nothing) Then
    _gridHeading.InstantiateIn(HdgContainer)
    For Each ctrl As Control In HdgContainer.Controls
      If TypeOf(ctrl) is GridColumn then
        columns.Add(ctrl)
      end if
    Next
  End If
End Sub


Public Class HeadingCellClass
  Public content As String, span As Integer

  Public Sub New(Optional contentParm As String = "", Optional spanParm As Integer = 1)
    content=contentParm
    span=spanParm
  End Sub
End Class

class SimpleGridCell
  public content as String
  private attr As New Hashtable()

  Public Function HeadingCell() as object
    Dim s as String, span as Integer
    s="<td"
    span=1
    If attr.contains("colspan") Then
      span=CInt(attr("colspan"))
      s &= " colspan='" & span & "'"
    End If
    dim content as String=s & "><div class='ricoLG_col'>" & DataCell("") & "</div></td>"
    dim result() as object = {content,span}
    HeadingCell = result
  End Function

  Public Function DataCell(rowclass as String) as String
    dim s as String, k as String
    s = "<div"
    attr("class")=trim("ricoLG_cell " & attr("class") & " " & rowclass)
    for each k in attr.keys
      If k<>"colspan" Then s=s & " " & k & "='" & attr(k) & "'"
    next
    s=s & ">" & content & "</div>"
    DataCell=s
  End Function

  Public Function HtmlCell()
    dim s as String="", k as String
    for each k in attr.keys
      s &= " " & k & "='" & attr(k) & "'"
    next
    HtmlCell="<td" & s & ">" & content & "</td>"
  End Function

  Public Sub SetAttr(name as String, value as String)
    attr(name)=value
  End Sub
End class


class SimpleGridRow
  public cells as New ArrayList()
  private attr As New Hashtable()
  private CurrentCell as SimpleGridCell

  Public Sub AddCell(ByVal content as String)
    CurrentCell=new SimpleGridCell()
    cells.Add(CurrentCell)
    CurrentCell.content=content
  End Sub
  
  Public Function HeadingRow(ByVal c1 as Integer, ByVal c2 as Integer) as String
    dim s as String, a
    dim cellidx as Integer=0
    dim colidx as Integer=0
    while colidx < c1 and cellidx < cells.count
      a=cells(cellidx).HeadingCell()
      colidx+=CInt(a(1))
      cellidx+=1
    end while
    while (colidx <= c2 or c2=-1) and cellidx < cells.count
      a=cells(cellidx).HeadingCell()
      s &= a(0)
      colidx+=CInt(a(1))
      cellidx+=1
    end while
    HeadingRow = s
  End Function
  
  Public Function HeadingClass()
    HeadingClass=trim("ricoLG_hdg " & attr("class"))
  End Function
  
  Public Function CellCount()
    CellCount=cells.count
  End Function

  Public Function GetRowAttr(ByVal name)
    GetRowAttr=attr(name)
  End Function

  Public Sub SetRowAttr(ByVal name, ByVal value)
    attr(name)=value
  End Sub

  Public Sub SetCellAttr(ByVal name, ByVal value)
    CurrentCell.SetAttr(name,value)
  End Sub
end class


public rows as New ArrayList()
public FrozenCols as Integer
private LastRow,LastHeadingRow,ResizeRowIdx

Public Function AddHeadingRow(ResizeRowFlag as Boolean)
  LastHeadingRow=AddDataRow()
  if ResizeRowFlag then ResizeRowIdx=LastHeadingRow
  AddHeadingRow=LastHeadingRow
End Function

Public Function AddDataRow()
  rows.Add(new SimpleGridRow())
  LastRow=rows.count-1
  AddDataRow=LastRow
End Function

Public Function HeadingRowCount()
  if IsNothing(LastHeadingRow) then
    HeadingRowCount=0
  else
    HeadingRowCount=LastHeadingRow+1
  end if
End Function

Public Function DataRowCount()
  if IsNothing(LastRow) then
    DataRowCount=0
  else
    DataRowCount=LastRow+1-HeadingRowCount()
  end if
End Function

' returns # of cells in the current row
Public Function CellCount()
  CellCount=rows(LastRow).CellCount
End Function

Public Sub AddCell(ByVal content as String)
  rows(LastRow).AddCell(content)
End Sub

Public Sub AddCellToRow(ByVal RowIdx as Integer, ByVal content as String)
  LastRow=RowIdx
  AddCell(content)
End Sub

Public Sub SetRowAttr(ByVal name as String, ByVal value as String)
  rows(LastRow).SetRowAttr(name,value)
End Sub

Public Sub SetCellAttr(ByVal name as String, ByVal value as String)
  rows(LastRow).SetCellAttr(name,value)
End Sub

Private Function RenderColumns(writer as HTMLTextWriter, c1 as Integer, c2 as Integer)
  dim r as Integer, c as Integer
  for c=c1 to c2
    writer.Write("<td><div class='ricoLG_col'>")
    for r=LastHeadingRow+1 to rows.count-1
      writer.Write(rows(r).cells(c).DataCell(rows(r).GetRowAttr("class")))
    next
    writer.WriteLine("</div></td>")
  next
End Function

<TemplateContainer(GetType(GridContainer))> _
Public Property GridColumns() As ITemplate
  Get
    Return _gridHeading
  End Get
  Set
    _gridHeading = value
  End Set
End Property

Protected Overrides Sub Render(writer as HTMLTextWriter)
  dim colcnt as Integer, r as Integer, c as Integer
  if IsNothing(ResizeRowIdx) then exit sub
  colcnt=rows(ResizeRowIdx).CellCount
  
  writer.WriteLine("<script type='text/javascript'>")
  if not UsingMinRico then writer.WriteLine("Rico.loadModule('SimpleGrid');")
  writer.WriteLine("var " & Me.UniqueId & " = {};")
  writer.WriteLine("Rico.onLoad( function() {")
  writer.WriteLine("  " & optionsVar & " = {")
  if FilterLocation >= -1       then writer.WriteLine("    FilterLocation: " & FilterLocation & ",")
  if not IsNothing(FilterAllToken) then writer.WriteLine("    FilterAllToken: '" & FilterAllToken & "',")
  if FilterBoxMaxLen >= 0       then writer.WriteLine("    FilterBoxMaxLen: " & FilterBoxMaxLen & ",")
  if FilterAnchorLeft           then writer.WriteLine("    FilterAnchorLeft: " & lcase(FilterAnchorLeft) & ",")
  writer.WriteLine("    columnSpecs: [")
  for c=0 to columns.count-1
    if c > 0 then writer.WriteLine(",")
    writer.Write(CType(columns(c),GridColumn).script)
  next
  writer.WriteLine(vbCrLf & "    ]")
  writer.WriteLine("  };")
  writer.WriteLine("  " & gridVar & "=new Rico.SimpleGrid('" & Me.UniqueId & "', " & optionsVar & ");")
  writer.WriteLine("});")
  writer.WriteLine("</script>")
  
  writer.Write("<div id='" & Me.UniqueId & "_outerDiv'>")

  '-------------------
  ' frozen columns
  '-------------------
  writer.WriteLine("<div id='" & Me.UniqueId & "_frozenTabsDiv'>")

  ' upper left
  writer.WriteLine("<table id='" & Me.UniqueId & "_tab0h' class='ricoLG_table ricoLG_top ricoLG_left' cellspacing='0' cellpadding='0'><thead>")
  for r=0 to LastHeadingRow
    writer.Write("<tr class='" & rows(r).HeadingClass() & "'")
    if r=ResizeRowIdx then writer.Write(" id='" & Me.UniqueId & "_tab0h_main'")
    writer.WriteLine(">")
    writer.Write(rows(r).HeadingRow(0,FrozenCols-1))
    writer.Write("</tr>")
  next
  writer.WriteLine("</thead></table>")

  ' lower left
  writer.Write("<table id='" & Me.UniqueId & "_tab0' class='ricoLG_table ricoLG_bottom ricoLG_left' cellspacing='0' cellpadding='0'>")
  writer.WriteLine("<tr>")
  RenderColumns(writer,0,FrozenCols-1)
  writer.Write("</tr>")
  writer.WriteLine("</table>")

  writer.WriteLine("</div>")


  '-------------------
  ' scrolling columns
  '-------------------

  ' upper right
  writer.Write("<div id='" & Me.UniqueId & "_innerDiv'>")
  writer.Write("<div id='" & Me.UniqueId & "_scrollTabsDiv'>")
  writer.WriteLine("<table id='" & Me.UniqueId & "_tab1h' class='ricoLG_table ricoLG_top ricoLG_right' cellspacing='0' cellpadding='0'><thead>")
  for r=0 to LastHeadingRow
    writer.Write("<tr class='" & rows(r).HeadingClass & "'")
    if r=ResizeRowIdx then writer.Write(" id='" & Me.UniqueId & "_tab1h_main'")
    writer.Write(">")
    writer.Write(rows(r).HeadingRow(FrozenCols,-1))
    writer.Write("</tr>")
  next
  writer.Write("</thead></table>")
  writer.Write("</div>")
  writer.WriteLine("</div>")

  ' lower right
  writer.Write("<div id='" & Me.UniqueId & "_scrollDiv'>")
  writer.Write("<table id='" & Me.UniqueId & "_tab1' class='ricoLG_table ricoLG_bottom ricoLG_right' cellspacing='0' cellpadding='0'>")
  writer.WriteLine("<tr>")
  RenderColumns(writer,FrozenCols,colcnt-1)
  writer.Write("</tr>")
  writer.Write("</table>")
  writer.Write("</div>")

  writer.WriteLine("</div>")
End Sub

' Response.Buffer must be true
Public Sub RenderExcel(fileName)
  Dim r as Integer, c as Integer
  Dim sw As New System.IO.StringWriter

  HttpContext.Current.Response.Clear()
  if fileName<>"" then HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" & fileName)
  HttpContext.Current.Response.ContentType = "application/ms-excel"

  sw.WriteLine("<table>")
  for r=0 to rows.count-1
    sw.WriteLine("<tr>")
    for c=0 to rows(r).CellCount()-1
      sw.Write(rows(r).cells(c).HtmlCell())
    next
    sw.WriteLine("</tr>")
  next
  sw.WriteLine("</table>")
  HttpContext.Current.Response.Write(sw.ToString)
  HttpContext.Current.Response.End()
End Sub

' Response.Buffer must be true
Public Sub RenderDelimited(fileName,delim,SubstituteChar)
  Dim r as Integer, c as Integer
  Dim sw As New System.IO.StringWriter

  HttpContext.Current.Response.Clear()
  if fileName<>"" then HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" & fileName)
  HttpContext.Current.Response.ContentType = "text/csv"

  for r=0 to rows.count-1
    for c=0 to rows(r).CellCount()-1
      if c > 0 then sw.Write(delim)
      sw.Write(replace(rows(r).cells(c).content,delim,SubstituteChar))
    next
    sw.WriteLine("")
  next
  HttpContext.Current.Response.Write(sw.ToString)
  HttpContext.Current.Response.End()
End Sub

Public Class GridContainer
  Inherits Control
  Implements INamingContainer
End Class

End Class
