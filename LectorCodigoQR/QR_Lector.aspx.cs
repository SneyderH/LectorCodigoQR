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

        protected void lkLeerCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VLeerCodigo);
            MVCodigo.Visible = true;
            pnlSeleccion.Visible = false;
        }

        protected void lkGenerarCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VGenerarCodigo);
            MVCodigo.Visible = true;
            pnlSeleccion.Visible = false;
            txtUrl.Text = string.Empty;
        }

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

        protected void lkCopiarUrl_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "popupScript", "ModalCopied();", true);
        }

        protected void btnUrlGenerate_Click(object sender, EventArgs e)
        {
            pnlUrl.Visible = true;
            pnlWhatsApp.Visible = false;

            txtGenerarUrl.Text = string.Empty;
            imgQRURL.ImageUrl = null;
            btnDescargarQR.Visible = false;
        }

        protected void btnWhatsAppGenerate_Click(object sender, EventArgs e)
        {
            pnlWhatsApp.Visible = true;
            pnlUrl.Visible = false;

            txtPrefijo.Text = string.Empty;
            txtNumeroWhatsApp.Text = string.Empty;
            imgQRWhatsApp.ImageUrl = null;
            btnDescargarQRWhatsApp.Visible = false;
        }

        protected void btnGenerarQR_Click(object sender, EventArgs e)
        {
            GenerarQR(txtGenerarUrl.Text);
            btnDescargarQR.Visible = true;
        }

        protected void btnDescargarQR_Click(object sender, EventArgs e)
        {
            DescargarQR();
        }
        protected void btnGenerarQRWhatsApp_Click(object sender, EventArgs e)
        {
            GenerarQRWhatsApp();
            btnDescargarQRWhatsApp.Visible = true;
        }
        protected void btnDescargarQRWhatsApp_Click(object sender, EventArgs e)
        {
            DescargarQRWhatsApp();
        }



        #region MÉTODOS
        private void GenerarQR(string name)
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
            imgQRURL.ImageUrl = "~/images/QRImage.png";

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
            string prefix = txtPrefijo.Text;
            string pathWhatsApp = "https://wa.me/";
            pathWhatsApp = pathWhatsApp + "+" + prefix + txtNumeroWhatsApp.Text;

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

            imgQRWhatsApp.Visible = true;
            imgQRWhatsApp.ImageUrl = "~/images/QRImage.png";
            
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


        #endregion
    }
}
