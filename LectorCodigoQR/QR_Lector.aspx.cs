using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LectorCodigoQR
{
    public partial class QR_Lector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (FUImagen.HasFile)
            {
                btnBorrarImagen.Visible = true;
            }
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


    }
}