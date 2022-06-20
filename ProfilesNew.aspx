<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ProfilesNew.aspx.vb" Inherits="emp_Profiles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        #image_src
        {
            width:100%;
            text-align:center;
        }
        #photo_src2 
        {
            border-radius: 100px;
            margin-top:-40px;
        }
        .bg_card 
        {
            background-image: url("bgcard.jpg");
            background-size: cover;
            background-repeat:no-repeat;
            border-radius:6px;
            box-shadow: 0px 5px 20px rgba(0,0,0, .5);
            color:#000;
        }
        .single_advisor_profile {
            position: relative;
            margin-bottom: 50px;
            -webkit-transition-duration: 500ms;
            transition-duration: 500ms;
            z-index: 1;
            border-radius: 15px;
            -webkit-box-shadow: 0 0.25rem 1rem 0 rgba(47, 91, 234, 0.125);
            box-shadow: 0 0.25rem 1rem 0 rgba(47, 91, 234, 0.125);
        }
        
        .single_advisor_profile .advisor_thumb {
            position: relative;
            z-index: 1;
            border-radius: 15px 15px 0 0;
            margin: 0 auto;
            padding: 30px 30px 0 30px;
            overflow: hidden;
        }
        
        .single_advisor_profile .advisor_thumb::after {
            -webkit-transition-duration: 500ms;
            transition-duration: 500ms;
            position: absolute;
            width: 150%;
            height: 80px;
            bottom: -45px;
            left: -25%;
            content: "";
            background-color: #ffffff;
            -webkit-transform: rotate(-15deg);
            transform: rotate(-15deg);
        }
        
        @media only screen and (max-width: 575px) {
            .single_advisor_profile .advisor_thumb::after {
                height: 160px;
                bottom: -90px;
            }
           #accordionSidebar {
                display:none;
            }
        }
        
        .single_advisor_profile .advisor_thumb .social-info {
            position: absolute;
            z-index: 1;
            width: 100%;
            bottom: 0;
            right: 30px;
            text-align: right;
        }
        
        .single_advisor_profile .advisor_thumb .social-info a {
            font-size: 14px;
            color: #020710;
            padding: 0 5px;
        }
        
        .single_advisor_profile .advisor_thumb .social-info a:hover,
        .single_advisor_profile .advisor_thumb .social-info a:focus {
            color: #3f43fd;
        }
        
        .single_advisor_profile .advisor_thumb .social-info a:last-child {
            padding-right: 0;
        }
        
        .single_advisor_profile .single_advisor_details_info {
            position: relative;
            z-index: 1;
            padding: 30px;
            text-align: right;
            -webkit-transition-duration: 500ms;
            transition-duration: 500ms;
            border-radius: 0 0 15px 15px;
            background-color: #ffffff;
        }
        
        .single_advisor_profile .single_advisor_details_info::after {
            -webkit-transition-duration: 500ms;
            transition-duration: 500ms;
            position: absolute;
            z-index: 1;
            width: 50px;
            height: 3px;
            content: "";
            top: 12px;
            right: 30px;
        }
        
        .rp {
            background-color: #3f43fd !important;
        }
        
        .cms {
            background-color: #0ec97b !important;
        }
        
        .single_advisor_profile .single_advisor_details_info h6 {
            margin-bottom: 0.25rem;
            -webkit-transition-duration: 500ms;
            transition-duration: 500ms;
        }
        
        @media only screen and (min-width: 768px) and (max-width: 991px) {
            .single_advisor_profile .single_advisor_details_info h6 {
                font-size: 14px;
            }
        }
        
        .single_advisor_profile .single_advisor_details_info p {
            -webkit-transition-duration: 500ms;
            transition-duration: 500ms;
            margin-bottom: 0;
            font-size: 14px;
        }
        
        @media only screen and (min-width: 768px) and (max-width: 991px) {
            .single_advisor_profile .single_advisor_details_info p {
                font-size: 12px;
            }
        }
        
        .single_advisor_profile:hover .advisor_thumb::after,
        .single_advisor_profile:focus .advisor_thumb::after {
            background-color: #070a57;
        }
        
        .single_advisor_profile:hover .advisor_thumb .social-info a,
        .single_advisor_profile:focus .advisor_thumb .social-info a {
            color: #ffffff;
        }
        
        .single_advisor_profile:hover .advisor_thumb .social-info a:hover,
        .single_advisor_profile:hover .advisor_thumb .social-info a:focus,
        .single_advisor_profile:focus .advisor_thumb .social-info a:hover,
        .single_advisor_profile:focus .advisor_thumb .social-info a:focus {
            color: #ffffff;
        }
        
        .single_advisor_profile:hover .single_advisor_details_info,
        .single_advisor_profile:focus .single_advisor_details_info {
            background-color: #070a57;
        }
        
        .single_advisor_profile:hover .single_advisor_details_info::after,
        .single_advisor_profile:focus .single_advisor_details_info::after {
            background-color: #ffffff;
        }
        
        .single_advisor_profile:hover .single_advisor_details_info h6,
        .single_advisor_profile:focus .single_advisor_details_info h6,
        .single_advisor_profile:hover .single_advisor_details_info h5,
        .single_advisor_profile:focus .single_advisor_details_info h5 {
            color: #ffffff;
        }
        
        .single_advisor_profile:hover .single_advisor_details_info p,
        .single_advisor_profile:focus .single_advisor_details_info p {
            color: #ffffff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            
        SelectCommand="SELECT    distinct user_profile.id_user_profile, user_profile.user_loger,
CASE WHEN user_profile.nom is null or user_profile.prenom is null THEN 
		user_profile.UserName
	ELSE 
		concat(UPPER(LEFT(user_profile.nom,1)) , LOWER(SUBSTRING(user_profile.nom,2,len(user_profile.nom)-1)),' ',UPPER(LEFT(user_profile.prenom,1)) , LOWER(SUBSTRING(user_profile.prenom,2,len(user_profile.prenom)-1)))
	END
AS nom_prenom,
CASE WHEN user_profile.sexe LIKE 'fa' THEN 'Femme' WHEN user_profile.sexe LIKE 'ma' THEN 'Homme' ELSE 'en cours...' END AS sexe, 
isnull(user_profile.cin,'en cours...') AS cin,
isnull(user_profile.nom_ar,'en cours...') AS nom_ar, 
isnull(user_profile.prenom_ar,'en cours...') AS prenom_ar, 
isnull(user_profile.fonction,'en cours...') AS fonction, 
isnull(format(user_profile.date_prise_service,'dd - MM - yyyy'),'en cours...') AS date_prise_service, 
isnull(user_profile.matricule,'en cours...') AS matricule, 
isnull(format(user_profile.date_naissance,'dd - MM - yyyy'),'en cours...') AS date_naissance, 
isnull(user_profile.flotte,'en cours...') AS flotte, 
isnull(user_profile.cnss,'en cours...') AS cnss, 
isnull(user_profile.rib,'en cours...') AS rib, 
isnull(emp_type_contrat.type_contrat,'en cours...') AS type_contrat, 
isnull(user_profile.tel,'en cours...') AS tel, 
isnull(user_profile.email,'en cours...') AS email, 
isnull(replace(user_profile.photo,'\',''),'inconnu.jpg') AS photo,
isnull(user_profile.adresse,'en cours...') AS adresse, 
isnull(emp_situation_familiale.situation_familiale,'en cours...') AS situation_familiale, 
isnull(format(user_profile.date_mariage,'dd - MM - yyyy'),'- - -') AS date_mariage, 
isnull(user_profile.nom_conjoint,'en cours...') AS nom_conjoint, 
isnull(user_profile.prenom_conjoint,'en cours...') AS prenom_conjoint, 
isnull(format(user_profile.date_naissance_conjoint,'dd - MM - yyyy'),'en cours...') AS date_naissance_conjoint, 
isnull(emp_categorie.categorie,'en cours...') AS categorie, 
user_profile.id_user_profile_sup, 
isnull(user_profile.UserName,'en cours...') AS UserName,
CASE WHEN aspnet_Users.UserId = user_profile.user_loger THEN 'Oui' ELSE 'Non' END AS validé,
isnull(emp_entite.titre,'en cours...') AS titre,
isnull(emp_fonction.nom_fonction,'en cours...') AS nom_fonction
FROM         emp_fonction RIGHT OUTER JOIN
                      user_profile ON emp_fonction.id_emp_fonction = user_profile.id_emp_fonction RIGHT OUTER JOIN
                      dev_user_project RIGHT OUTER JOIN
                      dev_projet_province_cpdh RIGHT OUTER JOIN
                      dev_user_province LEFT OUTER JOIN
                      dev_province ON dev_user_province.id_dev_province = dev_province.id_dev_province ON dev_projet_province_cpdh.id_dev_province = dev_province.id_dev_province RIGHT OUTER JOIN
                      aspnet_Users ON dev_user_province.UserId = aspnet_Users.UserId ON dev_user_project.UserId = aspnet_Users.UserId ON user_profile.user_loger = aspnet_Users.UserId LEFT OUTER JOIN
                      emp_type_contrat ON user_profile.id_emp_type_contrat = emp_type_contrat.id_emp_type_contrat LEFT OUTER JOIN
                      emp_categorie ON user_profile.id_emp_categorie = emp_categorie.id_emp_categorie LEFT OUTER JOIN
                      emp_entite ON emp_fonction.id_emp_entite = emp_entite.id_emp_entite LEFT OUTER JOIN
                      emp_situation_familiale ON user_profile.id_emp_situation_familiale = emp_situation_familiale.id_emp_situation_familiale
WHERE user_profile.user_loger = aspnet_Users.UserId
AND (dev_projet_province_cpdh.id_dev_projet = @id_dev_projet)
AND (dev_province.id_dev_province = case when @id_province =-1 then dev_province.id_dev_province else @id_province   end ) 
AND (emp_entite.id_emp_entite = case when @id_emp_entite =-1  then emp_entite.id_emp_entite else @id_emp_entite   end)
">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Province" PropertyName="SelectedValue" Name="id_province" />
                            <asp:ControlParameter ControlID="DropDownList_Entite" PropertyName="SelectedValue" Name="id_emp_entite" />
                            <asp:SessionParameter Name="id_dev_projet" SessionField="CurrentProject" />
                        </SelectParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Province" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                SelectCommand="select id_province , province from user_province(@id_user)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" Name="id_user" 
                        PropertyName="Value" Type="String" DbType="Object" />
                </SelectParameters>
     </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_entite" runat="server" ConnectionString='<%$ ConnectionStrings:ApplicationServices %>' SelectCommand="select 1 as tri ,-1 as id_emp_entite ,'Tous' as titre union select 1 as tri,id_emp_entite, titre from emp_entite order by tri 
"></asp:SqlDataSource>
         <div class="d-flex flex-column align-content-center">
            <div class="row">
                <div class="col-xl-12">
                    <div class="d-flex row justify-content-center form-group">
                        <div class="m-2 p-2">
                            <label>Entite : </label>
                            <asp:DropDownList ID="DropDownList_Entite" AutoPostBack="true" CssClass="form-control" DataSourceID="SqlDataSource_entite" DataTextField="titre" DataValueField="id_emp_entite" runat="server"></asp:DropDownList>
                        </div>
                        <div class="m-2 p-2">
                            <label>Province : </label>
                            <asp:DropDownList ID="DropDownList_Province" AutoPostBack="true" CssClass="form-control" DataSourceID="SqlDataSource_Province" DataTextField="province" DataValueField="id_province" runat="server">
                         </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row d-flex form-group mb-3 justify-content-center">
                <input class="form-control w-25 m-1" placeholder="Chercher ..." type="text" id="search_txt" />
            </div>
         </div>
     <asp:ListView ID="ListView_profile" DataSourceID="SqlDataSource1" runat="server">
                                
                             <ItemTemplate>
                                   <div class="col-12 col-sm-6 col-lg-3 profile">
                                    <div class="single_advisor_profile wow fadeInUp" data-wow-delay="0.2s" style="visibility: visible; animation-delay: 0.2s; animation-name: fadeInUp;">
                                        <!-- Team Thumb-->
                                        <div class="advisor_thumb cms">
                                            <img class="rounded-circle d-none" data-nom='<%# Eval("nom_prenom")%>' src='../uploids/photos_profiles/<%# Eval("photo") %>' width="300" height="300" alt="">
                                            <img class="rounded-circle d" data-nom='<%# Eval("nom_prenom")%>' src='../img/inconnu.jpg' width="300" height="300" alt="">
                                            <!-- Social Info-->
                                            <div class="social-info">
                                                <a class="flotte" flotte="<%# Eval("flotte") %>" href="#"><i class="fa fa-phone" aria-hidden="true"></i></a>
                                                <a class="email" email="<%# Eval("email") %>" href="#"><i class="fa fa-envelope" aria-hidden="true"></i></a>
                                                <a class="afficher_data" data-id="<%# Eval("id_user_profile") %>" data-toggle="modal" data-target="#modal_afficher" href="ProfilModal.aspx?u=<%# Eval("id_user_profile") %>"><i class="fa fa-arrow-right" aria-hidden="true"></i></a>
                                            </div>
                                        </div>
                                        <!-- Team Details-->
                                        <div class="single_advisor_details_info">
                                            <h5 class="fullname"><%# Eval("nom_prenom")%></h5>
                                            <p class=" font-weight-bold"><%# Eval("fonction") %></p>
                                            <p class="font-italic"><%# Eval("titre") %></p>
                                        </div>
                                    </div>
                                </div> 
                            </ItemTemplate>
                            <LayoutTemplate>
                                <div class="container">
                                <div class="row flex-wrap allprofiles d-flex">
                                <div id="ItemPlaceholder" runat="server">

                                </div>
                                    </div>
                                </div>
                             <asp:DataPager ID="DataPager1" runat="server">
                                <Fields>
                                    <asp:NextPreviousPagerField 
                                        ButtonType="Button" 
                                        ShowFirstPageButton="true"
                                        ShowPreviousPageButton="false"
                                        ShowNextPageButton="true"
                                        ButtonCssClass="btn btn-primary"
                                        NextPageText="Précedent"
                                         FirstPageText="Première"
                                        />
                                    <asp:NumericPagerField 
                                        NumericButtonCssClass="NumericButtonSCSS"
                                        NextPreviousButtonCssClass="NextPreviousButtonCSS"
                                        />
                                    <asp:NextPreviousPagerField 
                                        ButtonType="Button"
                                        ShowNextPageButton="false"
                                        ShowLastPageButton="true"
                                        ButtonCssClass="btn btn-primary"
                                        PreviousPageText="Suivant"
                                        LastPageText="Dernière"
                                        />
                                </Fields>
                            </asp:DataPager>

                            </LayoutTemplate>
                        </asp:ListView>
                    


    <div class="modal fade" id="modal_afficher" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-xl"  style="min-height: 100%; min-width:100%" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <div class="w-100 h-100 d-flex justify-content-center">
                        <iframe id="Iframe_Afficher" style="width:100%;border:none;height:100%" src="" class="embed-responsive-item" allowfullscreen></iframe>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('.email').click(function () {
                Swal.fire(
                    {
                        width: '25em',
                        text: $(this).attr('email')
                    }
                );
            });
            $('.flotte').click(function () {
                Swal.fire(
                    {
                        width: '25em',
                        text: $(this).attr('flotte')
                    }
                );
            });

            $('#search_txt').change(function () {
                $('.profile').show();
                var filter = $(this).val();
                $('.allprofiles').find(".fullname:not(:contains(" + filter + "))").parent().parent().parent().css('display', 'none');
            });
            $(document).on('click', '.afficher_data', function () {
                var id = $(this).data('id');
                console.log(id);
                $('#Iframe_Afficher').attr('src', "ProfilModal.aspx?u=" + id);
                $('#modal_afficher').modal('show');
            });
        });
    </script>
</asp:Content>