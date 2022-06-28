
Imports System.Data
Imports System.Data.SqlClient

Partial Class entite_fontions_gestion_entite
    Inherits System.Web.UI.Page

#Region "Local_Variable"
    Dim cnx As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ApplicationServices").ConnectionString)
    Dim cmd As SqlCommand = New SqlCommand(String.Empty, cnx)
    Dim entites As DataTable = New DataTable()
    Dim fms As fmps.FlashMessage
#End Region

#Region "Events"

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            entites = get_entites()
            entite_repeater.DataSource = entites
            entite_repeater.DataBind()

            ent_sup_dropDown.DataSource = entites
            ent_sup_dropDown.DataValueField = "id_emp_entite"
            ent_sup_dropDown.DataTextField = "titre"
            ent_sup_dropDown.DataBind()

            foncs_dropDown.DataSource = get_fonctions()
            foncs_dropDown.DataValueField = "id_emp_fonction"
            foncs_dropDown.DataTextField = "nom_fonction"
            foncs_dropDown.DataBind()
            If (HttpContext.Current.User.Identity.IsAuthenticated) Then
                HiddenField_user.Value = Membership.GetUser(HttpContext.Current.User.Identity.Name, False).ProviderUserKey.ToString()
            End If
        End If
    End Sub
    Protected Sub LinkButton_delete_Click(sender As Object, e As EventArgs)
        Try
            Dim item As RepeaterItem = TryCast((TryCast(sender, LinkButton)).NamingContainer, RepeaterItem)
            Dim id As Integer = Convert.ToInt32((TryCast(item.FindControl("Label_id"), Label)).Text)
            cnx.Open()
            cmd = New SqlCommand("deleteEntite", cnx)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@id_entite", id)
            Dim row_param = cmd.Parameters.Add("@nb_row", SqlDbType.Int)
            cmd.Parameters("@nb_row").Direction = ParameterDirection.ReturnValue
            cmd.ExecuteNonQuery()
            Dim result = Integer.Parse(row_param.Value)
            cnx.Close()
            If (result > 0) Then
                fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.success, fmps.FlashMessage.MessageType.Modification, "Opération avec succès")
                fms.Save()
                cnx.Close()
                Response.Redirect(Request.Url.ToString(), False)
                Return
            Else
                Throw New Exception("Cette opération a échoué. ")
                Return
            End If
        Catch ex As Exception
            fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.danger, fmps.FlashMessage.MessageType.Erreur, "Cette opération a échoué. ")
            fms.Save()
            cnx.Close()
            Response.Redirect(Request.Url.ToString())
            Return
        End Try
    End Sub

    Protected Sub add_btn_Click(sender As Object, e As EventArgs)
        AddEntite(txt_titreFr.Text, txt_titreAr.Text, Integer.Parse(ent_sup_dropDown.SelectedValue), Integer.Parse(foncs_dropDown.SelectedValue), txt_abrv.Text)
        fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.success, fmps.FlashMessage.MessageType.Modification, "Opération avec succès")
        fms.Save()
        Response.Redirect(Request.Url.ToString())
    End Sub
#End Region

#Region "Operations"
    Function get_entites() As DataTable
        Try
            cnx.Open()
            cmd.CommandText = "select * from getEntites()"
            Dim reader = cmd.ExecuteReader()
            Dim dt = New DataTable()
            dt.Load(reader)
            cnx.Close()
            Return dt
        Catch ex As Exception
            fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.danger, fmps.FlashMessage.MessageType.Erreur, "Cette opération a échoué. ")
            fms.Save()
            cnx.Close()
            Return Nothing
        End Try
    End Function
    Function get_fonctions() As DataTable
        Try
            cnx.Open()
            cmd.CommandText = "select * from emp_fonction"
            Dim reader = cmd.ExecuteReader()
            Dim dt = New DataTable()
            dt.Load(reader)

            cnx.Close()
            Return dt
        Catch ex As Exception
            fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.danger, fmps.FlashMessage.MessageType.Erreur, "Cette opération a échoué. ")
            fms.Save()
            cnx.Close()
            Return Nothing
        End Try
    End Function
    Sub AddEntite(titre As String, titre_ar As String, Entite_sup As Integer, foncChef As Integer, abrv As String)
        Try
            cnx.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "AddEntite"
            cmd.Parameters.AddWithValue("@titre", titre)
            cmd.Parameters.AddWithValue("@titre_ar", titre_ar)
            cmd.Parameters.AddWithValue("@Entite_sup", Entite_sup)
            cmd.Parameters.AddWithValue("@foncChef", foncChef)
            cmd.Parameters.AddWithValue("@abrv", abrv)
            Dim param = cmd.Parameters.Add("@nb_row", SqlDbType.Int)
            cmd.Parameters("@nb_row").Direction = ParameterDirection.ReturnValue
            Dim result As Integer
            cmd.ExecuteNonQuery()
            result = param.Value
            If (result > 0) Then
                fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.success, fmps.FlashMessage.MessageType.Modification, "Opération avec succès")
                fms.Save()
                cnx.Close()
                Response.Redirect(Request.Url.ToString(), False)
                Return
            Else
                Throw New Exception("Cette opération a échoué. ")
                Return
            End If
        Catch ex As Exception
            fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.danger, fmps.FlashMessage.MessageType.Erreur, "Cette opération a échoué. ")
            fms.Save()
            cnx.Close()
            Response.Redirect(Request.Url.ToString())
        End Try
    End Sub
#End Region
End Class
