<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="gestion_entite.aspx.vb" Inherits="entite_fontions_gestion_entite" %>
<%@ Register Src="~/common/Flash.ascx" TagName="FlashMessage" TagPrefix="fmps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopRegion" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:HiddenField ID="HiddenField_user" ClientIDMode="Static" runat="server" />

       <fmps:FlashMessage ID="FM" runat="server"></fmps:FlashMessage>

    <div class="container-fluid px-1 py-5 mx-auto">
        <div class="row d-flex justify-content-center">
            <div class="col-xl-7 col-lg-8 col-md-9 col-11 text-center">
                <h3>Gestion des entites</h3>
                <p class="blue-text">Catégorisation les differents divisions et services en FMPS</p>
                <div class="card p-lg-5 p-3">
                    <h5 class="text-center m-3 mb-4">Ajouter nouveau entite : </h5>
                        <div class="row justify-content-between text-left">
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label px-3">Titre : <span class="text-danger"> *</span>
                                </label> 
                                <asp:TextBox ID="txt_titreFr" runat="server" cssClass="form-control" placeholder="Entre le nom de entite (FR)" > </asp:TextBox>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label text-right px-3" dir="rtl">الإسم  : <span class="text-danger"> *</span></label> 
                                <asp:TextBox runat="server" ID="txt_titreAr" cssClass="form-control" placeholder="الإسم بالعربية" dir="rtl" > </asp:TextBox>
                            
                            </div>
                        </div>
                        <div class="row justify-content-between text-left">
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label px-3">Entite supérieur : <span class="text-danger"> *</span></label> 
                                <asp:DropDownList CssClass="form-control" runat="server" ID="ent_sup_dropDown">

                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label px-3">Fonction supérieur : <span class="text-danger"> *</span></label> 
                                <asp:DropDownList runat="server" CssClass="form-control" ID="foncs_dropDown">

                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row justify-content-between align-items-center p-0 text-left">
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label px-3">Abréviation : <span class="text-danger"> *</span></label> 
                                <asp:TextBox MaxLength="10" runat="server" ID="txt_abrv" class="form-control" placeholder="abréviation" > </asp:TextBox>
                            </div>
                            <div class="form-group col-sm-6 d-flex flex-column align-items-end m-0 col-lg-6"> 
                                <label></label>
                                <asp:Button runat="server" ID="add_btn" OnClick="add_btn_Click"  cssClass="btn btn-success w-100" Text="Enregister" /> 
                            </div>
                        </div> 
                    <div class="">
                        <asp:ValidationSummary CssClass="alert alert-danger" DisplayMode="BulletList" ID="ValidationSummary1" runat="server" />
                    </div>
                        <asp:RequiredFieldValidator CssClass="d-none" ID="RequiredFieldValidator_abrv" ForeColor="Red" ControlToValidate="txt_abrv" runat="server" Text="*" EnableClientScript="true" ErrorMessage="champ abréviation requis"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator CssClass="d-none" ID="RequiredFieldValidator_titreAr" ControlToValidate="txt_titreAr" runat="server" Text="*" EnableClientScript="true"  ErrorMessage="champ titre en arabe requis"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator CssClass="d-none" ID="RequiredFieldValidator_titre" ForeColor="Red" ControlToValidate="txt_titreFr" runat="server" EnableClientScript="true"  Text="*" ErrorMessage="champ titre requis"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
</div>

    <div id="container" class="p-lg-5">
        <asp:Repeater ID="entite_repeater" runat="server">
                    <HeaderTemplate>
                        <table width="100%" style="font-size:small" class="table table-bordered" id="dataTable">
                            <thead class="thead-light">
                                <tr>
                                    <th data-priority="1">ID entite</th>
                                    <th>titre</th>
                                    <th>tite ar</th>
                                    <th>entite sup</th>
                                    <th>Fonction Lead</th>
                                    <th>ABRV</th>
                                    <th data-priority="1">actions</th>
                                </tr>
                            </thead>
                            <tbody>

                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="Label_id" runat="server" Text='<%# Eval("id_emp_entite")%>'></asp:Label>
                            </td>
                            <td>
                                <%# Eval("titre")%>
                            </td>
                            <td>
                                <%# Eval("titre_ar")%>
                            </td>
                            <td>
                                <%# Eval("entite_sup")%>
                            </td>
                            <td>
                                <%# Eval("fonction_sup")%>
                            </td>
                            <td>
                                <%# Eval("abreviation")%>
                            </td>
                            <td class="d-flex justify-content-center">
                                <asp:LinkButton CausesValidation="false" OnClick="LinkButton_delete_Click" runat="server" ID="LinkButton_delete" class="p-2 show_detail text-danger m-2"><i class="fas fa-times"></i></asp:LinkButton>
                                <a data-id='<%# Eval("id_emp_entite")%>' class="p-2 afficher_data show_detail text-primary m-2"><i class="fas fa-marker"></i></a>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
    </div>


        <div class="modal fade" id="modal_afficher" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-xl"  style="min-height: 100%; min-width:100%" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" id="close_btn" class="close" data-dismiss="modal" aria-label="Close">
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

            $(document).on('click', '.afficher_data', function () {
                var id = $(this).data('id');
                console.log(id);
                $('#Iframe_Afficher').attr('src', "ModifierEntiteModal.aspx?id_entite=" + id);
                $('#modal_afficher').modal('show');
            });
            $("#close_btn").click(function () {
                window.location.reload();
            });
        });
    </script>

</asp:Content>

