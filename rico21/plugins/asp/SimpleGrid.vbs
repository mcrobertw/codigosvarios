<%

class SimpleGridCell
  public content
  private attr

  Private Sub Class_Initialize
    set attr = CreateObject("Scripting.Dictionary")
  End sub

  Private Sub Class_Terminate
    set attr = Nothing
  End sub

  Public Function HeadingCell()
    Dim s, span
    s="<td"
    span=1
    If attr.exists("colspan") Then
      span=attr("colspan")
      s=s & " colspan='" & span & "'"
    End If
    HeadingCell = Array(s & "><div class='ricoLG_col'>" & DataCell("") & "</div></td>", span)
  End Function

  Public Function DataCell(rowclass)
    dim s,k
    s = "<div"
    attr("class")=trim("ricoLG_cell " & attr("class") & " " & rowclass)
    for each k in attr.keys
      If k<>"colspan" Then s=s & " " & k & "='" & attr(k) & "'"
    next
    s=s & ">" & content & "</div>"
    DataCell=s
  End Function

  Public Function HtmlCell()
    dim s,k
    s = "<td"
    for each k in attr.keys
      s=s & " " & k & "='" & attr(k) & "'"
    next
    s=s & ">" & content & "</td>"
    HtmlCell=s
  End Function

  Public Sub SetAttr(name,value)
    attr(name)=value
  End Sub
End class


class SimpleGridRow
  public cells()
  private attr, CurrentCell

  Private Sub Class_Initialize
    redim cells(-1)
    set attr = CreateObject("Scripting.Dictionary")
  end sub

  Private Sub Class_Terminate
    set attr = Nothing
  end sub
  
  Public Sub AddCell(ByVal content)
    ReDim Preserve cells(ubound(cells)+1)
    set CurrentCell=new SimpleGridCell
    set cells(ubound(cells))=CurrentCell
    CurrentCell.content=content
  End Sub
  
  Public Function HeadingRow(ByVal c1, ByVal c2)
    dim cellidx,colidx,s,a
    cellidx=0
    colidx=0
    while colidx < c1 and cellidx <= ubound(cells)
      a=cells(cellidx).HeadingCell()
      colidx=colidx+CInt(a(1))
      cellidx=cellidx+1
    Wend
    while (colidx <= c2 or c2=-1) and cellidx <= ubound(cells)
      a=cells(cellidx).HeadingCell()
      s=s & a(0)
      colidx=colidx+CInt(a(1))
      cellidx=cellidx+1
    wend
    HeadingRow = s
  End Function
  
  Public Function HeadingClass()
    HeadingClass=trim("ricoLG_hdg " & attr("class"))
  End Function
  
  Public Function CellCount()
    CellCount=ubound(cells)+1
  End Function

  Public Function GetRowAttr(ByVal name)
    GetRowAttr=attr(name)
  End Function

  Public Sub SetRowAttr(ByVal name, ByVal value)
    attr(name)=value
  End Sub

  Public Sub SetCellAttr(ByVal name, ByVal value)
    CurrentCell.SetAttr name,value
  End Sub
end class


