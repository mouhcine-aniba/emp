
Imports System.Data
Imports System.Data.SqlClient
Partial Class entite_fontions_ModifierFonctionModal
    Inherits System.Web.UI.Page


#Region "Local_Variable"
    Dim cnx As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ApplicationServices").ConnectionString)
    Dim cmd As SqlCommand = New SqlCommand(String.Empty, cnx)
    Dim fonction As DataTable = New DataTable()
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
            error_lbl.Text = ex.Message
            error_panel.CssClass = "d-block"
            cnx.Close()
            Return Nothing
        End Try
    End Function
    Function get_FonctionById(id_fonction As Integer) As DataTable
        Try
            cnx.Open()
            cmd.CommandText = "select * from getFonction(@id_fonction)"
            cmd.Parameters.AddWithValue("@id_fonction", id_fonction)
            Dim reader = cmd.ExecuteReader()
            Dim dt = New DataTable()
            dt.Load(reader)
            cnx.Close()
            Return dt
        Catch ex As Exception
            error_lbl.Text = ex.Message
            error_panel.CssClass = "d-block"
            cnx.Close()
        End Try
        Return Nothing
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
            error_lbl.Text = ex.Message
            error_panel.CssClass = "d-block"
            cnx.Close()
        End Try
        Return Nothing
    End Function
    Sub EditFonction(id_fonction As Integer, nom_fonction As String, nom_fonction_ar As String, Entite As Integer, fonc_sup As Integer)
        Try
            cnx.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "EditFonction"
            cmd.Parameters.AddWithValue("@id_fonction", id_fonction)
            cmd.Parameters.AddWithValue("@nom_fonction", nom_fonction)
            cmd.Parameters.AddWithValue("@nom_fonction_ar", nom_fonction_ar)
            cmd.Parameters.AddWithValue("@Entite", Entite)
            cmd.Parameters.AddWithValue("@foncSup", fonc_sup)
            cmd.ExecuteNonQuery()
            cnx.Close()
        Catch ex As Exception
            error_lbl.Text = ex.Message
            error_panel.CssClass = "d-block"
            cnx.Close()
        End Try
    End Sub
#End Region

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim id_fonction = Integer.Parse(Request.QueryString("id_fonc"))
            HiddenField_id_fonc.Value = id_fonction
            fonction = get_FonctionById(id_fonction)

            txt_titreAr.Text = fonction.Rows(0)("nom_fonction_ar").ToString()
            txt_titreFr.Text = fonction.Rows(0)("nom_fonction").ToString()

            ent_sup_dropDown.DataSource = get_entites()
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

    Protected Sub Modifier_btn_Click(sender As Object, e As EventArgs)
        EditFonction(Integer.Parse(HiddenField_id_fonc.Value), txt_titreFr.Text, txt_titreAr.Text, ent_sup_dropDown.SelectedValue, foncs_dropDown.SelectedValue)
        success_panel.CssClass = "d-block"
    End Sub
End Class
