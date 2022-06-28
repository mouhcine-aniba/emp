
Imports System.Data
Imports System.Data.SqlClient

Partial Class entite_fontions_ModifierEntiteModal
    Inherits System.Web.UI.Page


#Region "Local_Variable"
    Dim cnx As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ApplicationServices").ConnectionString)
    Dim cmd As SqlCommand = New SqlCommand(String.Empty, cnx)
    Dim entite As DataTable = New DataTable()
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
            error_lbl.Text = ex.Message
            error_panel.CssClass = "d-block"
            cnx.Close()
            Return Nothing
        End Try
    End Function
    Function get_entitesById(id_entite As Integer) As DataTable
        Try
            cnx.Open()
            cmd.CommandText = "select * from getEntiteByID(@id_entite)"
            cmd.Parameters.AddWithValue("@id_entite", id_entite)
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
    Sub EditEntite(id_entite As Integer, titre As String, titre_ar As String, Entite_sup As Integer, foncChef As Integer, abrv As String)
        Try
            cnx.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "EditEntite"
            cmd.Parameters.AddWithValue("@id_entite", id_entite)
            cmd.Parameters.AddWithValue("@titre", titre)
            cmd.Parameters.AddWithValue("@titre_ar", titre_ar)
            cmd.Parameters.AddWithValue("@Entite_sup", Entite_sup)
            cmd.Parameters.AddWithValue("@foncChef", foncChef)
            cmd.Parameters.AddWithValue("@abrv", abrv)
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
        Try

            If Not Page.IsPostBack Then
                If Request.QueryString("id_entite") Is Nothing Then
                    Throw New Exception("ID NOT FOUND")
                End If

                Dim id_entite = Integer.Parse(Request.QueryString("id_entite"))
                    entite = get_entitesById(id_entite)
                    HiddenField_id_entite.Value = id_entite

                txt_abrv.Text = entite.Rows(0)("abreviation")
                txt_titreAr.Text = entite.Rows(0)("titre_ar")
                    txt_titreFr.Text = entite.Rows(0)("titre")

                    ent_sup_dropDown.DataSource = get_entites()
                    ent_sup_dropDown.DataValueField = "id_emp_entite"
                    ent_sup_dropDown.DataTextField = "titre"
                    ent_sup_dropDown.DataBind()
                    ent_sup_dropDown.SelectedValue = entite.Rows(0)("id_emp_entite")

                    foncs_dropDown.DataSource = get_fonctions()
                    foncs_dropDown.DataValueField = "id_emp_fonction"
                    foncs_dropDown.DataTextField = "nom_fonction"
                    foncs_dropDown.DataBind()
                    foncs_dropDown.SelectedValue = entite.Rows(0)("id_emp_fonction")

                    If (HttpContext.Current.User.Identity.IsAuthenticated) Then
                        HiddenField_user.Value = Membership.GetUser(HttpContext.Current.User.Identity.Name, False).ProviderUserKey.ToString()
                    End If
                End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Modifier_btn_Click(sender As Object, e As EventArgs)
        EditEntite(Integer.Parse(HiddenField_id_entite.Value), txt_titreFr.Text, txt_titreAr.Text, ent_sup_dropDown.SelectedValue, foncs_dropDown.SelectedValue, txt_abrv.Text)
        success_panel.CssClass = "d-block"
    End Sub
End Class
