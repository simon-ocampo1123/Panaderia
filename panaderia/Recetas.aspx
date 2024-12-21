<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Recetas.aspx.cs" Inherits="panaderia.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Recetas</title>
</head>
<body>
    <style>
        .navbar-red {
            background-color: red;
        }
    </style>
    <nav class="navbar navbar-red">
        <div class="container">
            <a class="navbar-brand" href="#">
                  <p src="" alt="" width="30" height="24">
            </a>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center">Los Mejores Postres y Panes en Medellín</h1>
        <p class="text-center">Hay muchos postres y panes que me gustan en MEDELLÍN; pero estos adoro recomendarlos por experiencia y gusto personal. Definitivamente son LOS MEJORES!</p>
    </div>
    <div class="container">
        <div class="row">
            <div class="col">
                <form id="form1" runat="server">
                    <asp:Panel ID="pnlNuevaReceta" runat="server" Visible="false">
                        <asp:Label ID="LblNuevo" runat="server" Text="Formulario de registro" CssClass="h3 text-center text-danger mb-4" Visible="false"></asp:Label>

                        <div class="container">
                            <div class="row">
                                <div class="col-md-6 mx-auto">
                                    <div class="card">
                                        <div class="card-header bg-danger text-white">
                                            <h5 class="card-title mb-0" id="formTitle">Registrar Nueva Receta</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="mb-3">
                                                <asp:Label ID="lblNombreProducto" runat="server" class="form-label text-danger" Text="Nombre del producto:" AssociatedControlID="TxtNombre"></asp:Label>
                                                <asp:TextBox ID="TxtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="mb-3">
                                                <asp:Label ID="lblPrecio" runat="server" class="form-label text-danger" Text="Precio Del Producto:" AssociatedControlID="TxtPrecio"></asp:Label>
                                                <asp:TextBox ID="TxtPrecio" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="mb-3">
                                                <asp:Label ID="lblIngrediente" runat="server" Text="Ingredientes:" AssociatedControlID="TxtIngredientes" CssClass="form-label text-danger"></asp:Label>
                                                <asp:TextBox ID="TxtIngredientes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                                            </div>
                                            <div class="mb-3">
                                                <asp:Label ID="lblidReceta" runat="server" Visible="false"></asp:Label>
                                            </div>
                                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-danger btn-block" OnClick="btnGuardar_Click1" />
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlDatosReceta" runat="server" Visible="true">
                        <br />
                        <div class="container">
                            <div class="row">
                                <!-- Repeater para mostrar las recetas -->
<asp:Repeater ID="gvRecetas" runat="server" OnItemCommand="gvRecetas_ItemCommand">
    <ItemTemplate>
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
                <img class="card-img-top" src="https://w7.pngwing.com/pngs/450/256/png-transparent-bakery-logo.png" alt="Imagen de la receta">
                <div class="card-body">
                    <h1 class="card-title">
                        <asp:Literal ID="litNombreDeProducto" runat="server" Text='<%# Eval("NombreDeProducto") %>' Visible="true" />
                        <asp:TextBox ID="txtNombreDeProducto" runat="server" Text='<%# Eval("NombreDeProducto") %>' Visible="false" CssClass="form-control" />
                    </h1>
                    <p class="card-text">
                        Precio:
                        <asp:Literal ID="litPrecio" runat="server" Text='<%# Eval("Precio", "{0:C}") %>' Visible="true" />
                        <asp:TextBox ID="txtPrecio" runat="server" Text='<%# Eval("Precio") %>' Visible="false" CssClass="form-control" />
                    </p>
                    <p class="card-text">
                        Ingredientes:
                        <asp:Literal ID="litIngredientes" runat="server" Text='<%# Eval("Ingredientes") %>' Visible="true" />
                        <asp:TextBox ID="txtIngredientes" runat="server" Text='<%# Eval("Ingredientes") %>' Visible="false" CssClass="form-control" />
                    </p>
                    <p class="card-text">
                        Fecha de Creación: <%# Eval("Fecha") %>
                    </p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <asp:HiddenField ID="hfIdReceta" runat="server" Value='<%# Eval("Id") %>' />
                            <asp:LinkButton ID="lblEditar" runat="server" Text="Editar" CommandName="Edit" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary" />
                            <asp:LinkButton ID="lblActualizar" runat="server" Text="Actualizar" CommandName="Update" CommandArgument='<%# Eval("Id") %>' Visible="false" CssClass="btn btn-sm btn-outline-primary" />
                            <asp:LinkButton ID="lblCancelar" runat="server" Text="🗙" CommandName="Cancel" CommandArgument='<%# Eval("Id") %>' Visible="false" CssClass="btn btn-sm btn-outline-secondary" />
                        </div>
                        <div class="btn-group">
                        
                            <asp:LinkButton ID="lblEliminar" runat="server" Text="Eliminar" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClick="lblEliminar_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
                            </div>
                            <asp:Button ID="btnNueva" runat="server" Text="Nueva Receta" class="btn btn-sm btn-outline-danger" OnClick="btnNuevo_Click1" />
                        </div>
                    </asp:Panel>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXlI/8S+gtqUJMR3sA4fdgE9pnkgd6R6PaYjFFSjHXBdHU6e7IwEl2x7M4lf" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGhei2I3r6DciFro1y6ABUR6GM3QYme0Hg89HcRS5f5q5paXtkKf6gHp0YG" crossorigin="anonymous"></script>
</body>
</html>
