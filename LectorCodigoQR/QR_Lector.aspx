<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QR_Lector.aspx.cs" Inherits="LectorCodigoQR.QR_Lector" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
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

        function ModalCopied(sttexto) {
            Swal.fire({
                title: "¡Copiado!",
                icon: 'success',
                html: sttexto,
                timer: 2000,
                timerProgressBar: false,
                didOpen: () => {
                    Swal.showLoading();
                    const timer = Swal.getPopup().querySelector("b");
                    timerInterval = setInterval(() => {
                        timer.textContent = `${Swal.getTimerLeft()}`;
                    }, 100);
                },
                willClose: () => {
                    clearInterval(timerInterval);
                }
            }).then((result) => {
                /* Read more about handling dismissals below */
                if (result.dismiss === Swal.DismissReason.timer) {
                    console.log("I was closed by the timer");
                }
            });
        }
    </script>

    <div class="animation-area">
        <div class="text">
            <asp:Label ID="lblTitulo" CssClass="title" Text="Lector de Códigos QR Online" runat="server" /><br />
        </div>

        <ul class="box-area">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>


    <section class="lightred">
        <div class="subtitle">
            <asp:Label ID="lblOpcion" CssClass="option" Text="¿Qué deseas realizar?" runat="server" />
        </div>

        <div class="button-option">

            <asp:LinkButton ID="lkLeerCodigo" class="btn btn-primary btn-lg custom-btn btn2 btn1" OnClick="lkLeerCodigo_Click" runat="server"><i class="fa fa-file-image-o"></i>&nbsp;Leer Código QR</asp:LinkButton>
            <asp:LinkButton ID="lkGenerarCodigo" class="btn btn-primary btn-lg custom-btn btn2" OnClick="lkGenerarCodigo_Click" runat="server"><i class="fa fa-qrcode"></i>&nbsp;Generar Código QR</asp:LinkButton>

        </div>
    </section>


    <div class="container-content">
        <asp:MultiView ID="MVCodigo" runat="server">
            <asp:View ID="VLeerCodigo" runat="server">


                <div class="back-button">
                    <asp:LinkButton ID="lkVolverLeer" CssClass="btn btn-info custom-btn" OnClick="lkVolverLeer_Click" runat="server"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Volver</asp:LinkButton>
                </div>

                    <asp:label id="lblSeleccion" cssclass="selection-text" text="Selecciona el Código QR" runat="server" font-size="23" />

                    <div class="content-qr">
                        <div class="picture">
                            <h1 class="upload-icon">
                                <i class="fa fa-plus-circle" aria-hidden="true"></i>
                            </h1>

                            <asp:FileUpload ID="FUImagen" CssClass="file-uploader" runat="server" accept=".png,.jpg,.jpeg,.svg" />
                            <img id="imgPreview" src="#" alt="Previsualización" style="display: none; width: 100%; height: 100%; object-fit: cover;" />

                        </div>

                        
                        <div class="button-image">
                            <asp:Button ID="btnCargarImagen" CssClass="btn custom-btn btn-color-read" Text="Cargar Código" OnClick="btnCargarImagen_Click" runat="server" Style="display: none;" />
                            <%--SHOW ARROW TO INPUT--%>

                            <asp:Button ID="btnBorrarImagen" CssClass="btn custom-btn btn-color-delete" Text="Eliminar" runat="server" Style="display: none;" />
                        </div>

                        <div class="input-group position-grid">
                            
                            <asp:TextBox ID="txtUrl" CssClass="form-control" runat="server" Visible="false" />
                            <span class="input-group-btn">
                                <asp:LinkButton ID="lkCopiarUrl" CssClass="btn btn-default" OnClick="lkCopiarUrl_Click" OnClientClick="CopyToClipboard()" runat="server" Visible="false"><i class="fa fa-clone" aria-hidden="true" id="copyIcon" style="color: green;"></i></asp:LinkButton>
                            </span>

                        </div>
                    </div>








                    

            </asp:View>


            <asp:View ID="VGenerarCodigo" runat="server">

                    <div class="back-button">
                        <asp:LinkButton ID="lkVolverGenerar" CssClass="btn btn-info custom-btn" OnClick="lkVolverGenerar_Click" runat="server"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Volver</asp:LinkButton>
                    </div>

                    <div class="menu-opctions">
                        <ul>
                            <li>
                                <div class="btn" onclick="<%=btnUrlGenerate.ClientID %>.click()">
                                    <i class="fa fa-link" aria-hidden="true"></i>
                                    <asp:Button ID="btnUrlGenerate" ClientIDMode="Static" Font-Bold="true" CssClass="btn-reset" Text="URL" runat="server" OnClick="btnUrlGenerate_Click" />
                                </div>
                            </li>

                            <li>
                                <div class="btn" onclick="<%=btnWhatsAppGenerate.ClientID %>.click()">
                                    <i class="fa fa-whatsapp" aria-hidden="true"></i>
                                    <asp:Button ID="btnWhatsAppGenerate" ClientIDMode="Static" Font-Bold="true" CssClass="btn-reset" Text="WHATSAPP" runat="server" OnClick="btnWhatsAppGenerate_Click" />
                                </div>
                            </li>

                            <li>SMS</li>
                            <li>TELÉFONO</li>
                            <li>TEXTO</li>
                        </ul>
                    </div>
                <div class="content-qr">

                    <div class="content-generate-panel">
                        <asp:Panel ID="pnlUrl" runat="server" Visible="false">
                            <h1>GENERAR QR POR URL</h1>

                            <div>
                                <asp:TextBox ID="txtGenerarUrl" runat="server" ForeColor="Black" />
                                <asp:Button ID="btnGenerarQR" Text="Generar" OnClick="btnGenerarQR_Click" runat="server" />
                            </div>

                            <div>
                                <asp:Image ID="imgQRGenerado" ImageUrl="imageurl" runat="server" />
                                <asp:PlaceHolder ID="phQRGenerado" runat="server" />
                                <asp:Button ID="btnDescargarQR" Text="Descargar" OnClick="btnDescargarQR_Click" runat="server" Visible="false" />
                            </div>

                        </asp:Panel>


                        <asp:Panel ID="pnlWhatsApp" runat="server" Visible="false">
                            <h1>GENERAR QR POR WHATSAPP</h1>
                        </asp:Panel>
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
                .catch((error) => {
                    alert(`Copy failed. Error: ${error}`);
                });
        }
    </script>

    <script src="Content/styles.css" type="text/javascript"></script>

</asp:Content>


