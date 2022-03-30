<script language="VB" runat="server">

public readonly property StyleInclude as string
  get
    dim styleValue as string = style.SelectedItem.Value
    if styleValue="" then
      return ""
    else
      return "Rico.include('" & styleValue & ".css');"
    end if
  end get
end property

public property FilterEnabled as boolean
  get
    return filter.enabled
  end get
  set
    filter.checked=value
    filter.enabled=value
  end set
end property

public property FrozenEnabled as boolean
  get
    return frozen.enabled
  end get
  set
    frozen.enabled=value
  end set
end property

public readonly property MenuSetting as string
  get
    return menu.SelectedItem.Value
  end get
end property

public readonly property GridSettingsScript as string
  get
    dim s as string
    s="menuEvent     : '" & menu.SelectedItem.Value & "'," & vbLf & _
      "frozenColumns : " & frozen.SelectedItem.Value & "," & vbLf & _
      "canSortDefault: " & lcase(sort.checked) & "," & vbLf & _
      "canHideDefault: " & lcase(hide.checked) & "," & vbLf & _
      "allowColResize: " & lcase(resize.checked) & "," & vbLf & _
      "canFilterDefault: " & lcase(filter.checked) & "," & vbLf & _
      "highlightElem: '" & highlt.SelectedItem.Value & "'"
    return s
  end get
end property

public sub GridSettingsTE(oTE as object)
  oTE.options("menuEvent")=menu.SelectedItem.Value
  oTE.options("canSortDefault")=sort.checked
  oTE.options("canHideDefault")=hide.checked
  oTE.options("allowColResize")=resize.checked
  oTE.options("canFilterDefault")=filter.checked
  oTE.options("frozenColumns")=frozen.SelectedItem.Value
  oTE.options("highlightElem")=highlt.SelectedItem.Value
end sub

public sub ApplyGridSettings(grid as object)
  grid.menuEvent=menu.SelectedItem.Value
  grid.canSortDefault=sort.checked
  grid.canHideDefault=hide.checked
  grid.allowColResize=resize.checked
  grid.canFilterDefault=filter.checked
  grid.frozenColumns=frozen.SelectedItem.Value
  grid.highlightElem=highlt.SelectedItem.Value
end sub

</script>


<table border='0' cellspacing='5' cellpadding='0' class='demoSettings'>

<tr><td colspan='2'>
<asp:Button id="Submit1" Text="Change Settings" runat="server" />
</td></tr>
<tr valign=top><td>

<table border='0' cellspacing='0' cellpadding='0'>

<tr><td>Style:</td><td>
<asp:DropDownList id='style' runat='server'>
<asp:ListItem value='greenHdg' text='Green Heading' />
<asp:ListItem value='tanChisel' text='Tan chisel' />
<asp:ListItem value='warmfall' text='Warm Fall' />
<asp:ListItem value='iegradient' text='IE gradient' />
<asp:ListItem value='coffee-with-milk' text='Coffee with milk' />
<asp:ListItem value='grayedout' text='Grayed out' />
</asp:DropDownList>
</td></tr>

<tr><td>Menu&nbsp;event:</td><td>
<asp:DropDownList id='menu' runat='server'>
<asp:ListItem value='click' text='Click' />
<asp:ListItem value='dblclick' selected='true' text='Double-click' />
<asp:ListItem value='contextmenu' text='Right-click' />
<asp:ListItem value='none' text='None' />
</asp:DropDownList>
</td></tr>

<tr><td>Highlight:</td><td>
<asp:DropDownList id='highlt' runat='server'>
<asp:ListItem value='cursorCell' text='Cursor Cell' />
<asp:ListItem value='cursorRow' text='Cursor Row' />
<asp:ListItem value='menuCell' text='Menu Cell' />
<asp:ListItem value='menuRow' text='Menu Row' />
<asp:ListItem value='selection' text='Selection' />
<asp:ListItem value='none' text='None' selected='true' />
</asp:DropDownList>
</td></tr>

<tr><td>Frozen columns:</td><td>
<asp:DropDownList id='frozen' runat='server'>
<asp:ListItem value='0' text='0' />
<asp:ListItem value='1' text='1' selected='true' />
<asp:ListItem value='2' text='2' />
<asp:ListItem value='3' text='3' />
</asp:DropDownList>
</td></tr>

</table>

</td><td>

<asp:Checkbox id='sort' checked='true' runat="server" />&nbsp;Sorting?<br>
<asp:Checkbox id='filter' runat="server" />&nbsp;Filtering?<br>
<asp:Checkbox id='hide' checked='true' runat="server" />&nbsp;Hide/Show?<br>
<asp:Checkbox id='resize' checked='true' runat="server" />&nbsp;Resizing?

</td></tr>
</table>

