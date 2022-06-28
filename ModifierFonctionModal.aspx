<%@ Page Title="" Language="VB" MasterPageFile="~/MasterModalPage.master" AutoEventWireup="false" CodeFile="ModifierFonctionModal.aspx.vb" Inherits="entite_fontions_ModifierFonctionModal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

        <asp:HiddenField ID="HiddenField_user" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="HiddenField_id_fonc" ClientIDMode="Static" runat="server" />
    <asp:panel CssClass="d-none" ID="error_panel" runat="server" class="alert alert-danger">
        <asp:Label ID="error_lbl" CssClass="text-danger" runat="server" >
        </asp:Label>
    </asp:panel>

    <asp:Panel runat="Server" ID="success_panel" CssClass="d-none p-2 m-2">
        <div class="alert alert-success" role="alert">
            <p>
            Opération avec success
            </p>
        </div>
    </asp:Panel>

        <div class="row d-flex justify-content-center">
            <div class="col-xl-7 col-lg-8 col-md-9 col-11 text-center">
                <h3>Gestion des entites</h3>
                <p class="blue-text">Catégorisation les differents divisions et services en FMPS</p>
                <div class="card p-lg-5 p-3">
                    <h5 class="text-center m-3 mb-4">Modifier fonction </h5>
                        
                        <div class="row justify-content-between text-left">
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label px-3">nom de fonction : <span class="text-danger"> *</span>
                                </label> 
                                <asp:TextBox ID="txt_titreFr" runat="server" cssClass="form-control" placeholder="Entre le nom de entite (FR)" > </asp:TextBox>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label text-right px-3" dir="rtl">الإسم المهنة : <span class="text-danger"> *</span></label> 
                                <asp:TextBox runat="server" ID="txt_titreAr" cssClass="form-control" placeholder="الإسم بالعربية" dir="rtl" > </asp:TextBox>
                            
                            </div>
                        </div>
                        <div class="row justify-content-between text-left">
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label px-3">Entite : <span class="text-danger"> *</span></label> 
                                <asp:DropDownList CssClass="form-control" runat="server" ID="ent_sup_dropDown">

                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex"> 
                                <label class="form-control-label px-3">Fonction Supérieur : <span class="text-danger"> *</span></label> 
                                <asp:DropDownList runat="server" CssClass="form-control" ID="foncs_dropDown">

                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row justify-content-between align-items-center p-0 text-left">
                            <div class="form-group col-sm-6 d-flex flex-column align-items-end m-0 col-lg-6"> 
                                <label></label>
                                <asp:Button runat="server" ID="Modifier_btn" OnClick="Modifier_btn_Click" CssClass ="btn btn-success w-100" Text="Modifier" /> 
                            </div>
                        </div> 
                    <div class="">
                        <asp:ValidationSummary CssClass="alert alert-danger" DisplayMode="BulletList" ID="ValidationSummary1" runat="server" />
                    </div>
                        <asp:RequiredFieldValidator CssClass="d-none" ID="RequiredFieldValidator_titreAr" ControlToValidate="txt_titreAr" runat="server" Text="*" EnableClientScript="true"  ErrorMessage="champ titre en arabe requis"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator CssClass="d-none" ID="RequiredFieldValidator_titre" ForeColor="Red" ControlToValidate="txt_titreFr" runat="server" EnableClientScript="true"  Text="*" ErrorMessage="champ titre requis"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>


</asp:Content>

