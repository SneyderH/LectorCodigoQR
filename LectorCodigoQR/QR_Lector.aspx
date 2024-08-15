<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QR_Lector.aspx.cs" Inherits="LectorCodigoQR.QR_Lector" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link href="Content/styles.css" rel="stylesheet" />

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

    
    <div class="row">
        <asp:MultiView ID="MVCodigo" runat="server">
            <asp:View ID="VLeerCodigo" runat="server">


                <div class="panel panel-primary">
                    <div class="panel-heading">Leer Código QR</div>
                    <div align="center">
                        <div style="margin: 5px;">
                            <div style="margin: 2.5px">

                                <asp:Label ID="lblSeleccion" Text="Selecciona el código QR" runat="server" Font-Size="23" />

                                <div class="picture">
                                    <h1 class="upload-icon">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                    </h1>

                                    <asp:FileUpload ID="FUImagen" CssClass="file-uploader" runat="server" />

                                </div>

                                <asp:Button ID="btnSubirImagen" CssClass="btn btn-success btn-sm" Text="Subir Imagen" runat="server" Width="20%" />
                                <asp:Button ID="btnBorrarImagen" CssClass="btn btn-danger btn-sm" Text="Eliminar" runat="server" Width="20%" Visible="false" />

                            </div>
                        </div>
                    </div>
                </div>

            </asp:View>


            <asp:View ID="VGenerarCodigo" runat="server">

                <div class="panel panel-primary">
                    <div class="panel-heading">Generar Código QR</div>
                    <div align="center">
                        <div style="margin: 5px;">
                            <div style="margin: 2.5px">



                             </div>
                         </div>
                     </div>
                </div>

            </asp:View>


        </asp:MultiView>
    </div>


</asp:Content>
