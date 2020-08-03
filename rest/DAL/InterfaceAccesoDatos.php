<?php // Interface que expone todo lo que el DAL (Capa Acceso Datos) implementa

interface IAccesoDatos
{
    public function ObtenerListadoProductoInventario();
    public function ObtenerListadoProductoTransportador();
    public function ObtenerListadoProductosMenosVendidos($fecha);
    public function ObtenerListadoPedidoProductos($id_pedido);
    public function ObtenerInventarioProductos();
    public function ObtenerListadoProductosMasVendidos($fecha);
}