<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QR_Lector.aspx.cs" Inherits="LectorCodigoQR.QR_Lector" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <div align="center">
        <asp:Label ID="lblTitulo" Text="Lector de Códigos QR Online" Font-Size="23" runat="server" /><br />
    </div>

    <div class="col-lg-1">
        <asp:Label ID="lblOpcion" Text="¿Qué deseas realizar?" runat="server" />
    </div>

    <div class="col-md-4">

        <asp:LinkButton ID="lkLeerCodigo" class="btn btn-primary btn-lg" OnClick="lkLeerCodigo_Click" runat="server"><i class="fa fa-file-image-o"></i>&nbsp;Leer Código QR</asp:LinkButton>
        <asp:LinkButton ID="lkGenerarCodigo" class="btn btn-primary btn-lg" OnClick="lkGenerarCodigo_Click" runat="server"><i class="fa fa-qrcode"></i>&nbsp;Generar Código QR</asp:LinkButton>
        
    </div>

    
    
    <asp:MultiView ID="MVCodigo" runat="server">
        <asp:View ID="VCodigo" runat="server">


            <div class="panel panel-primary">
                <div class="panel-heading">Leer Código QR</div>
            </div>

        </asp:View>


    </asp:MultiView>


</asp:Content>
