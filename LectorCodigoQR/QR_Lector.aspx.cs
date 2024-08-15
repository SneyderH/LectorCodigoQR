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

            //MVCodigo.SetActiveView(VCodigo);
        }

        protected void lkLeerCodigo_Click(object sender, EventArgs e)
        {
            MVCodigo.SetActiveView(VCodigo);
        }

        protected void lkGenerarCodigo_Click(object sender, EventArgs e)
        {

        }
    }
}