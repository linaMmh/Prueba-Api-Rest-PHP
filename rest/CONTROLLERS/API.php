<?php // Este es el servicio Rest como tal, quien recibe las peticiones desde el exterior
require_once 'Controlador.php';

class APIMerqueo
{

    public function __construct()
    {
    }

    public function API()
    {
        header('Content-Type: application/JSON');
        $method = $_SERVER['REQUEST_METHOD'];
        switch ($method)
        {
            case 'GET':
                if (isset($_GET['action']))
                {
                    if ($_GET['action'] == 'ListadoProductoInventario')
                    {
                        $this->ObtenerListadoProductoInventario();
                    }
                    else if ($_GET['action'] == 'ListadoProductoTransportador')
                    {
                        $this->ObtenerListadoProductoTransportador();
                    }
                    else if ($_GET['action'] == 'ListadoProductosMenosVendidos')
                    {
                        if (isset($_GET['fecha']))
                        {
                            $fecha = $_GET['fecha'];
                            $this->ObtenerListadoProductosMenosVendidos($fecha);
                        }
                        else
                        {
                            $this->response(422, "Error", "No hay fecha para listar");
                        }

                    }
                    else if ($_GET['action'] == 'ListadoPedidoProductos')
                    {
                        if (isset($_GET['id_pedido']))
                        {
                            $id_pedido = $_GET['id_pedido'];
                            $this->ObtenerListadoPedidoProductos($id_pedido);
                        }
                        else
                        {
                            $this->response(422, "Error", "No hay id de pedido para listar");
                        }

                    }
                    else if ($_GET['action'] == 'InventarioProductos')
                    {
                        $this->ObtenerInventarioProductos();
                    }
                    else if ($_GET['action'] == 'ListadoProductosMasVendidos')
                    {
                        if (isset($_GET['fecha']))
                        {
                            $fecha = $_GET['fecha'];
                            $this->ObtenerListadoProductosMasVendidos($fecha);
                        }
                        else
                        {
                            $this->response(422, "Error", "No hay fecha para listar");
                        }

                    }else{
                      $this->response(400, "Error", "Accion no Encontrada");
                    }
                }else{
                  $this->response(400, "Error", "Accion no Encontrada");
                }
                break;
            case 'POST':
                echo 'Metodo No Valido';
                break;
            case 'PUT':
                echo 'Metodo No Valido';
                break;
            case 'DELETE':
                echo 'Metodo No Valido';
                break;
            default:
                echo 'Metodo No Valido';
                break;
            }
        }

        function ObtenerListadoProductoInventario()
        {
            $controlador = new Controlador();
            $response = $controlador->ObtenerListadoProductoInventario();
            echo json_encode($response, JSON_PRETTY_PRINT);
        }

        function ObtenerListadoProductoTransportador()
        {
            $controlador = new Controlador();
            $response = $controlador->ObtenerListadoProductoTransportador();
            echo json_encode($response, JSON_PRETTY_PRINT);
        }

        function ObtenerListadoProductosMenosVendidos($fecha)
        {
            $controlador = new Controlador();
            $response = $controlador->ObtenerListadoProductosMenosVendidos($fecha);
            echo json_encode($response, JSON_PRETTY_PRINT);
        }

        function ObtenerListadoPedidoProductos($id_pedido)
        {
            $controlador = new Controlador();
            $response = $controlador->ObtenerListadoPedidoProductos($id_pedido);
            echo json_encode($response, JSON_PRETTY_PRINT);
        }
        function ObtenerInventarioProductos()
        {
            $controlador = new Controlador();
            $response = $controlador->ObtenerInventarioProductos();
            echo json_encode($response, JSON_PRETTY_PRINT);
        }

        function ObtenerListadoProductosMasVendidos($fecha)
        {
            $controlador = new Controlador();
            $response = $controlador->ObtenerListadoProductosMasVendidos($fecha);
            echo json_encode($response, JSON_PRETTY_PRINT);

        }

        function response($code = 200, $status = "", $message = "")
        {
            http_response_code($code);
            if (!empty($status) && !empty($message))
            {
                $response = array(
                    "status" => $status,
                    "message" => $message
                );
                echo json_encode($response, JSON_PRETTY_PRINT);
            }
        }
    }
    
