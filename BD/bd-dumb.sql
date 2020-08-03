-- MySQL dump 10.16  Distrib 10.2.16-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pedidos_merqueo
-- ------------------------------------------------------
-- Server version	10.2.16-MariaDB-10.2.16+maria~artful-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `id_producto` int(11) NOT NULL COMMENT 'id del producto para el inventario',
  `cantidad` bigint(20) NOT NULL COMMENT 'cantidad disponible del producto',
  `fecha_disponible` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fkInventarioProdcuto` (`id_producto`),
  CONSTRAINT `fkInventarioProdcuto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion del inventario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,3,'2019-03-01 00:00:00'),(2,2,3,'2019-03-01 00:00:00'),(3,3,7,'2019-03-01 00:00:00'),(4,4,8,'2019-03-01 00:00:00'),(5,5,10,'2019-03-01 00:00:00'),(6,6,15,'2019-03-01 00:00:00'),(7,7,26,'2019-03-01 00:00:00'),(8,8,11,'2019-03-01 00:00:00'),(9,9,1,'2019-03-01 00:00:00'),(10,10,8,'2019-03-01 00:00:00'),(11,11,7,'2019-03-01 00:00:00'),(12,12,8,'2019-03-01 00:00:00'),(13,13,2,'2019-03-01 00:00:00'),(14,14,1,'2019-03-01 00:00:00'),(15,15,1,'2019-03-01 00:00:00'),(16,16,9,'2019-03-01 00:00:00'),(17,17,17,'2019-03-01 00:00:00'),(18,18,8,'2019-03-01 00:00:00'),(19,19,9,'2019-03-01 00:00:00'),(20,20,9,'2019-03-01 00:00:00'),(21,21,3,'2019-03-01 00:00:00'),(22,22,6,'2019-03-01 00:00:00'),(23,23,9,'2019-03-01 00:00:00'),(24,24,9,'2019-03-01 00:00:00'),(25,25,10,'2019-03-01 00:00:00'),(26,26,40,'2019-03-01 00:00:00'),(27,27,2,'2019-03-01 00:00:00'),(28,28,3,'2019-03-01 00:00:00'),(29,29,2,'2019-03-01 00:00:00'),(30,30,1,'2019-03-01 00:00:00'),(31,31,9,'2019-03-01 00:00:00'),(32,32,10,'2019-03-01 00:00:00'),(33,33,2,'2019-03-01 00:00:00'),(34,34,3,'2019-03-01 00:00:00'),(35,35,6,'2019-03-01 00:00:00'),(36,36,6,'2019-03-01 00:00:00');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `prioridad` int(11) NOT NULL COMMENT 'prioridad del pedido',
  `direccion_entrega` text NOT NULL COMMENT 'Direccion de entrega del pedido',
  `fecha_despacho` datetime NOT NULL COMMENT 'la fecha en la que fue despachado el pedido',
  `fecha_entrega` datetime DEFAULT NULL COMMENT 'la fecha en en al que fue entregado el pedido',
  `id_usuario` int(11) NOT NULL COMMENT 'usuario al que se le entrega el pedido',
  `id_transportador` int(11) NOT NULL COMMENT 'Trasnportador encargado de entregar el pedido',
  PRIMARY KEY (`id`),
  KEY `fkPedidoUsuario` (`id_usuario`),
  KEY `fkPedidoTransportador` (`id_transportador`),
  CONSTRAINT `fkPedidoTransportador` FOREIGN KEY (`id_transportador`) REFERENCES `transportador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkPedidoUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion basica del pedido realizado';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,'KR 14 # 87 - 20','2019-03-01 00:00:00',NULL,1,4),(2,1,'KR 20 # 164A - 5','2019-03-01 00:00:00',NULL,2,3),(3,3,'KR 13 # 74 - 38','2019-03-01 00:00:00',NULL,3,2),(4,1,'CL 93 # 12 - 9','2019-03-01 00:00:00',NULL,4,5),(5,1,'CL 71 # 3 - 74','2019-03-01 00:00:00',NULL,5,3),(6,2,'KR 20 # 134A - 5','2019-03-01 00:00:00',NULL,6,4),(7,2,'CL 80 # 14 - 38','2019-03-01 00:00:00',NULL,7,2),(8,7,'KR 14 # 98 - 74','2019-03-01 00:00:00',NULL,8,4),(9,1,'KR 58 # 93 - 1','2019-03-01 00:00:00',NULL,9,1),(10,1,'CL 93B # 17 - 12','2019-03-01 00:00:00',NULL,10,5),(11,10,'KR 68D # 98A - 11','2019-03-01 00:00:00',NULL,11,3),(12,2,'AC 72 # 20 - 45','2019-03-01 00:00:00',NULL,12,5),(13,3,'KR 22 # 122 - 57','2019-03-01 00:00:00',NULL,13,3),(14,8,'KR 88 # 72A - 26','2019-03-01 00:00:00',NULL,14,2),(15,9,'KR 14 # 87 - 20','2019-03-01 00:00:00',NULL,1,4);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_detalle`
