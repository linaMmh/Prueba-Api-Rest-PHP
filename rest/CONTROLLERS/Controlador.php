<?php // Este es el Controlador Manager general de todo el sistema. Todo tiene que pasar por esta clase
require_once 'DAL/AccesoDatos.php';
class Controlador {
    protected $iaccesoDatos;
    public function __construct() {
        $this->iaccesoDatos = new AccesoDatos();
    }
    public function ObtenerListadoProductoInventario() {
        return $this->iaccesoDatos->ObtenerListadoProductoInventario();
    }
    public function ObtenerListadoProductoTransportador() {
        return $this->iaccesoDatos->ObtenerListadoProductoTransportador();
    }
    public function ObtenerListadoProductosMenosVendidos($fecha) {
        //validamos el formato de la fecha
        $date_regex = '/^(19|20)\d\d[\-\/.](0[1-9]|1[012])[\-\/.](0[1-9]|[12][0-9]|3[01])$/';
        if (!preg_match($date_regex, $fecha)) {
            return $this->response(422, "Error", "El formato de la fecha debe ser YYYY-MM-DD");
        } else {
            return $this->iaccesoDatos->ObtenerListadoProductosMenosVendidos($fecha);
        }
    }
    public function ObtenerListadoPedidoProductos($id_pedido) {
        if (is_numeric($id_pedido)) {
            return $this->iaccesoDatos->ObtenerListadoPedidoProductos($id_pedido);
        } else {
            return $this->response(422, "Error", "El id pedido debe ser un numero");
        }
    }
    public function ObtenerInventarioProductos() {
        return $this->iaccesoDatos->ObtenerInventarioProductos();
    }
    public function ObtenerListadoProductosMasVendidos($fecha) {

        //validamos el formato de la fecha
        $date_regex = '/^(19|20)\d\d[\-\/.](0[1-9]|1[012])[\-\/.](0[1-9]|[12][0-9]|3[01])$/';
        if (!preg_match($date_regex, $fecha)) {
            return $this->response(422, "Error", "El formato de la fecha debe ser YYYY-MM-DD");
        } else {
            return $this->iaccesoDatos->ObtenerListadoProductosMasVendidos($fecha);
        }
    }
    function response($code = 200, $status = "", $message = "") {
        http_response_code($code);
        if (!empty($status) && !empty($message)) {
            $response = array("status" => $status, "message" => $message);
            return $response;
        }
    }
}

?>