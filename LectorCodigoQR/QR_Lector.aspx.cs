using Svg;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using ZXing;
using ZXing.Common;

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
            lkGenerarCodigo.Visible = false;
            lkLeerCodigo.Visible = false;
            lblOpcion.Visible = false;
            txtUrl.Text = string.Empty;
        }

        protected void lkGenerarCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VGenerarCodigo);
            MVCodigo.Visible = true;
            lkGenerarCodigo.Visible = false;
            lkLeerCodigo.Visible = false;
            lblOpcion.Visible = false;
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
        }

        protected void lkVolverGenerar_Click(object sender, EventArgs e)
        {
            MVCodigo.Visible = false;
            lblOpcion.Visible = true;
            lkGenerarCodigo.Visible = true;
            lkLeerCodigo.Visible = true;
        }

        protected void lkCopiarUrl_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "popupScript", "ModalCopied();", true);
        }
    }
}