--

DROP TABLE IF EXISTS `pedido_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `id_pedido` int(11) NOT NULL COMMENT 'id del pedido',
  `id_producto` int(11) NOT NULL COMMENT 'id de los productos que pertenecen al pedido',
  `precio_unidad` double NOT NULL COMMENT 'prioridad del pedido',
  `cantidad` bigint(20) NOT NULL COMMENT 'Direccion de entrega del pedido',
  `total` double NOT NULL COMMENT 'multiplicacion de la cantidad de producto por su precio unitario',
  PRIMARY KEY (`id`),
  KEY `fkPedidoDetallePedido` (`id_pedido`),
  KEY `fkPedidoDetalleProducto` (`id_producto`),
  CONSTRAINT `fkPedidoDetallePedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkPedidoDetalleProducto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion del pedido con sus productos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_detalle`
--

LOCK TABLES `pedido_detalle` WRITE;
/*!40000 ALTER TABLE `pedido_detalle` DISABLE KEYS */;
INSERT INTO `pedido_detalle` VALUES (1,1,1,3880,1,3880),(2,1,2,5458,21,114618),(3,1,37,7652,7,53564),(4,1,3,7888,10,78880),(5,1,4,2482,5,12410),(6,2,5,4746,100,474600),(7,2,6,2286,60,137160),(8,3,7,7191,4,28764),(9,3,8,3098,3,9294),(10,3,9,3920,4,15680),(11,3,10,2304,8,18432),(12,3,11,3761,5,18805),(13,4,12,3892,3,11676),(14,4,13,6181,2,12362),(15,4,14,5226,4,20904),(16,4,15,5590,3,16770),(17,4,4,4271,2,8542),(18,5,16,2585,1500,3877500),(19,6,17,4115,2,8230),(20,6,18,4819,3,14457),(21,6,15,3752,2,7504),(22,6,19,2303,2,4606),(23,6,20,4260,3,12780),(24,7,21,6390,3,19170),(25,7,22,5173,2,10346),(26,7,23,4693,2,9386),(27,7,39,5945,4,23780),(28,7,24,7649,15,114735),(29,8,25,6410,3,19230),(30,8,26,7105,2,14210),(31,8,22,2294,4,9176),(32,8,27,6154,1,6154),(33,8,5,3890,1,3890),(34,9,22,4987,1,4987),(35,10,7,5266,1,5266),(36,11,41,3372,1,3372),(37,11,19,5060,6,30360),(38,11,29,7187,1,7187),(39,11,17,6753,1,6753),(40,11,30,4205,1,4205),(41,12,7,4767,1,4767),(42,12,25,3222,2,6444),(43,12,5,5807,1,5807),(44,12,31,5369,25,134225),(45,13,43,7425,1,7425),(46,13,30,7019,1,7019),(47,13,32,4820,1,4820),(48,13,33,7045,1,7045),(49,13,28,6766,2,13532),(50,14,16,4697,3,14091),(51,14,34,7184,3,21552),(52,14,35,7831,3,23493),(53,14,12,3601,1,3601),(54,14,36,4515,1,4515),(55,15,28,3773,1,3773);
/*!40000 ALTER TABLE `pedido_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `codigo` varchar(250) DEFAULT NULL COMMENT 'codigo del producto',
  `descripcion` text DEFAULT NULL COMMENT 'descripcion del producto',
  `precio_compra` double DEFAULT NULL COMMENT 'precio de compra del producto',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion basica del producto';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'000001','Leche',6641),(2,'000002','Huevos',7303),(3,'00003','Manzana Verde',2592),(4,'00004','Pepino Cohombro',7052),(5,'00005','Pimentón Rojo',7482),(6,'00006','Kiwi',2257),(7,'00007','Cebolla Cabezona Blanca Limpia',4840),(8,'00008','Habichuela',3427),(9,'00009','Mango Tommy Maduro',6615),(10,'00010','Tomate Chonto Pintón',2796),(11,'00011','Zanahoria Grande',4133),(12,'00012','ZAguacate Maduro',4281),(13,'00013','Kale o Col Rizada',7004),(14,'00014','Cebolla Cabezona Roja Limpia',2178),(15,'00015','Tomate Chonto Maduro',5877),(16,'00016','Acelga',2851),(17,'00017','Espinaca Bogotana x 500grs',6626),(18,'00018','Ahuyama',4579),(19,'00019','Cebolla Cabezona Blanca Sin Pelar',7016),(20,'00020','Melón',7343),(21,'00021','Cebolla Cabezona Blanca Sin Pelar',7669),(22,'00022','Cebolla Larga Junca x 500grs',2316),(23,'00023','Hierbabuena x 500grs',4575),(24,'00024','Lechuga Crespa Verde',7924),(25,'00025','Limón Tahití',5898),(26,'00026','Mora de Castilla',3720),(27,'00027','Pimentón Verde',4904),(28,'00028','Tomate Larga Vida Maduro',5359),(29,'00029','Cilantro x 500grs',4086),(30,'00030','Fresa Jugo',2353),(31,'00031','Papa R-12 Mediana',3509),(32,'00032','Curuba',2486),(33,'00033','Brócoli',5902),(34,'00034','Aguacate Hass Pintón',2055),(35,'00035','Aguacate Hass Maduro',2568),(36,'00036','Aguacate Pintón',4675),(37,'00037','Pan Bimbo',7673),(39,'00036','Lechuga Crespa Morada',4338),(41,'00041','Banano',2672),(43,'00043','Banano',4347);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `razon_social` varchar(250) NOT NULL COMMENT 'razon social del proveedor',
  `identificacion` varchar(250) DEFAULT NULL COMMENT 'nit del proveedor',
  `celular` varchar(250) DEFAULT NULL COMMENT 'celular del proveedor',
  `email` varchar(250) DEFAULT NULL COMMENT 'email del proveedor',
  `direccion` text DEFAULT NULL COMMENT 'direccion del proveedor',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion basica del proveedor';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Ruby','2776977','3881878618','Ruby@corre.com','calle 123'),(2,'Raul','985822','3251420140','Raul@corre.com','calle 123'),(3,'Angelica','1798178','4711464945','Angelica@corre.com','calle 123');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor_producto`
--

DROP TABLE IF EXISTS `proveedor_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor_producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `id_producto` int(11) NOT NULL COMMENT 'id del producto',
  `id_proveedor` int(11) NOT NULL COMMENT 'id del proveedor',
  PRIMARY KEY (`id`),
  KEY `fkProveedorProductoAdd` (`id_producto`),
  KEY `fkProveedorProveedorAdd` (`id_proveedor`),
  CONSTRAINT `fkProveedorProductoAdd` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkProveedorProveedorAdd` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion de los proveedores y los productos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor_producto`
