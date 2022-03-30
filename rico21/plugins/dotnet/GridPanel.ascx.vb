Partial Class GridPanel
Inherits System.Web.UI.UserControl

private _heading as string

public property heading as string
  get
    return _heading
  end get
  set
    _heading=value
  end set
end property

End Class
