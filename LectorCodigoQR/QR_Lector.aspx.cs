using Svg;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZXing;
using ZXing.Common;

namespace LectorCodigoQR
{
    public partial class QR_Lector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //MVCodigo.SetActiveView(VCodigo);
        }

        protected void lkLeerCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VLeerCodigo);
            lkGenerarCodigo.Visible = false;
            lkLeerCodigo.Visible = false;
            lblOpcion.Visible = false;
        }

        protected void lkGenerarCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VGenerarCodigo);
            lkGenerarCodigo.Visible = false;
            lkLeerCodigo.Visible = false;
            lblOpcion.Visible = false;
        }

        protected void btnCargarImagen_Click(object sender, EventArgs e)
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
                    lblUrl.Text = result.Text;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "popupScript", "BtnError('No se pudo leer el código QR.');", true);
                }
            }
        }
    }
}