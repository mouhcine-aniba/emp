<%@ Page Title="" Language="VB" MasterPageFile="~/MasterModalPage.master" AutoEventWireup="false" CodeFile="ProfilModal.aspx.vb" Inherits="emp_ProfilModal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .form_view {
            height:fit-content;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource_Situation_Familiale" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="SELECT [id_emp_situation_familiale], [situation_familiale] FROM [emp_situation_familiale]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Fonction" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="select -1 as id_emp_fonction ,'---' as nom_fonction UNION SELECT [id_emp_fonction], [nom_fonction] FROM [emp_fonction]"></asp:SqlDataSource>
  
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
WHERE        ([id_user_profile] = @id_user_profile)" >

        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="u" DbType="Int32" DefaultValue="-1" Name="id_user_profile" />
        </SelectParameters>

    </asp:SqlDataSource>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" CssClass="w-100 form_view" 
            DataKeyNames="id_user_profile">
            <ItemTemplate>
     <section class="container p-5 col-lg-12">
                <div class="row d-flex mb-3 justify-content-evenly align-items-stretch">
                    <div class="col-lg-4 border border-info col-sm-12 shadow-sm rounded-3 m-1 card">
                     <div class="card-header bg-white">
                            <h6 class="p-2 m-1 text-center font-weight-bolder">Profile</h6>
                    </div>
                        <div class="card-body text-center">
                    <img  id="photo_src2" class="afficher_data" data-nom='<%# Eval("nom_prenom")%>' src='../img/inconnu.jpg' style="cursor:pointer" width="150px" height="150px" />
                            <h5 class="my-3"><%# Eval("nom_prenom")%></h5>
                            <p class="text-muted mb-1"><%# Eval("nom_fonction")%></p>
                            <p class="text-muted mb-4"><%# Eval("titre") %></p>
                        </div>
                    </div>
                    <div class="col-lg-7 col-sm-12 border border-info shadow-sm m-1 rounded-3 card mb-4 mb-lg-0">
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
                <div class="row d-flex mt-3 justify-content-evenly align-items-stretch ">
                    <div class="col-lg-7 col-sm-12 border border-info shadow-sm rounded-3 m-1 card">
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
                    <div class="card col-sm-12 border border-info shadow-sm rounded-3 col-lg-4 m-1">
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
</asp:Content>

