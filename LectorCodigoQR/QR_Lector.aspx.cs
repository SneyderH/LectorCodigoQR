using Svg;
using System;
using System.IO;
using System.Drawing;
using System.Web.UI;
using ZXing;
using System.Drawing.Imaging;
using static QRCoder.PayloadGenerator;

namespace LectorCodigoQR
{
    public partial class QR_Lector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MaintainScrollPositionOnPostBack = true;
        }

        #region ACTIVAR MULTIVIEW DE LECTURA DE CÓDIGO QR
        protected void lkLeerCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VLeerCodigo);
            MVCodigo.Visible = true;
            pnlSeleccion.Visible = false;
        }

        #endregion

        #region ACTIVAR MULTIVIEW DE GENERACIÓN DE CÓDIGO QR
        protected void lkGenerarCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VGenerarCodigo);
            MVCodigo.Visible = true;
            pnlSeleccion.Visible = false;
            txtUrl.Text = string.Empty;
        }
        #endregion

        #region MÉTODO PARA CARGAR CÓDIGO QR
        protected void btnCargarImagen_Click(object sender, EventArgs e)
        {
            try
            {
                string fileName = Path.GetFileName(FUImagen.PostedFile.FileName);
                Stream fs = FUImagen.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                byte[] bytes = br.ReadBytes((Int32)fs.Length);
                using (MemoryStream ms = new MemoryStream(bytes))
                {
                    Bitmap bitMap;

                    if (fileName.EndsWith(".svg", StringComparison.OrdinalIgnoreCase))
                    {
                        // Convert SVG to Bitmap
                        var svgDocument = SvgDocument.Open<SvgDocument>(ms);
                        bitMap = new Bitmap((int)svgDocument.Width, (int)svgDocument.Height);
                        using (Graphics g = Graphics.FromImage(bitMap))
                        {
                            svgDocument.Draw(g);
                        }
                    }
                    else
                    {
                        // Create Bitmap from selected file
                        bitMap = new Bitmap(ms);
                    }

                    // Read the QRCode
                    var barcodeReader = new BarcodeReader();
                    var result = barcodeReader.Decode(bitMap);

                    if (result != null)
                    {
                        lkCopiarUrl.Visible = true;
                        txtUrl.Visible = true;
                        txtUrl.Text = result.Text;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, Page.GetType(), "popupScript", "BtnError('No se pudo leer el código QR.');", true);
                    }
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine(ex.Message);
            }
        }
        #endregion

        #region BOTÓN 'VOLVER' DEL PANEL 'LEER QR'
        protected void lkVolverLeer_Click(object sender, EventArgs e)
        {
            MVCodigo.Visible = false;
            lblOpcion.Visible = true;
            lkGenerarCodigo.Visible = true;
            lkLeerCodigo.Visible = true;
            txtUrl.Visible = false;
            lkCopiarUrl.Visible = false;
            pnlSeleccion.Visible = true;
        }
        #endregion

        #region BOTÓN 'VOLVER' DEL PANEL 'GENERAR QR'
        protected void lkVolverGenerar_Click(object sender, EventArgs e)
        {
            MVCodigo.Visible = false;
            lblOpcion.Visible = true;
            lkGenerarCodigo.Visible = true;
            lkLeerCodigo.Visible = true;

            pnlUrl.Visible = false;
            pnlWhatsApp.Visible = false;
            pnlSeleccion.Visible = true;
        }
        #endregion



        #region ACTIVAR ALERTA DE 'COPIADO'
        protected void lkCopiarUrl_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "popupScript", "ModalCopied();", true);
        }
        #endregion



        #region BOTONES DEL NAVBAR
        //URL
        protected void btnUrlGenerate_Click(object sender, EventArgs e)
        {
            pnlUrl.Visible = true;
            pnlWhatsApp.Visible = false;
            pnlTelefono.Visible = false;
            pnlTexto.Visible = false;

            txtGenerarUrl.Visible = true;
            btnGenerarQR.Visible = true;

            txtGenerarUrl.Text = string.Empty;
            imgQRURL.ImageUrl = null;
            btnDescargarQR.Visible = false;
            btnNuevaGeneracion.Visible = false;
        }

        //WHATSAPP
        protected void btnWhatsAppGenerate_Click(object sender, EventArgs e)
        {
            pnlWhatsApp.Visible = true;
            pnlUrl.Visible = false;
            pnlTelefono.Visible = false;
            pnlTexto.Visible = false;

            txtPrefijo.Text = string.Empty;
            txtNumeroWhatsApp.Text = string.Empty;
            imgQRWhatsApp.ImageUrl = null;
            btnDescargarQRWhatsApp.Visible = false;
            btnNuevaGeneracionWhatsApp.Visible = false;
        }

        //TELEFONO
        protected void btnTelefonoGenerate_Click(object sender, EventArgs e)
        {
            pnlTelefono.Visible = true;
            pnlWhatsApp.Visible = false;
            pnlUrl.Visible = false;
            pnlTexto.Visible = false;

            txtNumeroTelefono.Text = string.Empty;
            imgQRTelefono.ImageUrl = null;
            btnDescargarQRTelefono.Visible = false;
            btnNuevaGeneracionTelefono.Visible = false;
        }

        protected void btnTextoGenerate_Click(object sender, EventArgs e)
        {
            pnlTexto.Visible = true;
            pnlTelefono.Visible = false;
            pnlWhatsApp.Visible = false;
            pnlUrl.Visible = false;

            txaTexto.Value = string.Empty;
            imgQRTexto.ImageUrl = null;
            btnDescargarQRTexto.Visible = false;
            btnNuevaGeneracionTexto.Visible = false;
        }
        #endregion


        #region BOTONES DE LA PESTAÑA URL
        protected void btnGenerarQR_Click(object sender, EventArgs e)
        {
            GenerarQR(txtGenerarUrl.Text);
        }

        protected void btnDescargarQR_Click(object sender, EventArgs e)
        {
            DescargarQR();
        }

        protected void btnNuevaGeneracion_Click(object sender, EventArgs e)
        {
            btnGenerarQR.Visible = true;
            txtGenerarUrl.Visible = true;

            imgQRURL.Visible = false;
            btnDescargarQR.Visible = false;
            btnNuevaGeneracion.Visible = false;
        }
        #endregion

        #region BOTONES DE LA PESTAÑA WHATSAPP
        protected void btnGenerarQRWhatsApp_Click(object sender, EventArgs e)
        {
            GenerarQRWhatsApp();
        }

        protected void btnNuevaGeneracionWhatsApp_Click(object sender, EventArgs e)
        {
            txtPrefijo.Text = string.Empty;
            txtNumeroWhatsApp.Text = string.Empty;

            dvGroup.Visible = true;
            txtPrefijo.Visible = true;
            txtNumeroWhatsApp.Visible = true;
            btnGenerarQRWhatsApp.Visible = true;

            imgQRWhatsApp.Visible = false;
            btnDescargarQRWhatsApp.Visible = false;
            btnNuevaGeneracionWhatsApp.Visible = false;
        }
        protected void btnDescargarQRWhatsApp_Click(object sender, EventArgs e)
        {
            DescargarQRWhatsApp();
        }

        #endregion

        #region BOTONES DE LA PESTAÑA TELEFONO
        protected void btnGenerarQRTelefono_Click(object sender, EventArgs e)
        {
            GenerarQRTelefono(txtNumeroTelefono.Text);
        }

        protected void btnDescargarQRTelefono_Click(object sender, EventArgs e)
        {
            DescargarQRTelefono();
        }

        protected void btnNuevaGeneracionTelefono_Click(object sender, EventArgs e)
        {
            txtNumeroTelefono.Text = string.Empty;

            txtNumeroTelefono.Visible = true;
            btnGenerarQRTelefono.Visible = true;

            imgQRTelefono.Visible = false;
            btnDescargarQRTelefono.Visible = false;
            btnNuevaGeneracionTelefono.Visible = false;
        }

        #endregion

        #region BOTONES DE LA PESTAÑA TEXTO
        protected void btnGenerarQRTexto_Click(object sender, EventArgs e)
        {
            GenerarQRTexto(txaTexto.Value);
        }

        protected void btnDescargarQRTexto_Click(object sender, EventArgs e)
        {
            DescargarQRTexto();
        }

        protected void btnNuevaGeneracionTexto_Click(object sender, EventArgs e)
        {
            txaTexto.Value = string.Empty;

            txaTexto.Visible = true;
            btnGenerarQRTexto.Visible = true;

            imgQRTexto.Visible = false;
            btnDescargarQRTexto.Visible = false;
            btnNuevaGeneracionTexto.Visible = false;
        }


        #endregion

        #region MÉTODOS
        private void GenerarQR(string name)
        {
            if (name.Contains("https://"))
            {
                var writer = new BarcodeWriter();
                writer.Format = BarcodeFormat.QR_CODE;
                writer.Options = new ZXing.Common.EncodingOptions { Width=200, Height=200 };
                var result = writer.Write(name);
                string path = Server.MapPath("~/images/QRImage.png");
                var barcodeBitmap = new Bitmap(result);

                using (MemoryStream memory = new MemoryStream())
                {
                    using (FileStream fs = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
                    {
                        barcodeBitmap.Save(memory, ImageFormat.Png);
                        byte[] bytes = memory.ToArray();
                        fs.Write(bytes, 0, bytes.Length);
                    }
                }

                imgQRURL.Visible = true;
                btnDescargarQR.Visible = true;
                btnNuevaGeneracion.Visible = true;
                imgQRURL.ImageUrl = "~/images/QRImage.png";

                lblMensajeErrorURL.Visible = false;
                btnGenerarQR.Visible = false;
                txtGenerarUrl.Visible = false;
                txtGenerarUrl.Text = string.Empty;
            }
            else
            {
                lblMensajeErrorURL.Visible = true;
                lblMensajeErrorURL.Text = "Verifique que la dirección URL contenga (https://).";
            }
        }

        private void DescargarQR()
        {
            string fileName = "QRImage.png";
            string filePath = Server.MapPath(string.Format("~/images/{0}", fileName));
            Response.ContentType = "application/png";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);

            Response.WriteFile(filePath);
            Response.Flush();
            Response.End();
        }

        private void GenerarQRWhatsApp()
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(txtPrefijo.Text, "^[0-9 -]*$"))
            {
                string prefix = txtPrefijo.Text.Replace(" ", "").Trim();
                string wppNumber = txtNumeroWhatsApp.Text.Replace(" ", "").Trim();
                string pathWhatsApp = "https://wa.me/";
                pathWhatsApp = pathWhatsApp + "+" + prefix + wppNumber;

                var writer = new BarcodeWriter();
                writer.Format = BarcodeFormat.QR_CODE;
                writer.Options = new ZXing.Common.EncodingOptions { Width = 200, Height = 200 };
                var result = writer.Write(pathWhatsApp);
                string path = Server.MapPath("~/imagesWpp/QRImageWpp.png");
                var barcodeBitmap = new Bitmap(result);

                using (MemoryStream memory = new MemoryStream())
                {
                    using (FileStream fs = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
                    {
                        barcodeBitmap.Save(memory, ImageFormat.Png);
                        byte[] bytes = memory.ToArray();
                        fs.Write(bytes, 0, bytes.Length);
                    }
                }

                lblMensajeError.Visible = false;
                dvGroup.Visible = false;
                txtPrefijo.Visible = false;
                txtNumeroWhatsApp.Visible = false;
                btnGenerarQRWhatsApp.Visible = false;

                imgQRWhatsApp.Visible = true;
                btnDescargarQRWhatsApp.Visible = true;
                btnNuevaGeneracionWhatsApp.Visible = true;
                imgQRWhatsApp.ImageUrl = "~/images/QRImage.png";
            }
            else
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Verifique que el prefijo o número de teléfono no contenga ningún caracter especial.";
            }
        }

        private void DescargarQRWhatsApp()
        {
            string fileName = "QRImageWpp.png";
            string filePath = Server.MapPath(string.Format("~/imagesWpp/{0}", fileName));
            Response.ContentType = "application/png";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);

            Response.WriteFile(filePath);
            Response.Flush();
            Response.End();
        }


        private void GenerarQRTelefono(string nTelefono)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(txtNumeroTelefono.Text, "^[0-9 +-]*$"))
            {
                nTelefono = nTelefono.Replace(" ", "").Trim();

                var writer = new BarcodeWriter();
                writer.Format = BarcodeFormat.QR_CODE;
                writer.Options = new ZXing.Common.EncodingOptions { Width = 200, Height = 200 };
                var result = writer.Write(nTelefono);
                string path = Server.MapPath("~/imagesTel/QRImageTel.png");
                var barcodeBitmap = new Bitmap(result);

                using (MemoryStream memory = new MemoryStream())
                {
                    using (FileStream fs = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
                    {
                        barcodeBitmap.Save(memory, ImageFormat.Png);
                        byte[] bytes = memory.ToArray();
                        fs.Write(bytes, 0, bytes.Length);
                    }
                }

                imgQRTelefono.Visible = true;
                btnDescargarQRTelefono.Visible = true;
                btnNuevaGeneracionTelefono.Visible = true;
                imgQRTelefono.ImageUrl = "~/images/QRImage.png";

                lblMensajeErrorTel.Visible = false;
                btnGenerarQRTelefono.Visible = false;
                txtNumeroTelefono.Visible = false;
                txtNumeroTelefono.Text = string.Empty;
            }
            else
            {
                lblMensajeErrorTel.Text = "Verifique que el número no contenga ningún tipo de letra";
            }
            
        }

        private void DescargarQRTelefono()
        {
            string fileName = "QRImageTel.png";
            string filePath = Server.MapPath(string.Format("~/imagesTel/{0}", fileName));
            Response.ContentType = "application/png";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);

            Response.WriteFile(filePath);
            Response.Flush();
            Response.End();
        }

        private void GenerarQRTexto(string texto)
        {
            var writer = new BarcodeWriter();
            writer.Format = BarcodeFormat.QR_CODE;
            writer.Options = new ZXing.Common.EncodingOptions { Width = 200, Height = 200 };
            var result = writer.Write(texto);
            string path = Server.MapPath("~/imagesTxt/QRImageTxt.png");
            var barcodeBitmap = new Bitmap(result);

            using (MemoryStream memory = new MemoryStream())
            {
                using (FileStream fs = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
                {
                    barcodeBitmap.Save(memory, ImageFormat.Png);
                    byte[] bytes = memory.ToArray();
                    fs.Write(bytes, 0, bytes.Length);
                }
            }

            imgQRTexto.Visible = true;
            btnDescargarQRTexto.Visible = true;
            btnNuevaGeneracionTexto.Visible = true;
            imgQRTexto.ImageUrl = "~/images/QRImage.png";

            btnGenerarQRTexto.Visible = false;
            txaTexto.Visible = false;
            txaTexto.Value = string.Empty;
        }

        private void DescargarQRTexto()
        {
            string fileName = "QRImageTxt.png";
            string filePath = Server.MapPath(string.Format("~/imagesTxt/{0}", fileName));
            Response.ContentType = "application/png";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);

            Response.WriteFile(filePath);
            Response.Flush();
            Response.End();
        }

        #endregion

    }
}