class SimpleGrid
  public rows()
  private LastRow,LastHeadingRow,ResizeRowIdx

  Private Sub Class_Initialize
    redim rows(-1)
  End sub

  Public Function AddHeadingRow(ResizeRowFlag)
    LastHeadingRow=AddDataRow
    if ResizeRowFlag then ResizeRowIdx=LastHeadingRow
    AddHeadingRow=LastHeadingRow
  End Function
  
  Public Function AddDataRow()
    ReDim Preserve rows(ubound(rows)+1)
    set rows(ubound(rows))=new SimpleGridRow
    LastRow=ubound(rows)
    AddDataRow=LastRow
  End Function
  
  Public Function HeadingRowCount()
    if IsEmpty(LastHeadingRow) then
      HeadingRowCount=0
    else
      HeadingRowCount=LastHeadingRow+1
    end if
  End Function
  
  Public Function DataRowCount()
    if IsEmpty(LastRow) then
      DataRowCount=0
    else
      DataRowCount=LastRow+1-HeadingRowCount()
    end if
  End Function
  
  ' returns # of cells in the current row
  Public Function CellCount()
    CellCount=rows(LastRow).CellCount
  End Function

  Public Sub AddCell(ByVal content)
    rows(LastRow).AddCell content
  End Sub
  
  Public Sub AddCellToRow(ByVal RowIdx, ByVal content)
    LastRow=RowIdx
    AddCell content
  End Sub
  
  Public Sub SetRowAttr(ByVal name, ByVal value)
    rows(LastRow).SetRowAttr name,value
  End Sub

  Public Sub SetCellAttr(ByVal name, ByVal value)
    rows(LastRow).SetCellAttr name,value
  End Sub

  Private Function RenderColumns(ByVal c1, ByVal c2)
    dim r,c
    for c=c1 to c2
      response.write vbLf & "<td><div class='ricoLG_col'>"
      for r=LastHeadingRow+1 to ubound(rows)
        response.write rows(r).cells(c).DataCell(rows(r).GetRowAttr("class"))
      next
      response.write "</div></td>"
    next
  End Function

  ' Response.Buffer must be true
  Public Sub RenderExcel(fileName)
    dim r,c
    Response.Clear
    if fileName<>"" then Response.AddHeader "content-disposition", "attachment; filename=" & fileName
    'Response.ContentType = "application/vnd.ms-excel"
    Response.ContentType = "application/ms-excel"

    response.write vbLf & "<table>"
    for r=0 to ubound(rows)
      response.write vbLf & "<tr>"
      for c=0 to ubound(rows(r).cells)
        response.write rows(r).cells(c).HtmlCell
      next
      response.write vbLf & "</tr>"
    next
    response.write vbLf & "</table>"
    Response.End
  End Sub

  ' Response.Buffer must be true
  Public Sub RenderDelimited(fileName,delim,SubstituteChar)
    dim r,c
    Response.Clear
    if fileName<>"" then Response.AddHeader "content-disposition", "attachment; filename=" & fileName
    Response.ContentType = "text/csv"

    for r=0 to ubound(rows)
      for c=0 to ubound(rows(r).cells)
        if c > 0 then response.write delim
        response.write replace(rows(r).cells(c).content,delim,SubstituteChar)
      next
      response.write vbLf
    next
    Response.End
  End Sub

  Public Sub Render(ByVal id, FrozenCols)
    dim colcnt,r,c
    if IsEmpty(ResizeRowIdx) then exit sub
    colcnt=rows(ResizeRowIdx).CellCount
    response.write vbLf & "<div id='" & id & "_outerDiv'>"

    '-------------------
    ' frozen columns
    '-------------------
    response.write vbLf & "<div id='" & id & "_frozenTabsDiv'>"

    ' upper left
    response.write vbLf & "<table id='" & id & "_tab0h' class='ricoLG_table ricoLG_top ricoLG_left' cellspacing='0' cellpadding='0'><thead>"
    for r=0 to LastHeadingRow
      response.write vbLf & "<tr class='" & rows(r).HeadingClass & "'"
      if r=ResizeRowIdx then response.write " id='" & id & "_tab0h_main'"
      response.write ">"
      response.write rows(r).HeadingRow(0,FrozenCols-1)
      response.write vbLf & "</tr>"
    next
    response.write vbLf & "</thead></table>"

    ' lower left
    response.write "<table id='" & id & "_tab0' class='ricoLG_table ricoLG_bottom ricoLG_left' cellspacing='0' cellpadding='0'>"
    response.write vbLf & "<tr>"
    RenderColumns 0,FrozenCols-1
    response.write vbLf & "</tr>"
    response.write vbLf & "</table>"

    response.write vbLf & "</div>"


    '-------------------
    ' scrolling columns
    '-------------------

    ' upper right
    response.write vbLf & "<div id='" & id & "_innerDiv'>"
    response.write vbLf & "<div id='" & id & "_scrollTabsDiv'>"
    response.write vbLf & "<table id='" & id & "_tab1h' class='ricoLG_table ricoLG_top ricoLG_right' cellspacing='0' cellpadding='0'><thead>"
    for r=0 to LastHeadingRow
      response.write vbLf & "<tr class='" & rows(r).HeadingClass & "'"
      if r=ResizeRowIdx then response.write " id='" & id & "_tab1h_main'"
      response.write ">"
      response.write rows(r).HeadingRow(FrozenCols,-1)
      response.write vbLf & "</tr>"
    next
    response.write vbLf & "</thead></table>"
    response.write vbLf & "</div>"
    response.write vbLf & "</div>"

    ' lower right
    response.write vbLf & "<div id='" & id & "_scrollDiv'>"
    response.write vbLf & "<table id='" & id & "_tab1' class='ricoLG_table ricoLG_bottom ricoLG_right' cellspacing='0' cellpadding='0'>"
    response.write vbLf & "<tr>"
    RenderColumns FrozenCols,colcnt-1
    response.write vbLf & "</tr>"
    response.write vbLf & "</table>"
    response.write vbLf & "</div>"

    response.write vbLf & "</div>"
  End Sub
end class

%>
