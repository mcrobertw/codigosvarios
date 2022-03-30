Partial Class sqlCompatibilty
Inherits System.Web.UI.UserControl

' ---------------------------------------------------------------------------
' Functions to allow cross-db compatibility within Rico
'
' SQL dialect possible values: Access, Oracle, TSQL (MS SQL Server)
' ---------------------------------------------------------------------------

Protected Dialect as String

Sub New(dbDialect as String)
  Dialect=dbDialect
End Sub

Sub New()
End Sub

Sub SetDialectFromProvider(Provider as String)
  Provider=ucase(Provider)
  if Provider="SQLOLEDB" then
    Dialect="TSQL"
  elseif InStr(Provider,"ORACLE")>0 then
    Dialect="Oracle"
  elseif InStr(Provider,"JET")>0 then
    Dialect="Access"
  else
    Throw New Exception("Unknown ADO provider")
  end if
End Sub

Public function CurrentTime() as String
  select case Dialect
    case "TSQL","DB2": CurrentTime="CURRENT_TIMESTAMP"
    case "Access": CurrentTime="Now()"
    case else: CurrentTime="LOCALTIMESTAMP"
  end select
end function

Public function Convert2Char(s as String) as String
  select case Dialect
    case "TSQL"  : Convert2Char="cast(" & s & " as varchar)"
    case "Access": Convert2Char="CStr(" & s & ")"
    case "DB2"   : Convert2Char="CHAR(" & s & ")"
    case "Oracle": Convert2Char="cast(" & s & " as varchar2(20))"
    case else: Convert2Char=s   ' implicit conversion (MySQL)
  end select
end function

Public function Wildcard() as String
  Wildcard="%"
end function

Public function SqlDay(s as String) as String
  select case Dialect
    case "Oracle": SqlDay="to_char(" & s & ",'DD')"
    case "MySQL":  SqlDay="dayofmonth(" & s & ")"
    case else: SqlDay="day(" & s & ")"
  end select
end function

Public function SqlMonth(s as String) as String
  select case Dialect
    case "Oracle": SqlMonth="to_char(" & s & ",'MM')"
    case else: SqlMonth="month(" & s & ")"
  end select
end function

Public function SqlYear(s as String) as String
  select case Dialect
    case "Oracle": SqlYear="to_char(" & s & ",'YYYY')"
    case else: SqlYear="year(" & s & ")"
  end select
end function

Public function addQuotes(s as String) as String
  select case Dialect
    case "Access":
      if IsDate(s) then
        addQuotes="#" & s & "#"
      else
        addQuotes="""" & replace(s,"""","""""") & """"
      end if
    case "MySQL":  addQuotes="'" & replace(replace(s,"\","\\"),"'","\'") & "'"
    case else:     addQuotes="'" & replace(s,"'","''") & "'"
  end select
end function

Public function Concat(arStrings() as String, addQuotes as Boolean) as String
  dim i as Integer
  if addQuotes then
    For Each i in arStrings
      'arStrings(i)=addQuotes(arStrings(i))
    next
  end if
  select case Dialect
    case "TSQL": Concat=join(arStrings,"+")
    case "Access": Concat=join(arStrings," & ")
    case "MySQL": Concat="concat(" & join(arStrings,",") & ")"
    case else: Concat=join(arStrings," || ")
  end select
end function

End Class
