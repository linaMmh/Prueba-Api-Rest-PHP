<?php // DAL: Data Access Layer - Capa Acceso Datos
require_once 'Conexion.php';
require_once 'InterfaceAccesoDatos.php';

class AccesoDatos implements IAccesodatos
{
    private $cn = NULL; // Alias para la Conexion
    /*Consultar qué productos y qué cantidad puede ser alistada desde el inventario*/
    public function ObtenerListadoProductoInventario()
    {
        $cn = Conexion::ObtenerConexion();
        $ListaProductos = array();
        try
        {
            $rs = $cn->prepare("Select 
          pro.id as producto_id, 
          pro.descripcion as producto_descripcion,
          inv.cantidad as cantidad_inventario
          FROM inventario inv
          INNER JOIN producto pro on pro.id=inv.id_producto
          where pro.id in (select id_producto from inventario) 
          ORDER BY pro.descripcion ");

            $rs->execute();
            while ($fila = $rs->fetch(PDO::FETCH_ASSOC))
            {
                $ListaProductos['ProductosInventario'][] = $fila;
            }

            return $ListaProductos;
        }
        catch(Exception $ex)
        {
            echo $ex;
        }
    }

    /*Consultar los productos que deben ser alistados por transportadores, y a qué
     transportador le corresponde cada pedido*/
    public function ObtenerListadoProductoTransportador()
    {
        $cn = Conexion::ObtenerConexion();
        $ListaProductosTransportador = array();
        $datosTransportador = array();
        try
        {
            $rs = $cn->prepare("Select 
          p.id as pedido_id, 
          pro.id as producto_id, 
          pro.descripcion as producto_nombre,
          pd.cantidad as producto_cantidad,
          tr.id as transportador_id, 
          tr.nombre as transportador_nombre,
          if(pd.cantidad<=inv.cantidad, pd.cantidad, inv.cantidad) as cantidad_disponilbe
          from pedido p
          inner join pedido_detalle pd on p.id=pd.id_pedido 
          inner join inventario inv on inv.id_producto=pd.id_producto
          inner join transportador tr on p.id_transportador=tr.id
          inner join producto pro on pro.id=pd.id_producto 
          order by tr.nombre,p.id,p.prioridad");
            $id_ped = 0;
            $rs->execute();
            $p_trans = array();
            $productosTransportador = array();
            while ($fila = $rs->fetch(PDO::FETCH_ASSOC))
            {
                $pedido_id = $fila['pedido_id']; //6
                $id_trans = $fila['transportador_id']; //3
                $producto_id = $fila['producto_id'];
                $producto_nombre = $fila['producto_nombre'];
                $producto_cantidad = $fila['cantidad_disponilbe'];
                $transportador_nombre = $fila['transportador_nombre'];
                $transportador_id = $fila['transportador_id'];
                if ($id_ped != $pedido_id)
                {
                    // $p_trans["productos"]=$productosTransportador;
                    if ((!empty($productospedido)) && (!empty($p_pedido)))
                    {
                        $p_pedido["productos"] = $productospedido;
                        array_push($datosTransportador, $p_pedido);
                    }

                    //cremoas el array del pedido y de los productos
                    $p_pedido = array();
                    $productospedido = array();
                    $pro_tra = array();
                    $p_pedido["pedido_id"] = $pedido_id;
                    $p_pedido["transportador_id"] = $transportador_id;
                    $p_pedido["transportador_nombre"] = $transportador_nombre;

                    //productos
                    $pro_tra["producto_id"] = $producto_id;
                    $pro_tra["producto_nombre"] = $producto_nombre;
                    $pro_tra["producto_cantidad"] = $producto_cantidad;

                    //agregamos los productos al array
                    array_push($productospedido, $pro_tra);

                }
                else
                {
                    //llemanos los productos
                    $pro_tra = array();
                    $pro_tra["producto_id"] = $producto_id;
                    $pro_tra["producto_nombre"] = $producto_nombre;
                    $pro_tra["producto_cantidad"] = $producto_cantidad;
                    array_push($productospedido, $pro_tra);

                }
                $id_ped = $pedido_id;
            }
            $ListaProductosTransportador['ProductosTransportador'] = $datosTransportador;
            return $ListaProductosTransportador;
        }
        catch(Exception $ex)
        {
            echo $ex;
        }
    }

    /*Productos menos vendidos el día 1 de marzo*/
    public function ObtenerListadoProductosMenosVendidos($fecha)
    {
        $cn = Conexion::ObtenerConexion();
        $ListaProductosMenosVendidos = array();
        try
        {
            $rs = $cn->prepare("Select 
          pro.id as producto_id,
          pro.descripcion as producto_nombre,
          sum(pd.cantidad) as cantidad_vendida
          from pedido p
          inner join pedido_detalle pd on p.id=pd.id_pedido 
          inner join producto pro on pro.id=pd.id_producto
          where p.fecha_despacho BETWEEN :fecha_inicio AND :fecha_final
          group by pro.id,pro.descripcion
          order by sum(pd.cantidad) asc
          limit  15");
            $fecha_ini = $fecha . " 00:00:00";
            $fecha_fin = $fecha . " 23:59:59";
            $rs->bindParam(':fecha_inicio', $fecha_ini);
            $rs->bindParam(':fecha_final', $fecha_fin);
            $rs->execute();
            while ($fila = $rs->fetch(PDO::FETCH_ASSOC))
            {
                $ListaProductosMenosVendidos['ProductosMenosVendidos'][] = $fila;
            }

            return $ListaProductosMenosVendidos;
        }
        catch(Exception $ex)
        {
            echo $ex;
        }
    }

    /*Dado el Id de un pedido, saber qué productos y qué cantidad pueden ser alistados
     según sistema de inventario y cuáles deben ser abastecidos por los proveedores.*/
    public function ObtenerListadoPedidoProductos($id_pedido)
    {
        $cn = Conexion::ObtenerConexion();
        $ListadoPedidoProductos = array();
        $ProductosAlistar = array();
        $ProductosAbastecer = array();
        try
        {
            $rs = $cn->prepare("select pro.id as producto_id,
          pro.descripcion as producto_nombre,
          p.id pedido_id,
          p.direccion_entrega as direccion_pedido,
          p.prioridad as prioridad_pedido,
          inv.cantidad as cantidad_inventario,
          pd.cantidad as cantida_pedida,
          if(pd.cantidad<=inv.cantidad, pd.cantidad, inv.cantidad) as cantidad_disponilbe
          from pedido p
          inner join pedido_detalle pd on pd.id_pedido=p.id
          inner join inventario inv on inv.id_producto=pd.id_producto
          inner join producto pro on pro.id=pd.id_producto 
          where p.id=:id_pedido");

            $rs->bindParam(':id_pedido', $id_pedido);
            $rs->execute();
            while ($fila = $rs->fetch(PDO::FETCH_ASSOC))
            {
                $p_al = array();
                $p_ab = array();
                $cantidad_pedida = $fila['cantida_pedida'];
                $cantidad_inventario = $fila['cantidad_inventario'];
                $cantidad_disponilbe = $fila['cantidad_disponilbe'];
                $producto_id = $fila['producto_id'];
                $producto_nombre = $fila['producto_nombre'];
                $pedido_id = $fila['pedido_id'];
                $direccion_pedido = $fila['direccion_pedido'];
                $prioridad_pedido = $fila['prioridad_pedido'];
                $cantidad_abastecer = 0;
                $ListadoPedidoProductos['PedidoProductos']["pedido_id"] = $pedido_id;
                $ListadoPedidoProductos['PedidoProductos']["direccion_entrega"] = $direccion_pedido;
                $ListadoPedidoProductos['PedidoProductos']["prioridad_pedido"] = $prioridad_pedido;

                $p_al["producto_id"] = $producto_id;
                $p_al["producto_nombre"] = $producto_nombre;
                $p_al["cantidad_solicitada"] = $cantidad_pedida;
                $p_al["cantidad_alistar"] = $cantidad_disponilbe;
                array_push($ProductosAlistar, $p_al);

                if ($cantidad_pedida > $cantidad_disponilbe)
                {
                    $cantidad_abastecer = $cantidad_pedida - $cantidad_disponilbe;
                    $p_ab["producto_id"] = $producto_id;
                    $p_ab["producto_nombre"] = $producto_nombre;
                    $p_ab["cantidad_abastecer"] = $cantidad_abastecer;
                    array_push($ProductosAbastecer, $p_ab);
                }

            }
            $ListadoPedidoProductos['PedidoProductos']["ProductosAlistar"] = $ProductosAlistar;
            $ListadoPedidoProductos['PedidoProductos']["ProductosAbastecer"] = $ProductosAbastecer;
            // print_r($ListadoPedidoProductos);
            return $ListadoPedidoProductos;
        }
        catch(Exception $ex)
        {
            echo $ex;
        }
    }

    /*Calcular el inventario del día 2 de marzo, teniendo en cuenta las pedidos
     despachados el 1 de marzo*/
    public function ObtenerInventarioProductos()
    {
        $cn = Conexion::ObtenerConexion();
        $ListadoInventarioProductos = array();
        $ProductosInventario = array();
        // array_push($ProductosAlistar, $p_al);
        try
        {
            $rs = $cn->prepare("select pro.id as producto_id,pro.descripcion as producto_nombre,
          inv.cantidad as cantidad_inventario,
          sum(pd.cantidad) as cantida_pedida
          from pedido_detalle pd
          inner join inventario inv on inv.id_producto=pd.id_producto
          inner join producto pro on pro.id=pd.id_producto 
          group by pro.id,pro.descripcion
          order by pro.descripcion");

            $rs->execute();
            while ($fila = $rs->fetch(PDO::FETCH_ASSOC))
            {
                $p_inv = array();
                $cantidad_pedida = $fila['cantida_pedida'];
                $cantidad_inventario = $fila['cantidad_inventario'];
                $producto_id = $fila['producto_id'];
                $producto_nombre = $fila['producto_nombre'];
                $cantidad_abastecer = 0;
                $fecha = "2019-03-02";

                if ($cantidad_pedida > $cantidad_inventario)
                {
                    $cantidad_abastecer = $cantidad_pedida - $cantidad_inventario;
                    $p_inv["producto_id"] = $producto_id;
                    $p_inv["producto_nombre"] = $producto_nombre;
                    $p_inv["cantidad_abastecer"] = $cantidad_abastecer;
                    $p_inv["fecha"] = $fecha;

                    array_push($ProductosInventario, $p_inv);
                }

            }
            $ListadoInventarioProductos['Inventario'] = $ProductosInventario;
            return $ListadoInventarioProductos;
        }
        catch(Exception $ex)
        {
            echo $ex;
        }
    }

    /*Productos mas vendidos el día 1 de marzo*/
    public function ObtenerListadoProductosMasVendidos($fecha)
    {
        $cn = Conexion::ObtenerConexion();
        $ListaProductosMasVendidos = array();
        $ProductosCantidad = array();
        $ProductosOrden = array();
        try
        {
            $rs_cantidad = $cn->prepare("Select 
          pro.id as producto_id,
          pro.descripcion as producto_nombre,
          sum(pd.cantidad) as cantidad_ordenada
          from pedido p
          inner join pedido_detalle pd on p.id=pd.id_pedido 
          inner join producto pro on pro.id=pd.id_producto
          where p.fecha_despacho BETWEEN :fecha_inicio AND :fecha_final
          group by pro.id,pro.descripcion
          order by sum(pd.cantidad) desc
          limit  15");

            $rs_solicitado = $cn->prepare("Select 
          pro.id as producto_id,
          pro.descripcion as producto_nombre,
          count(pd.id_producto) numero_ordenes
          from pedido p
          inner join pedido_detalle pd on p.id=pd.id_pedido 
          inner join producto pro on pro.id=pd.id_producto
          where p.fecha_despacho BETWEEN :fecha_inicio AND :fecha_final
          group by pro.id,pro.descripcion
          order by numero_ordenes desc
          limit  15");
            $fecha_ini = $fecha . " 00:00:00";
            $fecha_fin = $fecha . " 23:59:59";
            $rs_cantidad->bindParam(':fecha_inicio', $fecha_ini);
            $rs_cantidad->bindParam(':fecha_final', $fecha_fin);
            $rs_cantidad->execute();

            $rs_solicitado->bindParam(':fecha_inicio', $fecha_ini);
            $rs_solicitado->bindParam(':fecha_final', $fecha_fin);
            $rs_solicitado->execute();
            //cantidad
            while ($fila_cant = $rs_cantidad->fetch(PDO::FETCH_ASSOC))
            {
                array_push($ProductosCantidad, $fila_cant);
            }

            //ordenados
            while ($fila_orden = $rs_solicitado->fetch(PDO::FETCH_ASSOC))
            {
                array_push($ProductosOrden, $fila_orden);
            }
            $ListaProductosMasVendidos['ProductosMasVendidos']['Cantidad'] = $ProductosCantidad;
            $ListaProductosMasVendidos['ProductosMasVendidos']['Solicitud'] = $ProductosOrden;

            return $ListaProductosMasVendidos;
        }
        catch(Exception $ex)
        {
            echo $ex;
        }
    }
}
?>
