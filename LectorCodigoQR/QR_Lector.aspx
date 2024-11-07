<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QR_Lector.aspx.cs" Inherits="LectorCodigoQR.QR_Lector" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <meta name="viewport" http-equiv="Content-Type" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no" charset="utf-8" />
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
    <script src="Content/styles.css" type="text/javascript"></script>
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

    <asp:Panel ID="pnlSeleccion" runat="server">

        <section class="container lightred">
            <%--<div class="col-sm-12 col-md-6 col-lg-8">--%>

            <div class="row subtitle">
                <asp:Label ID="lblOpcion" CssClass="option" Text="¿Qué deseas realizar?" runat="server" />
            </div>

            <div class="button-option">

                <asp:LinkButton ID="lkLeerCodigo" class="btn btn-primary custom-btn btn2" OnClick="lkLeerCodigo_Click" runat="server"><i class="fa fa-file-image-o"></i>&nbsp;Leer Código QR</asp:LinkButton>
                <asp:LinkButton ID="lkGenerarCodigo" class="btn btn-primary custom-btn btn2" OnClick="lkGenerarCodigo_Click" runat="server"><i class="fa fa-qrcode"></i>&nbsp;Generar Código QR</asp:LinkButton>

            </div>
            <%--</div>--%>
        </section>
    </asp:Panel>


    <asp:MultiView ID="MVCodigo" runat="server">
        <asp:View ID="VLeerCodigo" runat="server">

            <div class="page">
                <section class="container container-content">
                    <div class="row">
                        <div class="back-button-read">
                            <asp:LinkButton ID="lkVolverLeer" CssClass="btn btn-info custom-btn" OnClick="lkVolverLeer_Click" runat="server"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Volver</asp:LinkButton>
                        </div>

                        <div class="subtitle-readqr">
                            <asp:Label ID="lblSeleccion" CssClass="selection-text" Text="Selecciona el Código QR" runat="server" Font-Size="23" />
                        </div>

                        <%--<div class="container">--%>
                        <div class="container content-qr">
                            <div class="row">
                                <div class="col-12 col-md-6 picture text-center">
                                    <h1 class="upload-icon">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                    </h1>
                                    <asp:FileUpload ID="FUImagen" CssClass="file-uploader" runat="server" accept=".png,.jpg,.jpeg,.svg" />
                                    <img id="imgPreview" src="#" alt="Previsualización" style="display: none; width: 100%; height: 100%; object-fit: cover;" />
                                </div>

                                <div class="col button-image text-center">
                                    <asp:Button ID="btnCargarImagen" CssClass="btn custom-btn btn-color-read" Text="Cargar Código" OnClick="btnCargarImagen_Click" runat="server" Style="display: none;" />
                                    <asp:Button ID="btnBorrarImagen" CssClass="btn custom-btn btn-color-delete" Text="Eliminar" runat="server" Style="display: none;" />
                                </div>


                                <div class="col-lg-4 mt-lg-0 mt-md-5 mt-4 ps-lg-4">
                                    <div class="col-12 input-group position-grid">
                                        <asp:TextBox ID="txtUrl" CssClass="form-control" runat="server" Visible="false" />
                                        <span class="input-group-btn">
                                            <asp:LinkButton ID="lkCopiarUrl" CssClass="btn btn-default" OnClick="lkCopiarUrl_Click" OnClientClick="CopyToClipboard()" runat="server" Visible="false">
                                                <i class="fa fa-clone" aria-hidden="true" id="copyIcon" style="color: green;"></i>
                                            </asp:LinkButton>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <%--</div>--%>
                </section>

                <aside>
                    <asp:Label Text="¿No sabes cómo usar el lector de codigo QR?" runat="server" />

                    <asp:Button ID="btnSaberMas" Text="Saber Más" runat="server" />
                </aside>
            </div>











        </asp:View>


        <asp:View ID="VGenerarCodigo" runat="server">
            <div class="page">
                <div class="container container-generate">

                    <div class="back-button">
                        <asp:LinkButton ID="lkVolverGenerar" CssClass="btn btn-info custom-btn" OnClick="lkVolverGenerar_Click" runat="server"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Volver</asp:LinkButton>
                    </div>

                    <div class="menu-opctions">
                        <ul>
                            <li>
                                <div class="custom-btn btn-8" onclick="<%=btnUrlGenerate.ClientID %>.click()">
                                    <i class="fa fa-link" aria-hidden="true"></i>
                                    <asp:Button ID="btnUrlGenerate" ClientIDMode="Static" Font-Bold="true" CssClass="btn-reset" Text="URL" runat="server" OnClick="btnUrlGenerate_Click" />
                                </div>
                            </li>

                            <li>
                                <div class="custom-btn btn-8" onclick="<%=btnWhatsAppGenerate.ClientID %>.click()">
                                    <i class="fa fa-whatsapp" aria-hidden="true"></i>
                                    <asp:Button ID="btnWhatsAppGenerate" ClientIDMode="Static" Font-Bold="true" CssClass="btn-reset" Text="WHATSAPP" runat="server" OnClick="btnWhatsAppGenerate_Click" />
                                </div>
                            </li>

                            <%--<li>
                                <div class="custom-btn btn-8" onclick="<%=btnSMSGenerate.ClientID %>.click()">
                                    <i class="fa fa-commenting-o" aria-hidden="true"></i>
                                    <asp:Button ID="btnSMSGenerate" ClientIDMode="Static" Font-Bold="true" CssClass="btn-reset" Text="SMS" runat="server" />
                                </div>
                            </li>--%>

                            <li>
                                <div class="custom-btn btn-8" onclick="<%=btnTelefonoGenerate.ClientID %>.click()">
                                    <i class="fa fa-phone" aria-hidden="true"></i>
                                    <asp:Button ID="btnTelefonoGenerate" ClientIDMode="Static" Font-Bold="true" CssClass="btn-reset" Text="TELÉFONO" runat="server" OnClick="btnTelefonoGenerate_Click" />
                                </div>
                            </li>

                            <li>
                                <div class="custom-btn btn-8" onclick="<%=btnTextoGenerate.ClientID %>.click()">
                                    <i class="fa fa-align-justify" aria-hidden="true"></i>
                                    <asp:Button ID="btnTextoGenerate" ClientIDMode="Static" Font-Bold="true" CssClass="btn-reset" Text="TEXTO" runat="server" OnClick="btnTextoGenerate_Click" />
                                </div>
                            </li>
                        </ul>
                    </div>
                    <br />


                    <asp:Panel ID="pnlUrl" runat="server" Visible="false">
                        <div>
                            <center>
                                <h1>GENERAR QR POR URL</h1>
                            </center>

                            <div class="content-url">
                                <asp:TextBox ID="txtGenerarUrl" CssClass="form-control" placeholder="Ingrese la dirección URL" runat="server" ForeColor="Black" />
                                <asp:Button ID="btnGenerarQR" Text="Generar" CssClass="btn btn-success btn-generate-url" OnClick="btnGenerarQR_Click" runat="server" />
                            </div>

                            <div class="error-url">
                                <asp:Label ID="lblMensajeErrorURL" CssClass="error-color" Text="" runat="server" />
                            </div>

                            <div class="generated-qr-url">
                                <asp:Image ID="imgQRURL" ImageUrl="imageurl" CssClass="image-generated-url" runat="server" />

                                <div class="download-qr-url">
                                    <asp:Button ID="btnDescargarQR" CssClass="btn btn-success btn-download-url" Text="Descargar" OnClick="btnDescargarQR_Click" runat="server" Visible="false" />
                                    <asp:Button ID="btnNuevaGeneracion" CssClass="btn btn-info btn-generate-url" Text="Generar Nuevo QR" OnClick="btnNuevaGeneracion_Click" runat="server" Visible="false" />
                                </div>
                            </div>

                        </div>
                    </asp:Panel>


                    <asp:Panel ID="pnlWhatsApp" runat="server" Visible="false">
                        <div>
                            <center>
                                <h1>GENERAR QR POR WHATSAPP</h1>
                            </center>

                            <div class="content-whatsapp">
                                <div id="dvGroup" class="input-group" runat="server">
                                    <div class="input-group-addon">
                                        <div class="input-group-text">+</div>
                                    </div>
                                    <asp:TextBox ID="txtPrefijo" CssClass="form-control" placeholder="EJ: 57" runat="server" ForeColor="Black" Width="80" />
                                </div>

                                <asp:TextBox ID="txtNumeroWhatsApp" CssClass="form-control text-number-wpp" placeholder="Ingrese el número" runat="server" ForeColor="Black" />
                            </div>

                            <div class="content-whatsapp-option">
                                <asp:Label ID="lblMensajeError" CssClass="error-color" Text="" runat="server" />
                                <div class="generate-wpp">
                                    <asp:Button ID="btnGenerarQRWhatsApp" CssClass="btn btn-success" Text="Generar" OnClick="btnGenerarQRWhatsApp_Click" runat="server" />
                                </div>
                            </div>

                            <div class="generated-qr-wpp">
                                <asp:Image ID="imgQRWhatsApp" ImageUrl="imageurl" runat="server" />

                                <div class="download-qr-wpp">
                                    <asp:Button ID="btnDescargarQRWhatsApp" CssClass="btn btn-success btn-download-wpp" Text="Descargar" OnClick="btnDescargarQRWhatsApp_Click" runat="server" Visible="false" />
                                    <asp:Button ID="btnNuevaGeneracionWhatsApp" CssClass="btn btn-info btn-generate-wpp" Text="Generar Nuevo QR" OnClick="btnNuevaGeneracionWhatsApp_Click" runat="server" Visible="false" />
                                </div>
                            </div>

                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlTelefono" runat="server" Visible="false">
                        <div>
                            <center>
                                <h1>GENERAR QR POR TELÉFONO</h1>
                            </center>

                            <div class="content-tel">
                                <asp:TextBox ID="txtNumeroTelefono" CssClass="form-control" placeholder="Digite el número de teléfono" runat="server" ForeColor="Black" />
                                <asp:Button ID="btnGenerarQRTelefono" Text="Generar" CssClass="btn btn-success btn-generate-tel" OnClick="btnGenerarQRTelefono_Click" runat="server" />
                            </div>

                            <div class="error-tel">
                                <asp:Label ID="lblMensajeErrorTel" CssClass="error-color" Text="" runat="server" />
                            </div>

                            <div class="generated-qr-tel">
                                <asp:Image ID="imgQRTelefono" ImageUrl="imageurl" CssClass="image-generated-tel" runat="server" />

                                <div class="download-qr-tel">
                                    <asp:Button ID="btnDescargarQRTelefono" CssClass="btn btn-success btn-download-url" Text="Descargar" OnClick="btnDescargarQRTelefono_Click" runat="server" Visible="false" />
                                    <asp:Button ID="btnNuevaGeneracionTelefono" CssClass="btn btn-info btn-generate-url" Text="Generar Nuevo QR" OnClick="btnNuevaGeneracionTelefono_Click" runat="server" Visible="false" />
                                </div>
                            </div>

                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlTexto" runat="server" Visible="false">
                        <div>
                            <center>
                                <h1>GENERAR QR POR TEXTO</h1>
                            </center>

                            <div class="content-txt">
                                <textarea id="txaTexto" class="form-control txa-texto" placeholder="Escriba su texto" runat="server"></textarea>
                            </div>

                            <div class="content-text-option">
                                <asp:Button ID="btnGenerarQRTexto" CssClass="btn btn-success btn-generate-txt" Text="Generar" OnClick="btnGenerarQRTexto_Click" runat="server" />
                            </div>

                            <div class="generated-qr-txt">
                                <asp:Image ID="imgQRTexto" ImageUrl="imageurl" CssClass="image-generated-txt" runat="server" />

                                <div class="download-qr-txt">
                                    <asp:Button ID="btnDescargarQRTexto" CssClass="btn btn-success btn-download-txt" Text="Descargar" OnClick="btnDescargarQRTexto_Click" runat="server" Visible="false" />
                                    <asp:Button ID="btnNuevaGeneracionTexto" CssClass="btn btn-info btn-generate-txt" Text="Generar Nuevo QR" OnClick="btnNuevaGeneracionTexto_Click" runat="server" Visible="false" />
                                </div>
                            </div>
                        </div>

                    </asp:Panel>


                </div>
            </div>

        </asp:View>


    </asp:MultiView>


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

        document.getElementById('<%= FUImagen.ClientID %>').addEventListener('change', function () {
            if (this.files.length > 0) {
                document.getElementById('<%= txtUrl.ClientID %>').style.display = 'none';
                document.getElementById('<%= lkCopiarUrl.ClientID %>').style.display = 'none';
            }
        });


    </script>

</asp:Content>


