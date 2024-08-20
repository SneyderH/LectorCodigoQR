<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QR_Lector.aspx.cs" Inherits="LectorCodigoQR.QR_Lector" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" rel="Stylesheet" type="text/css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <link href="Content/styles.css" rel="stylesheet" />

    <script>
        function BtnConsultar(sttexto) {
            Swal.fire({
                icon: 'success',
                html: sttexto
            })
        }

        function BtnInfo(sttexto) {
            Swal.fire({
                icon: 'info',
                html: sttexto
            })
        }

        function BtnError(sttexto) {
            Swal.fire({
                icon: 'error',
                html: sttexto
            })
        }
    </script>


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
                    <div class="panel-heading d-flex">Leer Código QR
                        <asp:LinkButton ID="lkVolverLeer" CssClass="btn btn-info btn-xs pull-right" OnClick="lkVolverLeer_Click" runat="server"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Volver</asp:LinkButton>
                    </div>


                    <div align="center">
                        <div style="margin: 5px;">
                            <div style="margin: 2.5px">

                                <asp:Label ID="lblSeleccion" Text="Selecciona el código QR" runat="server" Font-Size="23" />

                                <div class="picture">
                                    <h1 class="upload-icon">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                    </h1>

                                    <asp:FileUpload ID="FUImagen" CssClass="file-uploader" runat="server" accept=".png,.jpg,.jpeg,.svg" />
                                    <img id="imgPreview" src="#" alt="Previsualización" style="display:none; width: 100%; height: 100%; object-fit: cover;" />

                                </div>

                                
                                    
                                        
                                            <div class="input-group">
                                                <asp:TextBox ID="txtUrl" CssClass="form-control" runat="server" Visible="false" />
                                                <span class="input-group-btn">
                                                    <asp:LinkButton ID="lkCopiarUrl" CssClass="btn btn-default" OnClientClick="CopyToClipboard()" runat="server" Visible="false"><i class="fa fa-clone" aria-hidden="true"></i></asp:LinkButton>
                                                </span>
                                            </div>
                                        
                                    
                                

                                <div class="button-container">

                                    <asp:Button ID="btnCargarImagen" CssClass="btn btn-success btn-sm"  Text="Cargar Código" OnClick="btnCargarImagen_Click" runat="server" Width="20%" style="display: none;" />
                                    <asp:Button ID="btnBorrarImagen" CssClass="btn btn-danger btn-sm" Text="Eliminar" runat="server" Width="20%" style="display: none;" />

                                </div>


                            </div>
                        </div>
                    </div>
                </div>

            </asp:View>


            <asp:View ID="VGenerarCodigo" runat="server">

                <div class="panel panel-primary">
                    <div class="panel-heading">Generar Código QR
                        <asp:LinkButton ID="lkVolverGenerar" CssClass="btn btn-info btn-xs pull-right" OnClick="lkVolverGenerar_Click" runat="server"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Volver</asp:LinkButton>
                    </div>
                    <div align="center">
                        <div style="margin: 5px;">
                            <div style="margin: 2.5px">

                                <asp:Label ID="lblOpcionGenerar" Text="¿Qué tipo de código desea generar?" runat="server" />

                             </div>
                         </div>
                     </div>
                </div>

            </asp:View>


        </asp:MultiView>
    </div>

    <script>

        document.addEventListener('DOMContentLoaded', function () {
            var fileUpload = document.getElementById('<%= FUImagen.ClientID %>');
            var imgPreview = document.getElementById('imgPreview');

            fileUpload.addEventListener('change', function () {
                var file = fileUpload.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        imgPreview.src = e.target.result;
                        imgPreview.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                } else {
                    imgPreview.style.display = 'none';
                }
            });
        });

        window.onload = function () {
            var fileUpload = document.getElementById('<%= FUImagen.ClientID %>');
            var deleteButton = document.getElementById('<%= btnBorrarImagen.ClientID %>');
            var uploadButton = document.getElementById('<%= btnCargarImagen.ClientID %>');

            if (fileUpload && deleteButton && uploadButton) {
                fileUpload.addEventListener('change', function () {
                    if (fileUpload.value !== "") {
                        deleteButton.style.display = 'block';
                        uploadButton.style.display = 'block';
                    } else {
                        deleteButton.style.display = 'none';
                        uploadButton.style.display = 'none';
                    }
                });
            } else {
                console.error('El elemento FileUpload o el botón de eliminar no se encontraron.');
            }
        };

        function CopyToClipboard() {
            var copyText = $('[id$="txtUrl"]').val(); // txt_Output is the id of your textbox to copy from. Could refactor this to pass as a parameter as well if desired.

            navigator.clipboard.writeText(copyText)
                .then(() => {
                    var icon = document.getElementById('copyIcon');
                    icon.classList.remove('fa-clone');
                    icon.classList.add('fa-check');
                    setTimeout(() => {
                        icon.classList.remove('fa-check');
                        icon.classList.add('fa-clone');
                    }, 2000); // Cambia el icono de vuelta después de 2 segundos
                    alert('Copied to clipboard.');
                })
                .catch((error) => {
                    alert(`Copy failed. Error: ${error}`);
                });
        }
    </script>

</asp:Content>


