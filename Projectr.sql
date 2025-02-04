-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: colegiosanviator
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `dniAlumno` varchar(9) NOT NULL,
  `nombreAlumno` varchar(40) DEFAULT NULL,
  `apellidosAlumno` varchar(70) DEFAULT NULL,
  `edadAlumno` int DEFAULT NULL,
  PRIMARY KEY (`dniAlumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumnoempresa`
--

DROP TABLE IF EXISTS `alumnoempresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnoempresa` (
  `dniAlumno` varchar(9) NOT NULL,
  `ciclo` varchar(3) DEFAULT NULL,
  `empresa` varchar(100) DEFAULT NULL,
  `nota` int DEFAULT NULL,
  `convocatoria` int DEFAULT NULL,
  PRIMARY KEY (`dniAlumno`),
  KEY `dniAlumno` (`dniAlumno`,`ciclo`),
  CONSTRAINT `alumnoempresa_ibfk_1` FOREIGN KEY (`dniAlumno`, `ciclo`) REFERENCES `matricula` (`dniAlumno`, `ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumnomodulo`
--

DROP TABLE IF EXISTS `alumnomodulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnomodulo` (
  `dni` varchar(9) NOT NULL,
  `modulos` int DEFAULT NULL,
  `aprobados` int DEFAULT NULL,
  `curso` int DEFAULT NULL,
  `ciclo` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`dni`),
  KEY `ciclo` (`ciclo`),
  CONSTRAINT `alumnomodulo_ibfk_1` FOREIGN KEY (`dni`) REFERENCES `alumno` (`dniAlumno`),
  CONSTRAINT `alumnomodulo_ibfk_2` FOREIGN KEY (`ciclo`) REFERENCES `ciclo` (`abreviaturaCiclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `proyectoPracticas` AFTER UPDATE ON `alumnomodulo` FOR EACH ROW begin
declare total int;
declare notaPractica int;
declare notaProyecto int;
declare convocatoria int;
declare alumno int;
set alumno=(select count(*) from alumnoproyecto where dnialumno=new.dni);
set total = (select sum(modulos) from alumnomodulo where new.ciclo=ciclo and curso=2 and new.dni=dni);
set notaProyecto=floor(rand()*11);
set notaPractica=floor(rand()*11);
if(new.curso=2 and (total-new.aprobados=2) and alumno=0) then
set convocatoria = floor(rand()*2)+1;
insert into alumnoProyecto values(new.dni, new.ciclo, null,notaProyecto,convocatoria);
insert into alumnoEmpresa values(new.dni, new.ciclo, null,notaPractica,convocatoria);
if(notaProyecto>=5 and notaPractica>=5) then
call alumnosEgresados(new.dni,convocatoria);
end if;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alumnoproyecto`
--

DROP TABLE IF EXISTS `alumnoproyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnoproyecto` (
  `dniAlumno` varchar(9) NOT NULL,
  `ciclo` varchar(3) DEFAULT NULL,
  `tema` varchar(100) DEFAULT NULL,
  `nota` int DEFAULT NULL,
  `convocatoria` int DEFAULT NULL,
  PRIMARY KEY (`dniAlumno`),
  KEY `dniAlumno` (`dniAlumno`,`ciclo`),
  CONSTRAINT `alumnoproyecto_ibfk_1` FOREIGN KEY (`dniAlumno`, `ciclo`) REFERENCES `matricula` (`dniAlumno`, `ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumnosegresados`
--

DROP TABLE IF EXISTS `alumnosegresados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnosegresados` (
  `dni` varchar(9) NOT NULL,
  `fechaPromocion` date DEFAULT NULL,
  `curso` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`dni`),
  CONSTRAINT `alumnosegresados_ibfk_1` FOREIGN KEY (`dni`) REFERENCES `matricula` (`dniAlumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `alumnosfaltasenasignaturas`
--

DROP TABLE IF EXISTS `alumnosfaltasenasignaturas`;
/*!50001 DROP VIEW IF EXISTS `alumnosfaltasenasignaturas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `alumnosfaltasenasignaturas` AS SELECT 
 1 AS `numAsiganturas`,
 1 AS `dniAlumno`,
 1 AS `nombreAlumno`,
 1 AS `apellidosAlumno`,
 1 AS `edadAlumno`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ciclo`
--

DROP TABLE IF EXISTS `ciclo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclo` (
  `abreviaturaCiclo` varchar(3) NOT NULL,
  `nombreCiclo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`abreviaturaCiclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `egresadosporcurso`
--

DROP TABLE IF EXISTS `egresadosporcurso`;
/*!50001 DROP VIEW IF EXISTS `egresadosporcurso`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `egresadosporcurso` AS SELECT 
 1 AS `numAlumnos`,
 1 AS `curso`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `faltas`
--

DROP TABLE IF EXISTS `faltas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faltas` (
  `dni` varchar(9) NOT NULL,
  `ciclo` varchar(3) NOT NULL,
  `modulo` varchar(3) NOT NULL,
  `fecha` date NOT NULL,
  `numFaltas` int DEFAULT NULL,
  `evaluacion` int NOT NULL,
  PRIMARY KEY (`dni`,`ciclo`,`modulo`,`fecha`,`evaluacion`),
  KEY `ciclo` (`ciclo`,`modulo`),
  CONSTRAINT `faltas_ibfk_1` FOREIGN KEY (`dni`) REFERENCES `alumno` (`dniAlumno`),
  CONSTRAINT `faltas_ibfk_2` FOREIGN KEY (`ciclo`, `modulo`) REFERENCES `matricula` (`ciclo`, `modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `notaBoletin2` BEFORE UPDATE ON `faltas` FOR EACH ROW begin
declare nota int;
declare faltas int;
set faltas=faltas(new.dni,new.ciclo,new.modulo,new.evaluacion);
if(faltas+new.numfaltas>10) then
set nota=(select sum(valor)/count(valor) from nota where new.dni=dniAlumno and tiponota='examen' and new.modulo=modulo and new.ciclo=ciclo and new.evaluacion=evaluacion);
update notasboletin
set valor= nota where new.dni=dniAlumno and new.modulo=modulo and new.ciclo=ciclo and new.evaluacion=evaluacion;
call valortextual(1);
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `horasprofesor`
--

DROP TABLE IF EXISTS `horasprofesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horasprofesor` (
  `dniProfesor` varchar(9) NOT NULL,
  `horas` int DEFAULT NULL,
  PRIMARY KEY (`dniProfesor`),
  CONSTRAINT `horasprofesor_ibfk_1` FOREIGN KEY (`dniProfesor`) REFERENCES `profesor` (`dniProfesor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `losfaltones`
--

DROP TABLE IF EXISTS `losfaltones`;
/*!50001 DROP VIEW IF EXISTS `losfaltones`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `losfaltones` AS SELECT 
 1 AS `dniAlumno`,
 1 AS `nombreAlumno`,
 1 AS `apellidosAlumno`,
 1 AS `edadAlumno`,
 1 AS `faltas`,
 1 AS `valor`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `matricula`
--

DROP TABLE IF EXISTS `matricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matricula` (
  `dniAlumno` varchar(9) NOT NULL,
  `ciclo` varchar(3) NOT NULL,
  `modulo` varchar(3) NOT NULL,
  `curso` int NOT NULL,
  `fechaMatriculacion` date DEFAULT NULL,
  PRIMARY KEY (`dniAlumno`,`ciclo`,`modulo`,`curso`),
  KEY `ciclo` (`ciclo`,`modulo`,`curso`),
  CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`dniAlumno`) REFERENCES `alumno` (`dniAlumno`),
  CONSTRAINT `matricula_ibfk_2` FOREIGN KEY (`ciclo`, `modulo`, `curso`) REFERENCES `modulo` (`ciclo`, `abreviaturaModulo`, `curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `notaFinal` BEFORE INSERT ON `matricula` FOR EACH ROW begin
if(new.modulo!='PFG' and new.modulo!='PE') then
insert into notaFinal values (new.dnialumno,new.ciclo,new.modulo,null,null);
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `alumnoModulo` AFTER INSERT ON `matricula` FOR EACH ROW begin
declare asignaturas int;
set asignaturas= (select count(*) from matricula where matricula.dnialumno=new.dnialumno);
if(asignaturas=1) then 
insert into alumnomodulo values (new.dnialumno,0,0,new.curso,new.ciclo);
else
update alumnoModulo 
set alumnomodulo.modulos= asignaturas where dni=new.dnialumno;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `mediadelasasignaturascompartidas`
--

DROP TABLE IF EXISTS `mediadelasasignaturascompartidas`;
/*!50001 DROP VIEW IF EXISTS `mediadelasasignaturascompartidas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mediadelasasignaturascompartidas` AS SELECT 
 1 AS `media`,
 1 AS `ciclo`,
 1 AS `modulo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `mejoresestudiantes`
--

DROP TABLE IF EXISTS `mejoresestudiantes`;
/*!50001 DROP VIEW IF EXISTS `mejoresestudiantes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mejoresestudiantes` AS SELECT 
 1 AS `media`,
 1 AS `dniAlumno`,
 1 AS `nombreAlumno`,
 1 AS `apellidosAlumno`,
 1 AS `edadAlumno`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulo` (
  `ciclo` varchar(3) NOT NULL,
  `abreviaturaModulo` varchar(3) NOT NULL,
  `nombreModulo` varchar(200) DEFAULT NULL,
  `curso` int NOT NULL,
  `horasSemana` int DEFAULT NULL,
  `dniProfesor` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`ciclo`,`abreviaturaModulo`,`curso`),
  KEY `dniProfesor` (`dniProfesor`),
  CONSTRAINT `modulo_ibfk_1` FOREIGN KEY (`ciclo`) REFERENCES `ciclo` (`abreviaturaCiclo`),
  CONSTRAINT `modulo_ibfk_2` FOREIGN KEY (`dniProfesor`) REFERENCES `profesor` (`dniProfesor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insercionModulo` BEFORE INSERT ON `modulo` FOR EACH ROW begin
if((select sum(horas)from horasprofesor where dniprofesor=new.dniprofesor)+new.horasSemana>25) then
set new.dniprofesor= null;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizarHoras` AFTER INSERT ON `modulo` FOR EACH ROW begin
call calcularHoras(new.dniprofesor);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `moduloslibres`
--

DROP TABLE IF EXISTS `moduloslibres`;
/*!50001 DROP VIEW IF EXISTS `moduloslibres`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `moduloslibres` AS SELECT 
 1 AS `ciclo`,
 1 AS `abreviaturaModulo`,
 1 AS `nombreModulo`,
 1 AS `curso`,
 1 AS `horasSemana`,
 1 AS `dniProfesor`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `modulosmassuspendidos`
--

DROP TABLE IF EXISTS `modulosmassuspendidos`;
/*!50001 DROP VIEW IF EXISTS `modulosmassuspendidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `modulosmassuspendidos` AS SELECT 
 1 AS `numSuspensos`,
 1 AS `nombreciclo`,
 1 AS `nombremodulo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `modulosprofesores`
--

DROP TABLE IF EXISTS `modulosprofesores`;
/*!50001 DROP VIEW IF EXISTS `modulosprofesores`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `modulosprofesores` AS SELECT 
 1 AS `dniProfesor`,
 1 AS `ciclo`,
 1 AS `abreviaturaModulo`,
 1 AS `nombreModulo`,
 1 AS `curso`,
 1 AS `horasSemana`,
 1 AS `nombreProfesor`,
 1 AS `apellidosProfesor`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `nota`
--

DROP TABLE IF EXISTS `nota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota` (
  `dniAlumno` varchar(9) NOT NULL,
  `ciclo` varchar(3) NOT NULL,
  `modulo` varchar(3) NOT NULL,
  `valor` double DEFAULT NULL,
  `curso` int DEFAULT NULL,
  `evaluacion` int NOT NULL,
  `tipoNota` varchar(20) NOT NULL,
  PRIMARY KEY (`dniAlumno`,`ciclo`,`modulo`,`evaluacion`,`tipoNota`),
  KEY `ciclo` (`ciclo`,`modulo`,`curso`),
  CONSTRAINT `nota_ibfk_1` FOREIGN KEY (`dniAlumno`) REFERENCES `alumno` (`dniAlumno`),
  CONSTRAINT `nota_ibfk_2` FOREIGN KEY (`ciclo`, `modulo`, `curso`) REFERENCES `modulo` (`ciclo`, `abreviaturaModulo`, `curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `notaBoletin` AFTER INSERT ON `nota` FOR EACH ROW begin
declare nota int;
declare faltas int;
set faltas= faltas(new.dniAlumno, new.ciclo,new.modulo,new.evaluacion);
if(faltas<10) then
set nota=(select sum(0.5*valor)/count(valor) from nota where new.dniAlumno=dniAlumno and tiponota='examen' and new.modulo=modulo and new.ciclo=ciclo and new.evaluacion=evaluacion) + (select sum(valor*0.5)/count(valor) from nota where dnialumno=new.dniAlumno and tiponota='practica' and new.modulo=modulo and new.ciclo=ciclo and new.evaluacion=evaluacion);
update notasBoletin
set valor= nota where new.dniAlumno=dniAlumno and new.modulo=modulo and new.ciclo=ciclo and new.evaluacion=evaluacion;
call valorTextual(1);
else
set nota=(select sum(valor)/count(valor) from nota where new.dniAlumno=dniAlumno and tiponota='examen' and new.modulo=modulo and new.ciclo=ciclo and new.evaluacion=evaluacion);
update notasBoletin
set valor= nota where new.dniAlumno=dniAlumno and new.modulo=modulo and new.ciclo=ciclo and new.evaluacion=evaluacion;
call valorTextual(1);
end if;
if(new.evaluacion=4) then
insert into notasboletin
values (new.dnialumno,new.ciclo,new.modulo,new.valor,new.evaluacion,null);
call valortextual(1);
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notafinal`
--

DROP TABLE IF EXISTS `notafinal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notafinal` (
  `dniAlumno` varchar(9) NOT NULL,
  `ciclo` varchar(3) NOT NULL,
  `modulo` varchar(3) NOT NULL,
  `valor` int DEFAULT NULL,
  `valorTextual` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`dniAlumno`,`ciclo`,`modulo`),
  KEY `ciclo` (`ciclo`,`modulo`),
  CONSTRAINT `notafinal_ibfk_1` FOREIGN KEY (`dniAlumno`) REFERENCES `alumno` (`dniAlumno`),
  CONSTRAINT `notafinal_ibfk_2` FOREIGN KEY (`ciclo`, `modulo`) REFERENCES `modulo` (`ciclo`, `abreviaturaModulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `alumnoAprobado` AFTER UPDATE ON `notafinal` FOR EACH ROW begin
update alumnoModulo
set aprobados =(select count(*) from notafinal where dnialumno=new.dnialumno and valor>4) where dni=new.dnialumno;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `notamediamodulo`
--

DROP TABLE IF EXISTS `notamediamodulo`;
/*!50001 DROP VIEW IF EXISTS `notamediamodulo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `notamediamodulo` AS SELECT 
 1 AS `ciclo`,
 1 AS `modulo`,
 1 AS `media`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `notasboletin`
--

DROP TABLE IF EXISTS `notasboletin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notasboletin` (
  `dniAlumno` varchar(9) NOT NULL,
  `ciclo` varchar(3) NOT NULL,
  `modulo` varchar(3) NOT NULL,
  `valor` int DEFAULT NULL,
  `evaluacion` int NOT NULL,
  `valorTextual` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`dniAlumno`,`ciclo`,`modulo`,`evaluacion`),
  KEY `ciclo` (`ciclo`,`modulo`),
  CONSTRAINT `notasboletin_ibfk_1` FOREIGN KEY (`dniAlumno`) REFERENCES `alumno` (`dniAlumno`),
  CONSTRAINT `notasboletin_ibfk_2` FOREIGN KEY (`ciclo`, `modulo`) REFERENCES `modulo` (`ciclo`, `abreviaturaModulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertarNotaFinal` AFTER INSERT ON `notasboletin` FOR EACH ROW begin
declare evaluaciones int;
declare nota int;
set evaluaciones= contarEvaluaciones(new.dnialumno,new.ciclo,new.modulo);
if(evaluaciones=4) then
select valor into nota from notasboletin where new.dnialumno=dnialumno and evaluacion=4 and ciclo=new.ciclo and modulo=new.modulo;
update notafinal set valor=nota where dnialumno=new.dnialumno and ciclo=new.ciclo and modulo=new.modulo;
call valorTextual(2);
elseif(evaluaciones=3) then
update notafinal set valor=(select avg(valor) from notasboletin where dnialumno=new.dnialumno and ciclo=new.ciclo and modulo=new.modulo) where dnialumno=new.dnialumno and ciclo=new.ciclo and modulo=new.modulo;
call valorTextual(2);
else
update notafinal set valor=(select avg(valor) from notasboletin where dnialumno=new.dnialumno and ciclo=new.ciclo and modulo=new.modulo) where dnialumno=new.dnialumno and ciclo=new.ciclo and modulo=new.modulo;
call valorTextual(2);
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `dniProfesor` varchar(9) NOT NULL,
  `nombreProfesor` varchar(40) DEFAULT NULL,
  `apellidosProfesor` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`dniProfesor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `horasProfesor` AFTER INSERT ON `profesor` FOR EACH ROW begin
declare horas int;
insert into horasprofesor values(new.dniprofesor, null);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `profesoreshoras`
--

DROP TABLE IF EXISTS `profesoreshoras`;
/*!50001 DROP VIEW IF EXISTS `profesoreshoras`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `profesoreshoras` AS SELECT 
 1 AS `dniProfesor`,
 1 AS `horas`,
 1 AS `nombreProfesor`,
 1 AS `apellidosProfesor`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'colegiosanviator'
--

--
-- Dumping routines for database 'colegiosanviator'
--
/*!50003 DROP FUNCTION IF EXISTS `contarEvaluaciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `contarEvaluaciones`(dni varchar(9),ciclo varchar(3),modulo varchar(3)) RETURNS int
begin
declare evaluaciones int;
select count(*) into evaluaciones from notasboletin where dnialumno=dni and notasboletin.modulo=modulo and notasboletin.ciclo=ciclo;
return evaluaciones;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `faltas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `faltas`(dni varchar(9), ciclo varchar(3),modulo varchar(3),evaluacion int) RETURNS int
begin 
declare total int;
select count(*) into total from faltas where faltas.dni=dni and faltas.ciclo=ciclo and faltas.modulo=modulo and faltas.evaluacion=evaluacion;
return total;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `alumnosEgresados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `alumnosEgresados`(dni varchar(9),convocatoria int)
begin
declare fecha year;
declare alumno int; 
set alumno= (select count(*) from alumnosegresados where alumnosegresados.dni=dni);
set fecha=(select year(fechamatriculacion) from matricula where dnialumno=dni limit 1);
if(alumno=0) then 
if(convocatoria=1) then
insert into alumnosegresados values (dni,concat(fecha,'-08-31'),concat(fecha,'/',fecha+1));
else
insert into alumnosegresados values (dni,concat(fecha,'-09-01'),concat(fecha+1,'/',fecha+2));
end if;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calcularHoras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcularHoras`(dni varchar(9))
begin 
declare horas int;
select sum(horasSemana) into horas from modulo where dniProfesor=dni;
update horasprofesor set horasprofesor.horas=horas where dniprofesor=dni;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `notaFinalProyectoEmpresa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `notaFinalProyectoEmpresa`()
begin
insert into notaFinal (dnialumno,ciclo,modulo,valor) select dnialumno, ciclo,'PE', nota from alumnoempresa;
insert into notaFinal (dnialumno,ciclo,modulo,valor) select dnialumno, ciclo,'PFG', nota from alumnoproyecto;
call valorTextual(2);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `valorTextual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `valorTextual`(num int)
begin 
if(num=1) then
update notasboletin set valortextual ='INSUFICIENTE' where valor<5;
update notasboletin set valortextual ='SUFICIENTE' where valor=5 or valor=6;
update notasboletin set valortextual ='NOTABLE' where valor=7 or valor=8;
update notasboletin set valortextual ='SOBRESALIENTE' where valor=9;
update notasboletin set valortextual ='MATRICULA DE HONOR' where valor=10;
else 
update notafinal set valortextual ='INSUFICIENTE' where valor<5;
update notafinal set valortextual ='SUFICIENTE' where valor=5 or valor=6;
update notafinal set valortextual ='NOTABLE' where valor=7 or valor=8;
update notafinal set valortextual ='SOBRESALIENTE' where valor=9;
update notafinal set valortextual ='MATRICULA DE HONOR' where valor=10;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `alumnosfaltasenasignaturas`
--

/*!50001 DROP VIEW IF EXISTS `alumnosfaltasenasignaturas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `alumnosfaltasenasignaturas` AS select count(0) AS `numAsiganturas`,`alumno`.`dniAlumno` AS `dniAlumno`,`alumno`.`nombreAlumno` AS `nombreAlumno`,`alumno`.`apellidosAlumno` AS `apellidosAlumno`,`alumno`.`edadAlumno` AS `edadAlumno` from ((select sum(`faltas`.`numFaltas`) AS `faltas`,`faltas`.`dni` AS `dni`,`faltas`.`modulo` AS `modulo`,`faltas`.`ciclo` AS `ciclo` from `faltas` group by `faltas`.`dni`,`faltas`.`ciclo`,`faltas`.`modulo` having (`faltas` > 10)) `tabla1` join `alumno` on((`alumno`.`dniAlumno` = `tabla1`.`dni`))) group by `tabla1`.`dni` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `egresadosporcurso`
--

/*!50001 DROP VIEW IF EXISTS `egresadosporcurso`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `egresadosporcurso` AS select count(0) AS `numAlumnos`,`alumnosegresados`.`curso` AS `curso` from `alumnosegresados` group by `alumnosegresados`.`curso` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `losfaltones`
--

/*!50001 DROP VIEW IF EXISTS `losfaltones`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `losfaltones` AS select `alumno`.`dniAlumno` AS `dniAlumno`,`alumno`.`nombreAlumno` AS `nombreAlumno`,`alumno`.`apellidosAlumno` AS `apellidosAlumno`,`alumno`.`edadAlumno` AS `edadAlumno`,sum(`faltas`.`numFaltas`) AS `faltas`,`notasboletin`.`valor` AS `valor` from ((`alumno` join `notasboletin` on((`alumno`.`dniAlumno` = `notasboletin`.`dniAlumno`))) join `faltas` on(((`faltas`.`dni` = `alumno`.`dniAlumno`) and (`faltas`.`dni` = `notasboletin`.`dniAlumno`) and (`faltas`.`ciclo` = `notasboletin`.`ciclo`) and (`faltas`.`modulo` = `notasboletin`.`modulo`) and (`faltas`.`evaluacion` = `notasboletin`.`evaluacion`)))) group by `faltas`.`dni`,`faltas`.`evaluacion`,`faltas`.`ciclo`,`faltas`.`modulo` having (`faltas` > 10) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mediadelasasignaturascompartidas`
--

/*!50001 DROP VIEW IF EXISTS `mediadelasasignaturascompartidas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mediadelasasignaturascompartidas` AS select avg(`notafinal`.`valor`) AS `media`,`notafinal`.`ciclo` AS `ciclo`,`notafinal`.`modulo` AS `modulo` from `notafinal` where ((`notafinal`.`modulo` = 'FOL') or (`notafinal`.`modulo` = 'EIE')) group by `notafinal`.`ciclo`,`notafinal`.`modulo` order by `notafinal`.`modulo`,`media` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mejoresestudiantes`
--

/*!50001 DROP VIEW IF EXISTS `mejoresestudiantes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mejoresestudiantes` AS select avg(`notafinal`.`valor`) AS `media`,`alumno`.`dniAlumno` AS `dniAlumno`,`alumno`.`nombreAlumno` AS `nombreAlumno`,`alumno`.`apellidosAlumno` AS `apellidosAlumno`,`alumno`.`edadAlumno` AS `edadAlumno` from ((`alumno` join `notafinal`) join (select distinct `matricula`.`dniAlumno` AS `dnialumno` from `matricula` where (`matricula`.`curso` = 1)) `tabla1`) where ((`alumno`.`dniAlumno` = `tabla1`.`dnialumno`) and (`notafinal`.`dniAlumno` = `tabla1`.`dnialumno`)) group by `notafinal`.`dniAlumno` order by `media` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `moduloslibres`
--

/*!50001 DROP VIEW IF EXISTS `moduloslibres`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `moduloslibres` AS select `modulo`.`ciclo` AS `ciclo`,`modulo`.`abreviaturaModulo` AS `abreviaturaModulo`,`modulo`.`nombreModulo` AS `nombreModulo`,`modulo`.`curso` AS `curso`,`modulo`.`horasSemana` AS `horasSemana`,`modulo`.`dniProfesor` AS `dniProfesor` from `modulo` where (`modulo`.`dniProfesor` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `modulosmassuspendidos`
--

/*!50001 DROP VIEW IF EXISTS `modulosmassuspendidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `modulosmassuspendidos` AS select count(0) AS `numSuspensos`,`ciclo`.`nombreCiclo` AS `nombreciclo`,`modulo`.`nombreModulo` AS `nombremodulo` from ((`notafinal` join `ciclo`) join `modulo`) where ((`notafinal`.`valor` < 5) and (`ciclo`.`abreviaturaCiclo` = `notafinal`.`ciclo`) and (`modulo`.`abreviaturaModulo` = `notafinal`.`modulo`) and (`modulo`.`ciclo` = `ciclo`.`abreviaturaCiclo`)) group by `ciclo`.`nombreCiclo`,`modulo`.`nombreModulo` order by `numSuspensos` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `modulosprofesores`
--

/*!50001 DROP VIEW IF EXISTS `modulosprofesores`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `modulosprofesores` AS select `modulo`.`dniProfesor` AS `dniProfesor`,`modulo`.`ciclo` AS `ciclo`,`modulo`.`abreviaturaModulo` AS `abreviaturaModulo`,`modulo`.`nombreModulo` AS `nombreModulo`,`modulo`.`curso` AS `curso`,`modulo`.`horasSemana` AS `horasSemana`,`profesor`.`nombreProfesor` AS `nombreProfesor`,`profesor`.`apellidosProfesor` AS `apellidosProfesor` from (`modulo` join `profesor` on((`modulo`.`dniProfesor` = `profesor`.`dniProfesor`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `notamediamodulo`
--

/*!50001 DROP VIEW IF EXISTS `notamediamodulo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `notamediamodulo` AS select `notafinal`.`ciclo` AS `ciclo`,`notafinal`.`modulo` AS `modulo`,avg(`notafinal`.`valor`) AS `media` from `notafinal` group by `notafinal`.`ciclo`,`notafinal`.`modulo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `profesoreshoras`
--

/*!50001 DROP VIEW IF EXISTS `profesoreshoras`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `profesoreshoras` AS select `horasprofesor`.`dniProfesor` AS `dniProfesor`,`horasprofesor`.`horas` AS `horas`,`profesor`.`nombreProfesor` AS `nombreProfesor`,`profesor`.`apellidosProfesor` AS `apellidosProfesor` from (`horasprofesor` join `profesor` on((`horasprofesor`.`dniProfesor` = `profesor`.`dniProfesor`))) order by `horasprofesor`.`horas` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-01 16:54:32
