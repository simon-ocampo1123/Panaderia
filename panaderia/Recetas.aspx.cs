using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace panaderia
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                limpiarDatos();
                CargarDatosReceta();
            }
        }

        public void CargarDatosReceta()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "SPSReceta";
                cmd.Connection = conn;
                conn.Open();
                gvRecetas.DataSource = cmd.ExecuteReader();
                gvRecetas.DataBind();
            }
        }

        protected void btnNuevo_Click1(object sender, EventArgs e)
        {
            pnlDatosReceta.Visible = false;
            pnlNuevaReceta.Visible = true;
            LblNuevo.Visible = true;
            limpiarDatos();
        }

        public void GuardarRecetas()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "SPIReceta";
                cmd.Parameters.Add("@NombreDeProducto", SqlDbType.VarChar).Value = TxtNombre.Text.Trim();
                cmd.Parameters.Add("@Precio", SqlDbType.Decimal).Value = Convert.ToDecimal(TxtPrecio.Text.Trim());
                cmd.Parameters.Add("@Ingredientes", SqlDbType.VarChar).Value = TxtIngredientes.Text.Trim();

                cmd.Connection = conn;
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void btnGuardar_Click1(object sender, EventArgs e)
        {
            pnlDatosReceta.Visible = true;
            pnlNuevaReceta.Visible = false;
            GuardarRecetas();
            CargarDatosReceta();
            limpiarDatos();
        }

        protected void lblEliminar_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string idReceta = btn.CommandArgument;
            EliminarReceta(idReceta);
            CargarDatosReceta();
        }

        public void EliminarReceta(string idReceta)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SPDReceta", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = Int64.Parse(idReceta);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void ActualizarReceta(int idReceta, string nombreDeProducto, decimal precio, string ingredientes)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SPUReceta", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = idReceta;
                cmd.Parameters.Add("@NombreDeProducto", SqlDbType.VarChar).Value = nombreDeProducto;
                cmd.Parameters.Add("@Precio", SqlDbType.Decimal).Value = precio;
                cmd.Parameters.Add("@Ingredientes", SqlDbType.VarChar).Value = ingredientes;
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvRecetas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Edit":
                    ShowEditControls(e.Item, true);
                    break;
                case "Update":
                    int recetaId = Convert.ToInt32(e.CommandArgument);
                    var txtNombreDeProducto = e.Item.FindControl("txtNombreDeProducto") as TextBox;
                    var txtPrecio = e.Item.FindControl("txtPrecio") as TextBox;
                    var txtIngredientes = e.Item.FindControl("txtIngredientes") as TextBox;

                    if (txtNombreDeProducto != null && txtPrecio != null && txtIngredientes != null)
                    {
                        string nombreDeProducto = txtNombreDeProducto.Text.Trim();
                        decimal precio = Convert.ToDecimal(txtPrecio.Text.Trim());
                        string ingredientes = txtIngredientes.Text.Trim();
                        ActualizarReceta(recetaId, nombreDeProducto, precio, ingredientes);
                        ShowEditControls(e.Item, false);
                        CargarDatosReceta();
                    }
                    else
                    {
                        throw new Exception("No se encontraron los controles de edición.");
                    }
                    break;
                case "Delete":
                    string idRecetaEliminar = e.CommandArgument.ToString();
                    EliminarReceta(idRecetaEliminar);
                    CargarDatosReceta();
                    break;
                case "Cancel":
                    ShowEditControls(e.Item, false);
                    CargarDatosReceta();
                    break;
            }
        }

        protected void ShowEditControls(RepeaterItem item, bool isEdit)
        {
            var litNombreDeProducto = item.FindControl("litNombreDeProducto") as Literal;
            var txtNombreDeProducto = item.FindControl("txtNombreDeProducto") as TextBox;
            var litPrecio = item.FindControl("litPrecio") as Literal;
            var txtPrecio = item.FindControl("txtPrecio") as TextBox;
            var litIngredientes = item.FindControl("litIngredientes") as Literal;
            var txtIngredientes = item.FindControl("txtIngredientes") as TextBox;

            var lblEditar = item.FindControl("lblEditar") as LinkButton;
            var lblActualizar = item.FindControl("lblActualizar") as LinkButton;
            var lblCancelar = item.FindControl("lblCancelar") as LinkButton;

            if (litNombreDeProducto != null)
                litNombreDeProducto.Visible = !isEdit;

            if (txtNombreDeProducto != null)
                txtNombreDeProducto.Visible = isEdit;

            if (litPrecio != null)
                litPrecio.Visible = !isEdit;

            if (txtPrecio != null)
                txtPrecio.Visible = isEdit;

            if (litIngredientes != null)
                litIngredientes.Visible = !isEdit;

            if (txtIngredientes != null)
                txtIngredientes.Visible = isEdit;

            if (lblEditar != null)
                lblEditar.Visible = !isEdit;

            if (lblActualizar != null)
                lblActualizar.Visible = isEdit;

            if (lblCancelar != null)
                lblCancelar.Visible = isEdit;
        }

        public void limpiarDatos()
        {
            TxtNombre.Text = string.Empty;
            TxtPrecio.Text = string.Empty;
            TxtIngredientes.Text = string.Empty;
        }
    }
}