--

LOCK TABLES `proveedor_producto` WRITE;
/*!40000 ALTER TABLE `proveedor_producto` DISABLE KEYS */;
INSERT INTO `proveedor_producto` VALUES (1,1,1),(2,2,1),(4,3,1),(5,4,1),(6,5,1),(8,25,1),(9,26,1),(10,27,1),(11,24,1),(12,28,2),(14,29,2),(15,30,2),(16,31,2),(17,32,2),(18,33,2),(19,34,2),(20,35,2),(21,36,2),(22,16,2),(23,17,2),(24,6,3),(25,7,3),(26,8,3),(27,9,3),(28,10,3),(29,11,3),(30,12,3),(31,13,3),(32,14,3),(33,15,3),(34,18,3),(35,19,3),(36,20,3),(37,21,3),(38,22,3),(39,23,3);
/*!40000 ALTER TABLE `proveedor_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportador`
--

DROP TABLE IF EXISTS `transportador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transportador` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `nombre` varchar(250) NOT NULL COMMENT 'nombre del transportador',
  `apellido` varchar(250) DEFAULT NULL COMMENT 'apellido del transportador',
  `cedula` varchar(250) DEFAULT NULL COMMENT 'cedula del transportador',
  `celular` varchar(250) DEFAULT NULL COMMENT 'celular del transportador',
  `direccion` text NOT NULL COMMENT 'direccion del transportador',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion basica del transportador';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportador`
--

LOCK TABLES `transportador` WRITE;
/*!40000 ALTER TABLE `transportador` DISABLE KEYS */;
INSERT INTO `transportador` VALUES (1,'Raul','Hernandez','1994943','5918181189','calle 456 -78'),(2,'Angel','Linares','2360897','5338383345','calle 67 -78'),(3,'Saul','Perez','1019656','5837373259','calle 56 -78'),(4,'Laura','Fernandez','1215589','3671716356','calle 78 -88'),(5,'Alexander','rodriguez','2218977','4146462104','calle 45 -66');
/*!40000 ALTER TABLE `transportador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria para la estructura',
  `nombre` varchar(250) NOT NULL COMMENT 'nombre del usuario',
  `apellido` varchar(250) DEFAULT NULL COMMENT 'apellido del usuario',
  `cedula` varchar(250) DEFAULT NULL COMMENT 'cedula del usuario',
  `celular` varchar(250) DEFAULT NULL COMMENT 'celular del usuario',
  `email` varchar(250) DEFAULT NULL COMMENT 'email del usuario',
  `direccion` text NOT NULL COMMENT 'direccion del usuario',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Sencilla tabla para informacion basica del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Sofia','Castro','2239897','4311684758','soa@sofia.com','KR 14 # 87 - 20'),(2,'Angel','Linares','1351555','3872908399','angel@correo.com','KR 20 # 164A - 5'),(3,'Hocks','','1238086','3329487818','Hocks@correo.com','KR 13 # 74 - 38'),(4,'Michael','Fernandez','1335763','5128713994','Michael@correo.com','CL 93 # 12 - 9'),(5,'Bar de Alex','Fernandez','2164560','6155106612','bar@correo.com','CL 71 # 3 - 74'),(6,'Sabor Criollo','','2015509','5889391180','sabor@correo.com','KR 20 # 134A - 5'),(7,'El Pollo Rojo','','2783866','4681636162','pollo@correo.com','CL 80 # 14 - 38'),(8,'All Salad','','1072804','5840007367','salad@correo.com','KR 14 # 98 - 74'),(9,'Parrilla y sabor','','2212425','5655128448','parrilla@correo.com','KR 58 # 93 - 1'),(10,'restaurante yerbabuena','','1043710','4455620239','yerbabuena@correo.com','CL 93B # 17 - 12'),(11,'Luis David','Herrera','1781277','5412715949','luis@correo.com','KR 68D # 98A - 11'),(12,'David','Carruyo','975255','4196719128','David@correo.com','AC 72 # 20 - 45'),(13,'Mario','suarez','2732446','4845447893','mario@correo.com','KR 22 # 122 - 57'),(14,'Harold','gomez','1936465','5337082179','Harold@correo.com','KR 88 # 72A - 26');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-03 16:24:35
