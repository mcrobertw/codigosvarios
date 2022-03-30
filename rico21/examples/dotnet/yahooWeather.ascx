<%@ Control Language="vb" debug="true"%>
<%@ Import Namespace="System.Xml" %>
<script runat="server">

Public unit as String = "C"   ' c or f
Public Shared country as String

Protected Overrides Sub Render(writer as HTMLTextWriter)
  dim url as string = "http://xml.weather.yahoo.com/forecastrss"

  url &= "?u=" & lcase(unit)
  url &= "&p=" & Me.UniqueId
  
  Dim doc As XmlDocument = New XmlDocument()
  doc.Load(url)                     
  Dim root As XmlElement = doc.DocumentElement
  'writer.WriteLine(root.OuterXml)   ' for debugging
  Dim items = root.GetElementsByTagName("item")
  Dim astr = root.GetElementsByTagName("yweather:astronomy")
  Dim loc = root.GetElementsByTagName("yweather:location")
  if items.count <> 1 or loc.count <> 1 then exit sub
  dim current = items(0).GetElementsByTagName("yweather:condition")
  dim fcst = items(0).GetElementsByTagName("yweather:forecast")
  dim pub = items(0).GetElementsByTagName("pubDate")

  writer.WriteLine("<tr>")

  dim city as string = loc(0).Attributes("city").value
  if left(Me.UniqueId,2)=country then
    writer.WriteLine(XmlStringCellStyle(city,"background-color:yellow;"))
  else
    writer.WriteLine(XmlStringCell(city))
  end if

  if astr.count = 1 then
    writer.WriteLine(XmlStringCell(astr(0).Attributes("sunrise").value))
    writer.WriteLine(XmlStringCell(astr(0).Attributes("sunset").value))
  else
    writer.WriteLine(XmlStringCell(""))
    writer.WriteLine(XmlStringCell(""))
  end if

  if current.count = 1 then
    writer.WriteLine(XmlStringCell(current(0).Attributes("text").value))
    writer.WriteLine(tempCell(current(0).Attributes("temp").value))
  else
    writer.WriteLine(XmlStringCell(""))
    writer.WriteLine(XmlStringCell(""))
  end if

  if fcst.count > 0 then
    writer.WriteLine(tempCell(fcst(0).Attributes("low").value))
    writer.WriteLine(tempCell(fcst(0).Attributes("high").value))
    writer.WriteLine(XmlStringCell(fcst(0).Attributes("text").value))
  else
    writer.WriteLine(XmlStringCell(""))
    writer.WriteLine(XmlStringCell(""))
    writer.WriteLine(XmlStringCell(""))
  end if

  if pub.count = 1 then
    writer.WriteLine(XmlStringCell(pub(0).innerText))
  else
    writer.WriteLine(XmlStringCell(""))
  end if

  writer.WriteLine(XmlStringCell("live"))  ' caching not supported

  writer.WriteLine("</tr>")
End Sub

Public function XmlStringCell(value as object) as String
  XmlStringCell="<td>" & server.HTMLEncode(value) & "</td>"
end function

Public function XmlStringCellStyle(value as object, style as String) as String
  XmlStringCellStyle="<td style='" & style & "'>" & server.HTMLEncode(value) & "</td>"
end function

Public function tempCell(temp as object) as String
  if not IsNumeric(temp) then
    tempCell = XmlStringCell(temp)
  elseif CInt(temp) <= 0 then
    tempCell = XmlStringCellStyle(temp,"background-color:blue;color:white;")
  elseif CInt(temp) >= 32 then
    tempCell = XmlStringCellStyle(temp,"background-color:red;color:white;")
  else
    tempCell = XmlStringCell(temp)
  end if
end function

</script>
