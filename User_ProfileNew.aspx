<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="User_ProfileNew.aspx.vb" Inherits="emp_User_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
    <style>
        #content-wrapper {
            

        }
        .card-header h6 
        {
            font-family: 'Montserrat', sans-serif;
            font-size: larger;
        }
        /* typical phone screen resolution */
        @media only screen and (max-width : 667px) {
            .container-fluid {
            display:flex;
            justify-content:center;
            }
            #accordionSidebar {
                display:none;
            }
        }
        /* landscape orientation */
        @media only screen and (min-width : 375px) and (max-width : 667px) and (orientation : landscape) {
        }
        /* portrait orientation */
        @media only screen and (min-width : 375px) and (max-width : 667px) and (orientation : portrait) {
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2"  ContentPlaceHolderID="MainContent" Runat="Server">

     <asp:SqlDataSource ID="SqlDataSource_Situation_Familiale" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="SELECT [id_emp_situation_familiale], [situation_familiale] FROM [emp_situation_familiale]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Fonction" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="select -1 as id_emp_fonction ,'---' as nom_fonction UNION SELECT [id_emp_fonction], [nom_fonction] FROM [emp_fonction]"></asp:SqlDataSource>
    <div class="">
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        
            SelectCommand="SELECT     user_profile.dept,   user_profile.id_user_profile, user_profile.user_loger, CASE WHEN user_profile.nom IS NULL OR
                         user_profile.prenom IS NULL THEN user_profile.UserName ELSE
                         /*concat(UPPER(LEFT(user_profile.nom, 1)), LOWER(SUBSTRING(user_profile.nom, 2, len(user_profile.nom) - 1)), ' ', UPPER(LEFT(user_profile.prenom, 1)),
                         LOWER(SUBSTRING(user_profile.prenom, 2, len(user_profile.prenom) - 1))) */
                         concat(user_profile.prenom,' ',user_profile.nom)
                         END AS
                         nom_prenom,
                          /*{ fn CONCAT(UPPER(LEFT(user_profile.nom, 1)), LOWER(SUBSTRING(user_profile.nom, 2, LEN(user_profile.nom) - 1))) } AS nom, */ user_profile.nom,
                         /*{ fn CONCAT(UPPER(LEFT(user_profile.prenom, 1)), LOWER(SUBSTRING(user_profile.prenom, 2, LEN(user_profile.prenom) - 1))) } AS prenom, */user_profile.prenom,
                         isnull(user_profile.sexe,'- - -') as sexe, user_profile.cin, user_profile.nom_ar, user_profile.prenom_ar,
                         case when user_profile.sexe like 'ma' then 'Homme' when user_profile.sexe like 'fa' then 'Femme' else '- - -' end as sexe_afficher,
                         ISNULL(user_profile.id_emp_fonction, -1) AS id_emp_fonction, user_profile.fonction, convert(varchar,user_profile.date_prise_service,23) AS date_prise_service, user_profile.matricule, format(user_profile.date_naissance,
                         'dd/MM/yyyy') AS date_naissance, user_profile.flotte, user_profile.cnss, user_profile.rib, emp_type_contrat.type_contrat, user_profile.tel, user_profile.email, ISNULL(REPLACE(user_profile.photo, '\', ''), 'inconnu.jpg') AS photo,
                         user_profile.adresse, emp_situation_familiale.situation_familiale, format(user_profile.date_mariage, 'dd/MM/yyyy') AS date_mariage, user_profile.nom_conjoint, user_profile.prenom_conjoint,
                         format(user_profile.date_naissance_conjoint, 'dd/MM/yyyy') AS date_naissance_conjoint, emp_categorie.categorie, user_profile.id_user_profile_sup, ISNULL(user_profile.id_emp_situation_familiale, 1)
                         AS id_emp_situation_familiale, user_profile.UserName, CASE WHEN aspnet_Users.UserId = user_profile.user_loger THEN 'Oui' ELSE 'Non' END AS validé, emp_fonction.nom_fonction, user_profile.tel_conjoint, user_profile.tel_pro,
                         emp_entite.titre AS titre
FROM            user_profile LEFT OUTER JOIN
                         emp_fonction ON user_profile.id_emp_fonction = emp_fonction.id_emp_fonction LEFT OUTER JOIN
                         emp_type_contrat ON user_profile.id_emp_type_contrat = emp_type_contrat.id_emp_type_contrat LEFT OUTER JOIN
                         aspnet_Users ON user_profile.user_loger = aspnet_Users.UserId LEFT OUTER JOIN
                         emp_situation_familiale ON user_profile.id_emp_situation_familiale = emp_situation_familiale.id_emp_situation_familiale LEFT OUTER JOIN
                         emp_entite ON emp_fonction.id_emp_entite = emp_entite.id_emp_entite LEFT OUTER JOIN
                         emp_categorie ON user_profile.id_emp_categorie = emp_categorie.id_emp_categorie
WHERE        (user_profile.user_loger = aspnet_Users.UserId) 
AND ([user_loger] = @user_loger)" 
            DeleteCommand="DELETE FROM [user_profile] WHERE [id_user_profile] = @id_user_profile" 
            InsertCommand="INSERT INTO [user_profile] ([nom], [prenom], [sexe], [cin], [nom_ar], [prenom_ar], [fonction], [date_prise_service], [matricule], [date_naissance], [flotte], [cnss], [rib], [tel], [photo], [adresse], [id_emp_situation_familiale], [date_mariage], [nom_conjoint], [prenom_conjoint], [date_naissance_conjoint], [updated_at], [email], [id_emp_fonction]) VALUES (@nom, @prenom, @sexe, @cin, @nom_ar, @prenom_ar, @fonction, @date_prise_service, @matricule, @date_naissance, @flotte, @cnss, @rib, @tel, @photo, @adresse, @id_emp_situation_familiale, @date_mariage, @nom_conjoint, @prenom_conjoint, @date_naissance_conjoint, @updated_at, @email, @id_emp_fonction)" 
            UpdateCommand="UPDATE [user_profile] SET 
            [nom] = @nom, 
            [prenom] = @prenom, 
            [sexe] = @sexe, 
            [cin] = @cin, 
            [nom_ar] = @nom_ar, 
            [prenom_ar] = @prenom_ar, 
            [fonction] = @fonction, 
            [date_prise_service] = @date_prise_service, 
            [date_naissance] = @date_naissance, 
            [flotte] = @flotte, 
            [cnss] = @cnss, 
            [rib] = @rib, 
            [tel] = @tel, 
            [tel_pro] = @tel_pro, 
            [photo] = @photo, 
            [adresse] = @adresse, 
            [id_emp_situation_familiale] = @id_emp_situation_familiale, 
            [nom_conjoint] = @nom_conjoint, 
            [prenom_conjoint] = @prenom_conjoint, 
            [tel_conjoint] = @tel_conjoint, 
            [updated_at] = getdate(), 
            [email] = @email,
            id_emp_fonction=@id_emp_fonction
            WHERE [id_user_profile] = @id_user_profile">
            <DeleteParameters>
                <asp:Parameter Name="id_user_profile" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nom" Type="String" />
                <asp:Parameter Name="prenom" Type="String" />
                <asp:Parameter Name="sexe" Type="String" />
                <asp:Parameter Name="cin" Type="String" />
                <asp:Parameter Name="nom_ar" Type="String" />
                <asp:Parameter Name="prenom_ar" Type="String" />
                <asp:Parameter Name="fonction" Type="String" />
                <asp:Parameter Name="date_prise_service" Type="DateTime" />
                <asp:Parameter Name="matricule" Type="String" />
                <asp:Parameter Name="date_naissance" Type="DateTime" />
                <asp:Parameter Name="flotte" Type="String" />
                <asp:Parameter Name="cnss" Type="String" />
                <asp:Parameter Name="rib" Type="String" />
                <asp:Parameter Name="tel" Type="String" />
                <asp:Parameter Name="photo" Type="String" />
                <asp:Parameter Name="adresse" Type="String" />
                <asp:Parameter Name="id_emp_situation_familiale" Type="Int32" />
                <asp:Parameter Name="date_mariage" Type="DateTime" />
                <asp:Parameter Name="nom_conjoint" Type="String" />
                <asp:Parameter Name="prenom_conjoint" Type="String" />
                <asp:Parameter Name="date_naissance_conjoint" Type="DateTime" />
                <asp:Parameter Name="updated_at" Type="DateTime" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="id_emp_fonction" Type="Int32" />
            </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="my_currentuser" Name="user_loger" 
                PropertyName="Value" />
        </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="nom" Type="String" />
                <asp:Parameter Name="prenom" Type="String" />
                <asp:Parameter Name="sexe" Type="String" />
                <asp:Parameter Name="cin" Type="String" />
                <asp:Parameter Name="nom_ar" Type="String" />
                <asp:Parameter Name="prenom_ar" Type="String" />
                <asp:Parameter Name="fonction" Type="String" />
                <asp:Parameter Name="date_prise_service" Type="DateTime" />
                <asp:Parameter Name="date_naissance" Type="DateTime" />
                <asp:Parameter Name="flotte" Type="String" />
                <asp:Parameter Name="cnss" Type="String" />
                <asp:Parameter Name="rib" Type="String" />
                <asp:Parameter Name="tel" Type="String" />
                <asp:Parameter Name="tel_pro" Type="String" />
                <asp:Parameter Name="photo" Type="String" />
                <asp:Parameter Name="adresse" Type="String" />
                <asp:Parameter Name="id_emp_situation_familiale" Type="Int32" />
                <asp:Parameter Name="nom_conjoint" Type="String" />
                <asp:Parameter Name="prenom_conjoint" Type="String" />
                <asp:Parameter Name="tel_conjoint" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="id_emp_fonction" Type="Int32" />
                <asp:Parameter Name="id_user_profile" Type="Int32" />
            </UpdateParameters>
    </asp:SqlDataSource>

                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Width="100%" 
            DataKeyNames="id_user_profile">
            <EditItemTemplate>
                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                        <%--<h4 class="h4 text-primary">Infromation I</h4>--%>
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label>ID</label>
                                    <asp:TextBox ID="id_user_profileTextBox1" ReadOnly="true" runat="server" 
                                        Text='<%# Eval("id_user_profile") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Nom</label>
                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("nom") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Prenom</label>
                                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("prenom") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Nom (en Arabe)</label>
                                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("nom_ar") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Prénom (en Arabe)</label>
                                    <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("prenom_ar") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Sexe</label>
                                    <asp:DropDownList ID="DropDownList3" CssClass="form-control" SelectedValue='<%# Bind("sexe") %>' runat="server">
                                        <asp:ListItem Value="ma">Homme</asp:ListItem>
                                        <asp:ListItem Value="fa">Femme</asp:ListItem>
                                        <asp:ListItem Value="- - -">- - -</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>CIN</label>
                                    <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("cin") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Numéro Téléphone Personnel</label>
                                    <asp:TextBox ID="telTextBox" runat="server" Text='<%# Bind("tel") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Numéro Téléphone FMPS</label>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("tel_pro") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Flotte</label>
                                    <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("flotte") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>CNSS</label>
                                    <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("cnss") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>RIB</label>
                                    <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("rib") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>E-Mail</label>
                                    <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Adresse</label>
                                    <asp:TextBox ID="adresseTextBox" runat="server" Text='<%# Bind("adresse") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Photo : Choisissez un fichier</label>
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <asp:FileUpload ID="FileUpload1" runat="server" />
                                            <asp:RegularExpressionValidator ID="rexp" runat="server" ControlToValidate="FileUpload1" ErrorMessage="Only .gif, .jpg, .png, .tiff .doc .docx .pdf " ValidationExpression="(.*\.([Dd][Oo][Cc])|.*\.([Dd][Oo][Cc][Xx])|.*\.([Pp][Dd][Ff])|.*\.([Gg][Ii][Ff])|.*\.([Jj][Pp][Gg])|.*\.([Bb][Mm][Pp])|.*\.([pP][nN][gG])|.*\.([tT][iI][iI][fF])$)"></asp:RegularExpressionValidator>
                                            <asp:Button ID="btnUpload" class="abutton btn btn-sm btn-dark disabled" Enabled="false" runat="server" style="float:right" Text="Cliquez ici d'abord" /><br />         
                                            <asp:Label ID="Label_upload" runat="server" Visible="false" ForeColor="Green" Text="Téléchargement avec succès."></asp:Label>
                                            <asp:Image ID="imgShow" Visible="false" runat="server" Width="150px" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="btnUpload" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:TextBox ID="TextBox_upload" runat="server" Visible="false" Text='<%# Bind("photo") %>' CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Date de prise en service</label>
                                    <asp:TextBox ID="TextBox2" Type="date" runat="server" CssClass="form-control"
                                        Text='<%# Bind("date_prise_service") %>' />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Fonction</label>
                                    <asp:DropDownList ID="DropDownList2" DataSourceID="SqlDataSource_Fonction" DataTextField="nom_fonction" 
                                        DataValueField="id_emp_fonction" CssClass="form-control" runat="server" SelectedValue='<%# Bind("id_emp_fonction") %>'>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Situation familiale</label>
                                    <asp:DropDownList ID="DropDownList1" DataSourceID="SqlDataSource_Situation_Familiale" DataTextField="situation_familiale" 
                                        DataValueField="id_emp_situation_familiale" SelectedValue='<%# Bind("id_emp_situation_familiale") %>' CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Nom de conjoint(e)</label>
                                    <asp:TextBox ID="nom_conjointTextBox" runat="server" CssClass="form-control"
                                        Text='<%# Bind("nom_conjoint") %>' />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Prénom de conjoint(e)</label>
                                    <asp:TextBox ID="prenom_conjointTextBox" runat="server" CssClass="form-control"
                                        Text='<%# Bind("prenom_conjoint") %>' />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label>Téléphone de conjoint(e)</label>
                                    <asp:TextBox ID="date_naissance_conjointTextBox" runat="server" CssClass="form-control"
                                        Text='<%# Bind("tel_conjoint") %>' />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CssClass="btn btn-sm btn-primary"
                    CommandName="Update" Text="Enregistrer" />
                <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="True" CssClass="btn btn-sm btn-dark"
                    CommandName="Cancel" Text="Annuler" />
            </EditItemTemplate>
            <ItemTemplate>
     <section class=" col-lg-12">
                <div class="row  d-flex mb-3 justify-content-evenly align-items-stretch">
                    <div class="col-lg-4 border border-info col-sm-12 shadow-sm rounded-3 m-1 card">
                     <div class="card-header bg-white">
                            <h6 class="p-2 m-1 text-center font-weight-bolder">Profile</h6>
                    </div>
                        <div class="card-body text-center">
                    <img  id="photo_src2" class="afficher_data" data-nom='<%# Eval("nom_prenom")%>' src='../img/inconnu.jpg' style="cursor:pointer" width="150px" height="150px" />
                            <h5 class="my-3"><%# Eval("nom_prenom")%></h5>
                            <p class="text-muted"><%# Eval("nom_fonction")%></p>
                            <p class="text-muted"><%# Eval("titre") %></p>
                       <div class="d-flex w-100 justify-content-center">
                     <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CssClass="btn p-2 align-center btn-sm btn-success col-lg-4" 
                    CommandName="Edit" Text="Modifier" />
                        </div>
                        </div>
                    </div>
                    <div class="col-lg-7 border border-info  col-sm-12 shadow-sm m-1 rounded-3 card mb-4 mb-lg-0">
                        <div class="card-header bg-white">
                            <h6 class="p-2 m-1 text-center font-weight-bolder">Contact</h6>
                        </div>
                        <div class="card-body p-0">
                            <ul class="list-group list-group-flush rounded-3">
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <p class="mb-0"><span class="font-weight-bolder">Email : </span><%# Eval("email")%></p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <p class="mb-0"><span class="font-weight-bolder">Tel personnelle : </span><%# Eval("tel")%></p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <p class="mb-0"><span class="font-weight-bolder">Tel professionnel : </span><%# Eval("tel_pro")%></p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <p class="mb-0"><span class="font-weight-bolder">Flotte : </span><%# Eval("flotte")%></p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <p class="mb-0"><span class="font-weight-bolder">Adresse : </span><%# Eval("adresse")%></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row  d-flex mt-3 justify-content-evenly align-items-stretch ">
                    <div class="col-lg-7 border border-info col-sm-12 shadow-sm rounded-3 m-1 card">
                        <div class="card-header bg-white">
                            <h6 class="p-2 m-1 text-center font-weight-bolder">Informations personnelle</h6>
                        </div>
                        <div class="card-body">
                            <div class="row d-flex justify-content-end">
                                    <p class="mb-0 text-right" style="direction:rtl !important;"> الإسم :  <%# Eval("prenom_ar") %></p>
                            </div>
                            <hr>
                            <div class="row d-flex justify-content-end">
                                    <p class="mb-0 text-right" style="direction:rtl !important;"> النسب :  <%# Eval("nom_ar") %></p>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Date naissance : </p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0"><%# Eval("date_naissance") %></p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">CIN : </p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0"><%# Eval("CIN") %></p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Situation familiale : </p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0"><%# Eval("situation_familiale") %></p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Sexe : </p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0"><%# Eval("sexe") %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card border border-info col-sm-12 shadow-sm rounded-3 col-lg-4 m-1">
                                    <div class="card-header bg-white">
                                        <h6 class="p-2 m-1 text-center font-weight-bolder">informations professionnelle</h6>
                                    </div>
                                <div class="card-body">

                                    <p class="mb-1" style="font-size: .77rem;">Date prise service : </p>
                                    <div >
                                        <p><%# Eval("date_prise_service") %></p>
                                    </div>
                                    <p class="mt-4 mb-1" style="font-size: .77rem;">CNSS :</p>
                                    <div >
                                        <p><%# Eval("cnss") %></p>
                                    </div>
                                    <p class="mt-4 mb-1" style="font-size: .77rem;">RIB :</p>
                                    <div >
                                        <p><%# Eval("rib") %></p>
                                    </div>
                                    <p class="mt-4 mb-1" style="font-size: .77rem;">Type contrat : </p>
                                    <div >
                                        <p><%# Eval("type_contrat") %></p>
                                    </div>
                                    <p class="mt-4 mb-1" style="font-size: .77rem;">Département : </p>
                                    <div >
                                        <p><%# Eval("dept") %></p>
                                    </div>
                                </div>
                            </div>
                </div>

    </section>

            </ItemTemplate>
        </asp:FormView>


        </div>
</asp:Content>