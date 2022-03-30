<%@ Control Language="vb" debug="true"%>
<%@ Import Namespace="System.Xml" %>
<script runat="server">

public tags as string
public flickrKey as String

Protected Overrides Sub Render(writer as HTMLTextWriter)
  writer.WriteLine("<rows update_ui='true' offset='0'>")

  dim url as string = "http://api.flickr.com/services/rest/?method=flickr.photos.search"
  dim cnt as integer = 0
  if (tags <> "") then
    url &= "&safe_search=1"
    url &= "&tag_mode=all"
    url &= "&sort=interestingness-desc"
    url &= "&extras=date_taken,owner_name,geo,tags"
    url &= "&tags=" & tags
    url &= "&api_key=" & flickrKey
    
    Dim doc As XmlDocument = New XmlDocument()
    doc.Load(url)                     
    Dim root As XmlElement = doc.DocumentElement
    'writer.WriteLine(root.OuterXml)
    Dim photoNodes = root.GetElementsByTagName("photo")
    Dim node as object, photourl as string
    For Each node In photoNodes
      writer.WriteLine("<tr>")
      ' "_s" suffix specifies a 75x75 pixel format
      photourl = "http://farm" & node.Attributes("farm").value & ".static.flickr.com/" & node.Attributes("server").value & "/" & node.Attributes("id").value & "_" & node.Attributes("secret").value & "_s.jpg"
      writer.WriteLine(XmlStringCell(photourl))
      writer.WriteLine(XmlStringCell(node.Attributes("title").value))
      writer.WriteLine(XmlStringCell(node.Attributes("ownername").value))
      writer.WriteLine(XmlStringCell(node.Attributes("datetaken").value))
      writer.WriteLine(XmlStringCell(node.Attributes("tags").value))
      writer.WriteLine("</tr>")
      cnt += 1
    Next

  end if

  writer.WriteLine("</rows>")
  writer.WriteLine("<rowcount>" & cnt & "</rowcount>")
End Sub

Public function XmlStringCell(value as object) as String
  XmlStringCell="<td>" & server.HTMLEncode(value) & "</td>"
end function

</script>
