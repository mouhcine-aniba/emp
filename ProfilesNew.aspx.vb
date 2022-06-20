
Partial Class emp_Profiles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If (HttpContext.Current.User.Identity.IsAuthenticated) Then
                HiddenField1.Value = Membership.GetUser(HttpContext.Current.User.Identity.Name, False).ProviderUserKey.ToString()
            End If
        End If
    End Sub
End Class
