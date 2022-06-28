Imports System.Data
Imports System.Data.SqlClient

Partial Class entite_fontions_gestion_fonctions
    Inherits System.Web.UI.Page


#Region "Local_Variable"
    Dim cnx As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ApplicationServices").ConnectionString)
    Dim cmd As SqlCommand = New SqlCommand(String.Empty, cnx)
    Dim fonctions As DataTable = New DataTable()
    Dim fms As fmps.FlashMessage
#End Region

#Region "Operations"
    Function get_entites() As DataTable
        Try
            cnx.Open()
            cmd.CommandText = "select * from emp_entite"
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
            cmd.CommandText = "select * from getFonctions()"
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
    Sub AddFonction(nom_fonction As String, nom_fonction_ar As String, Entite As Integer, fonc_sup As Integer)
        Try
            cnx.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "AddFonction"
            cmd.Parameters.AddWithValue("@nom_fonction", nom_fonction)
            cmd.Parameters.AddWithValue("@nom_fonction_ar", nom_fonction_ar)
            cmd.Parameters.AddWithValue("@Entite", Entite)
            cmd.Parameters.AddWithValue("@fonc_sup", fonc_sup)
            Dim param = cmd.Parameters.Add("@nb_row", SqlDbType.Int)
            cmd.Parameters("@nb_row").Direction = ParameterDirection.ReturnValue
            cmd.ExecuteNonQuery()
            Dim result = param.Value
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

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            fonctions = get_fonctions()
            foncs_repeater.DataSource = fonctions
            foncs_repeater.DataBind()

            ent_dropDown.DataSource = get_entites()
            ent_dropDown.DataValueField = "id_emp_entite"
            ent_dropDown.DataTextField = "titre"
            ent_dropDown.DataBind()

            foncs_dropDown.DataSource = get_fonctions()
            foncs_dropDown.DataValueField = "id_emp_fonction"
            foncs_dropDown.DataTextField = "nom_fonction"
            foncs_dropDown.DataBind()

            If (HttpContext.Current.User.Identity.IsAuthenticated) Then
                HiddenField_user.Value = Membership.GetUser(HttpContext.Current.User.Identity.Name, False).ProviderUserKey.ToString()
            End If
        End If
    End Sub

    Protected Sub add_btn_Click(sender As Object, e As EventArgs)
        AddFonction(txt_titreFr.Text, txt_titreAr.Text, ent_dropDown.SelectedValue, foncs_dropDown.SelectedValue)
        Response.Redirect(Request.Url.ToString())
        fms = New fmps.FlashMessage(fmps.FlashMessage.FlashMessageCssType.success, fmps.FlashMessage.MessageType.Modification, "Opération avec succès")
        fms.Save()
    End Sub

    Protected Sub LinkButton_delete_Click(sender As Object, e As EventArgs)
        Try
            Dim item As RepeaterItem = TryCast((TryCast(sender, LinkButton)).NamingContainer, RepeaterItem)
            Dim id As Integer = Convert.ToInt32((TryCast(item.FindControl("Label_id"), Label)).Text)
            Dim result As Integer
            cnx.Open()
            cmd = New SqlCommand("DeleteFonction", cnx)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@id_fonction", id)
            cmd.Parameters.Add("@nb_row", SqlDbType.Int)
            cmd.Parameters("@nb_row").Direction = ParameterDirection.ReturnValue
            cmd.ExecuteNonQuery()
            result = Integer.Parse(cmd.Parameters("@nb_row").Value)
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
End Class