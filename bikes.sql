-- MySQL dump 10.13  Distrib 8.0.17, for Linux (x86_64)
--
-- Host:     Database: bikeInfo
-- ------------------------------------------------------
-- Server version	5.7.22-log

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
-- Table structure for table `dynamicData`
--

DROP TABLE IF EXISTS `dynamicData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dynamicData` (
  `name` varchar(45) DEFAULT NULL,
  `avail_bike_stands` int(11) DEFAULT NULL,
  `bike_stands` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `number` int(11) NOT NULL,
  `avail_bikes` int(11) DEFAULT NULL,
  PRIMARY KEY (`last_update`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dynamicData`
--

LOCK TABLES `dynamicData` WRITE;
/*!40000 ALTER TABLE `dynamicData` DISABLE KEYS */;
INSERT INTO `dynamicData` VALUES ('ROYAL HOSPITAL',39,40,'OPEN','2019-09-05 15:27:06',95,1),('NEWMAN HOUSE',19,40,'OPEN','2019-09-05 15:27:15',53,21),('JOHN STREET WEST',31,31,'OPEN','2019-09-05 15:27:28',72,0),('GRANGEGORMAN LOWER (CENTRAL)',37,40,'OPEN','2019-09-05 15:27:30',104,3),('MERRION SQUARE EAST',5,30,'OPEN','2019-09-05 15:27:51',25,25),('MOUNT BROWN',22,22,'OPEN','2019-09-05 15:28:03',82,0),('ST. JAMES HOSPITAL (CENTRAL)',40,40,'OPEN','2019-09-05 15:28:07',81,0),('LEINSTER STREET SOUTH',7,30,'OPEN','2019-09-05 15:28:08',21,21),('SOUTH DOCK ROAD',5,30,'OPEN','2019-09-05 15:28:09',91,25),('OLIVER BOND STREET',26,30,'OPEN','2019-09-05 15:28:19',74,4),('HANOVER QUAY',4,40,'OPEN','2019-09-05 15:28:30',68,35),('PHIBSBOROUGH ROAD',37,40,'OPEN','2019-09-05 15:28:52',110,3),('MARKET STREET SOUTH',34,38,'OPEN','2019-09-05 15:28:55',76,4),('FITZWILLIAM SQUARE WEST',1,30,'OPEN','2019-09-05 15:29:12',13,29),('SANDWITH STREET',1,40,'OPEN','2019-09-05 15:29:12',64,38),('AVONDALE ROAD',35,40,'OPEN','2019-09-05 15:29:57',108,5),('CUSTOM HOUSE',10,30,'OPEN','2019-09-05 15:30:05',23,20),('KILMAINHAM LANE',30,30,'OPEN','2019-09-05 15:30:14',96,0),('KING STREET NORTH',30,30,'OPEN','2019-09-05 15:30:16',101,0),('HIGH STREET',29,29,'OPEN','2019-09-05 15:30:17',7,0),('RATHDOWN ROAD',39,40,'OPEN','2019-09-05 15:30:20',106,1),('WILTON TERRACE',17,20,'OPEN','2019-09-05 15:30:25',39,3),('KILMAINHAM GAOL',39,40,'OPEN','2019-09-05 15:30:28',97,1),('EXCISE WALK',12,40,'OPEN','2019-09-05 15:30:33',48,27),('HARDWICKE PLACE',14,25,'OPEN','2019-09-05 15:30:47',61,11),('GRANGEGORMAN LOWER (NORTH)',36,36,'OPEN','2019-09-05 15:30:54',105,0),('CUSTOM HOUSE QUAY',22,30,'OPEN','2019-09-05 15:31:18',8,8),('EMMET ROAD',33,40,'OPEN','2019-09-05 15:31:29',83,7),('MATER HOSPITAL',38,40,'OPEN','2019-09-05 15:31:41',78,2),('MERRION SQUARE WEST',5,20,'OPEN','2019-09-05 15:31:59',26,15),('GRATTAN STREET',1,23,'OPEN','2019-09-05 15:32:17',57,22),('GOLDEN LANE',18,20,'OPEN','2019-09-05 15:32:24',17,2),('DENMARK STREET GREAT',18,20,'OPEN','2019-09-05 15:32:25',59,2),('CONVENTION CENTRE',17,40,'OPEN','2019-09-05 15:32:25',65,23),('CLONMEL STREET',25,33,'OPEN','2019-09-05 15:32:28',54,8),('NEW CENTRAL BANK',8,40,'OPEN','2019-09-05 15:32:29',66,31),('TOWNSEND STREET',18,20,'OPEN','2019-09-05 15:32:30',22,2),('GREEK STREET',17,20,'OPEN','2019-09-05 15:32:37',4,3),('PORTOBELLO HARBOUR',27,30,'OPEN','2019-09-05 15:32:38',34,3),('THE POINT',2,40,'OPEN','2019-09-05 15:32:46',67,38),('HEUSTON BRIDGE (NORTH)',35,40,'OPEN','2019-09-05 15:32:47',92,5),('MOUNTJOY SQUARE EAST',40,40,'OPEN','2019-09-05 15:32:52',111,0),('UPPER SHERRARD STREET',30,30,'OPEN','2019-09-05 15:32:54',44,0),('ROTHE ABBEY',25,35,'OPEN','2019-09-05 15:32:55',85,10),('PEARSE STREET',20,30,'OPEN','2019-09-05 15:33:04',32,10),('HEUSTON STATION (CENTRAL)',40,40,'OPEN','2019-09-05 15:33:08',93,0),('BROOKFIELD ROAD',27,30,'OPEN','2019-09-05 15:33:19',84,3),('BENSON STREET',3,40,'OPEN','2019-09-05 15:33:35',90,35),('NORTH CIRCULAR ROAD (O\'CONNELL\'S)',30,30,'OPEN','2019-09-05 15:33:40',112,0),('GRANGEGORMAN LOWER (SOUTH)',33,40,'OPEN','2019-09-05 15:33:45',103,7),('GEORGES LANE',34,40,'OPEN','2019-09-05 15:33:47',50,6),('NORTH CIRCULAR ROAD',24,30,'OPEN','2019-09-05 15:33:47',60,1),('ST JAMES HOSPITAL (LUAS)',22,40,'OPEN','2019-09-05 15:33:48',80,18),('CHARLEMONT PLACE',34,40,'OPEN','2019-09-05 15:33:56',5,6),('ST. STEPHEN\'S GREEN SOUTH',4,30,'OPEN','2019-09-05 15:33:59',37,26),('PARNELL SQUARE NORTH',5,20,'OPEN','2019-09-05 15:34:06',30,15),('PORTOBELLO ROAD',28,30,'OPEN','2019-09-05 15:34:10',43,2),('HEUSTON BRIDGE (SOUTH)',21,25,'OPEN','2019-09-05 15:34:10',100,4),('ST. STEPHEN\'S GREEN EAST',9,40,'OPEN','2019-09-05 15:34:18',36,32),('DAME STREET',11,16,'OPEN','2019-09-05 15:34:21',10,5),('ECCLES STREET',20,20,'OPEN','2019-09-05 15:34:22',12,0),('SMITHFIELD NORTH',15,30,'OPEN','2019-09-05 15:34:23',42,15),('HERBERT STREET',4,40,'OPEN','2019-09-05 15:34:37',47,36),('PARNELL STREET',19,20,'OPEN','2019-09-05 15:34:41',31,1),('FRANCIS STREET',30,30,'OPEN','2019-09-05 15:34:41',73,0),('FITZWILLIAM SQUARE EAST',8,40,'OPEN','2019-09-05 15:34:49',89,32),('BLACKHALL PLACE',27,30,'OPEN','2019-09-05 15:34:53',88,3),('KILLARNEY STREET',25,30,'OPEN','2019-09-05 15:34:56',115,5),('ECCLES STREET EAST',21,27,'OPEN','2019-09-05 15:34:57',79,6),('BLESSINGTON STREET',20,20,'OPEN','2019-09-05 15:34:58',2,0),('WILTON TERRACE (PARK)',6,40,'OPEN','2019-09-05 15:34:59',114,34),('JERVIS STREET',16,21,'OPEN','2019-09-05 15:35:00',40,5),('SIR PATRICK DUN\'S',3,40,'OPEN','2019-09-05 15:35:01',58,37),('SMITHFIELD',0,30,'CLOSED','2019-09-05 15:35:05',35,0),('EARLSFORT TERRACE',10,30,'OPEN','2019-09-05 15:35:07',11,20),('ORMOND QUAY UPPER',18,29,'OPEN','2019-09-05 15:35:08',29,11),('CITY QUAY',3,30,'OPEN','2019-09-05 15:35:08',99,27),('HARCOURT TERRACE',6,20,'OPEN','2019-09-05 15:35:11',41,14),('FENIAN STREET',11,35,'OPEN','2019-09-05 15:35:11',63,24),('BOLTON STREET',19,20,'OPEN','2019-09-05 15:35:17',3,1),('BUCKINGHAM STREET LOWER',21,29,'OPEN','2019-09-05 15:35:17',109,8),('FREDERICK STREET SOUTH',11,40,'OPEN','2019-09-05 15:35:33',98,29),('CHARLEVILLE ROAD',38,40,'OPEN','2019-09-05 15:35:34',107,2),('GRANTHAM STREET',27,30,'OPEN','2019-09-05 15:35:51',18,3),('MERRION SQUARE SOUTH',9,40,'OPEN','2019-09-05 15:35:51',113,31),('YORK STREET WEST',19,40,'OPEN','2019-09-05 15:35:57',51,21),('GEORGES QUAY',10,20,'OPEN','2019-09-05 15:35:58',16,10),('EXCHEQUER STREET',9,24,'OPEN','2019-09-05 15:36:00',9,15),('MOUNTJOY SQUARE WEST',14,30,'OPEN','2019-09-05 15:36:04',28,16),('COLLINS BARRACKS MUSEUM',36,38,'OPEN','2019-09-05 15:36:04',87,2),('TALBOT STREET',30,40,'OPEN','2019-09-05 15:36:05',38,10),('PARKGATE STREET',35,38,'OPEN','2019-09-05 15:36:06',86,3),('MOLESWORTH STREET',4,20,'OPEN','2019-09-05 15:36:09',27,16),('HARDWICKE STREET',11,16,'OPEN','2019-09-05 15:36:14',15,5),('MOUNT STREET LOWER',11,40,'OPEN','2019-09-05 15:36:23',56,28),('JAMES STREET',37,40,'OPEN','2019-09-05 15:36:25',75,3),('HEUSTON STATION (CAR PARK)',39,40,'OPEN','2019-09-05 15:36:26',94,1),('PRINCES STREET / O\'CONNELL STREET',13,23,'OPEN','2019-09-05 15:36:29',33,10),('FOWNES STREET UPPER',23,30,'OPEN','2019-09-05 15:36:36',14,7),('GUILD STREET',16,40,'OPEN','2019-09-05 15:36:37',49,23),('LIME STREET',7,40,'OPEN','2019-09-05 15:36:42',62,31),('YORK STREET EAST',15,32,'OPEN','2019-09-05 15:36:44',52,17),('DEVERELL PLACE',26,30,'OPEN','2019-09-05 15:36:45',45,4),('HATCH STREET',19,36,'OPEN','2019-09-05 15:36:47',55,17),('WOLFE TONE STREET',29,29,'OPEN','2019-09-05 15:36:47',77,0),('KEVIN STREET',32,40,'OPEN','2019-09-05 15:36:48',71,8),('CHRISTCHURCH PLACE',19,20,'OPEN','2019-09-05 15:36:56',6,1),('WESTERN WAY',37,40,'OPEN','2019-09-05 15:36:58',102,3),('CATHAL BRUGHA STREET',14,20,'OPEN','2019-09-05 15:37:04',24,6),('GRAND CANAL DOCK',0,40,'OPEN','2019-09-05 15:37:05',69,39),('HERBERT PLACE',1,30,'OPEN','2019-09-05 15:37:06',19,29);
/*!40000 ALTER TABLE `dynamicData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `latestInfo`
--

DROP TABLE IF EXISTS `latestInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `latestInfo` (
  `avail_bikes` int(11) DEFAULT NULL,
  `avail_bike_stands` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `last_update` varchar(45) DEFAULT NULL,
  `number` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `latitude` varchar(45) DEFAULT NULL,
  `longitude` varchar(45) DEFAULT NULL,
  `banking` int(11) DEFAULT NULL,
  `bike_stands` int(11) DEFAULT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `latestInfo`
--

LOCK TABLES `latestInfo` WRITE;
/*!40000 ALTER TABLE `latestInfo` DISABLE KEYS */;
INSERT INTO `latestInfo` VALUES (0,'20','OPEN','2019-09-05 15:34:58',2,'BLESSINGTON STREET','Blessington Street','53.356769','-6.26814',1,20),(1,'19','OPEN','2019-09-05 15:35:17',3,'BOLTON STREET','Bolton Street','53.351182','-6.269859',0,20),(3,'17','OPEN','2019-09-05 15:32:37',4,'GREEK STREET','Greek Street','53.346874','-6.272976',0,20),(6,'34','OPEN','2019-09-05 15:33:56',5,'CHARLEMONT PLACE','Charlemont Street','53.330662','-6.260177',0,40),(1,'19','OPEN','2019-09-05 15:36:56',6,'CHRISTCHURCH PLACE','Christchurch Place','53.343368','-6.27012',0,20),(0,'29','OPEN','2019-09-05 15:30:17',7,'HIGH STREET','High Street','53.343565','-6.275071',1,29),(8,'22','OPEN','2019-09-05 15:31:18',8,'CUSTOM HOUSE QUAY','Custom House Quay','53.347884','-6.248048',0,30),(15,'9','OPEN','2019-09-05 15:36:00',9,'EXCHEQUER STREET','Exchequer Street','53.343034','-6.263578',0,24),(5,'11','OPEN','2019-09-05 15:34:21',10,'DAME STREET','Dame Street','53.344007','-6.266802',1,16),(20,'10','OPEN','2019-09-05 15:35:07',11,'EARLSFORT TERRACE','Earlsfort Terrace','53.334019','-6.258371',0,30),(0,'20','OPEN','2019-09-05 15:34:22',12,'ECCLES STREET','Eccles Street','53.359246','-6.269779',0,20),(29,'1','OPEN','2019-09-05 15:29:12',13,'FITZWILLIAM SQUARE WEST','Fitzwilliam Square West','53.336074','-6.252825',0,30),(7,'23','OPEN','2019-09-05 15:36:36',14,'FOWNES STREET UPPER','Fownes Street Upper','53.344603','-6.263371',0,30),(5,'11','OPEN','2019-09-05 15:36:14',15,'HARDWICKE STREET','Hardwicke Street','53.355473','-6.264423',0,16),(10,'10','OPEN','2019-09-05 15:35:58',16,'GEORGES QUAY','Georges Quay','53.347508','-6.252192',0,20),(2,'18','OPEN','2019-09-05 15:32:24',17,'GOLDEN LANE','Golden Lane','53.340803','-6.267732',0,20),(3,'27','OPEN','2019-09-05 15:35:51',18,'GRANTHAM STREET','Grantham Street','53.334123','-6.265436',1,30),(29,'1','OPEN','2019-09-05 15:37:06',19,'HERBERT PLACE','Herbert Place','53.334432','-6.245575',0,30),(21,'7','OPEN','2019-09-05 15:28:08',21,'LEINSTER STREET SOUTH','Leinster Street South','53.34218','-6.254485',0,30),(2,'18','OPEN','2019-09-05 15:32:30',22,'TOWNSEND STREET','Townsend Street','53.345922','-6.254614',0,20),(20,'10','OPEN','2019-09-05 15:30:05',23,'CUSTOM HOUSE','Custom House','53.348279','-6.254662',1,30),(6,'14','OPEN','2019-09-05 15:37:04',24,'CATHAL BRUGHA STREET','Cathal Brugha Street','53.352149','-6.260533',0,20),(25,'5','OPEN','2019-09-05 15:27:51',25,'MERRION SQUARE EAST','Merrion Square East','53.339434','-6.246548',0,30),(15,'5','OPEN','2019-09-05 15:31:59',26,'MERRION SQUARE WEST','Merrion Square West','53.339764','-6.251988',1,20),(16,'4','OPEN','2019-09-05 15:36:09',27,'MOLESWORTH STREET','Molesworth Street','53.341288','-6.258117',0,20),(16,'14','OPEN','2019-09-05 15:36:04',28,'MOUNTJOY SQUARE WEST','Mountjoy Square West','53.356299','-6.258586',0,30),(11,'18','OPEN','2019-09-05 15:35:08',29,'ORMOND QUAY UPPER','Ormond Quay Upper','53.346057','-6.268001',1,29),(15,'5','OPEN','2019-09-05 15:34:06',30,'PARNELL SQUARE NORTH','Parnell Square North','53.353462','-6.265305',1,20),(1,'19','OPEN','2019-09-05 15:34:41',31,'PARNELL STREET','Parnell Street','53.350929','-6.265125',0,20),(10,'20','OPEN','2019-09-05 15:33:04',32,'PEARSE STREET','Pearse Street','53.344304','-6.250427',1,30),(10,'13','OPEN','2019-09-05 15:36:29',33,'PRINCES STREET / O\'CONNELL STREET','Princes Street / O\'Connell Street','53.349013','-6.260311',1,23),(3,'27','OPEN','2019-09-05 15:32:38',34,'PORTOBELLO HARBOUR','Portobello Harbour','53.330362','-6.265163',0,30),(0,'0','CLOSED','2019-09-05 15:35:05',35,'SMITHFIELD','Smithfield','53.347692','-6.278214',0,30),(32,'9','OPEN','2019-09-05 15:34:18',36,'ST. STEPHEN\'S GREEN EAST','St. Stephen\'s Green East','53.337824','-6.256035',1,40),(26,'4','OPEN','2019-09-05 15:33:59',37,'ST. STEPHEN\'S GREEN SOUTH','St. Stephen\'s Green South','53.337494','-6.26199',1,30),(10,'30','OPEN','2019-09-05 15:36:05',38,'TALBOT STREET','Talbot Street','53.350974','-6.25294',0,40),(3,'17','OPEN','2019-09-05 15:30:25',39,'WILTON TERRACE','Wilton Terrace','53.332383','-6.252717',1,20),(5,'16','OPEN','2019-09-05 15:35:00',40,'JERVIS STREET','Jervis Street','53.3483','-6.266651',1,21),(14,'6','OPEN','2019-09-05 15:35:11',41,'HARCOURT TERRACE','Harcourt Terrace','53.332763','-6.257942',0,20),(15,'15','OPEN','2019-09-05 15:34:23',42,'SMITHFIELD NORTH','Smithfield North','53.349562','-6.278198',1,30),(2,'28','OPEN','2019-09-05 15:34:10',43,'PORTOBELLO ROAD','Portobello Road','53.330091','-6.268044',1,30),(0,'30','OPEN','2019-09-05 15:32:54',44,'UPPER SHERRARD STREET','Upper Sherrard Street','53.358437','-6.260641',0,30),(4,'26','OPEN','2019-09-05 15:36:45',45,'DEVERELL PLACE','Deverell Place','53.351464','-6.255265',0,30),(36,'4','OPEN','2019-09-05 15:34:37',47,'HERBERT STREET','Herbert Street','53.335742','-6.24551',0,40),(27,'12','OPEN','2019-09-05 15:30:33',48,'EXCISE WALK','Excise Walk','53.347777','-6.244239',0,40),(23,'16','OPEN','2019-09-05 15:36:37',49,'GUILD STREET','Guild Street','53.347932','-6.240928',0,40),(6,'34','OPEN','2019-09-05 15:33:47',50,'GEORGES LANE','George\'s Lane','53.35023','-6.279696',0,40),(21,'19','OPEN','2019-09-05 15:35:57',51,'YORK STREET WEST','York Street West','53.339334','-6.264699',0,40),(17,'15','OPEN','2019-09-05 15:36:44',52,'YORK STREET EAST','York Street East','53.338755','-6.262003',0,32),(21,'19','OPEN','2019-09-05 15:27:15',53,'NEWMAN HOUSE','Newman House','53.337132','-6.26059',0,40),(8,'25','OPEN','2019-09-05 15:32:28',54,'CLONMEL STREET','Clonmel Street','53.336021','-6.26298',0,33),(17,'19','OPEN','2019-09-05 15:36:47',55,'HATCH STREET','Hatch Street','53.33403','-6.260714',0,36),(28,'11','OPEN','2019-09-05 15:36:23',56,'MOUNT STREET LOWER','Mount Street Lower','53.33796','-6.24153',0,40),(22,'1','OPEN','2019-09-05 15:32:17',57,'GRATTAN STREET','Grattan Street','53.339629','-6.243778',0,23),(37,'3','OPEN','2019-09-05 15:35:01',58,'SIR PATRICK DUN\'S','Sir Patrick\'s Dun','53.339218','-6.240642',1,40),(2,'18','OPEN','2019-09-05 15:32:25',59,'DENMARK STREET GREAT','Denmark Street Great','53.35561','-6.261397',0,20),(1,'24','OPEN','2019-09-05 15:33:47',60,'NORTH CIRCULAR ROAD','North Circular Road','53.359624','-6.260348',0,30),(11,'14','OPEN','2019-09-05 15:30:47',61,'HARDWICKE PLACE','Hardwicke Place','53.357043','-6.263232',1,25),(31,'7','OPEN','2019-09-05 15:36:42',62,'LIME STREET','Lime Street','53.346026','-6.243576',0,40),(24,'11','OPEN','2019-09-05 15:35:11',63,'FENIAN STREET','Fenian Street','53.341428','-6.24672',0,35),(38,'1','OPEN','2019-09-05 15:29:12',64,'SANDWITH STREET','Sandwith Street','53.345203','-6.247163',1,40),(23,'17','OPEN','2019-09-05 15:32:25',65,'CONVENTION CENTRE','Convention Centre','53.34744','-6.238523',1,40),(31,'8','OPEN','2019-09-05 15:32:29',66,'NEW CENTRAL BANK','New Central Bank','53.347122','-6.234749',0,40),(38,'2','OPEN','2019-09-05 15:32:46',67,'THE POINT','The Point','53.346867','-6.230852',0,40),(35,'4','OPEN','2019-09-05 15:28:30',68,'HANOVER QUAY','Hanover Quay','53.344115','-6.237153',1,40),(39,'0','OPEN','2019-09-05 15:37:05',69,'GRAND CANAL DOCK','Grand Canal Dock','53.342638','-6.238695',0,40),(8,'32','OPEN','2019-09-05 15:36:48',71,'KEVIN STREET','Kevin Street','53.337757','-6.267699',1,40),(0,'31','OPEN','2019-09-05 15:27:28',72,'JOHN STREET WEST','John Street West','53.343105','-6.277167',0,31),(0,'30','OPEN','2019-09-05 15:34:41',73,'FRANCIS STREET','Francis Street','53.342081','-6.275233',0,30),(4,'26','OPEN','2019-09-05 15:28:19',74,'OLIVER BOND STREET','Oliver Bond Street','53.343893','-6.280531',0,30),(3,'37','OPEN','2019-09-05 15:36:25',75,'JAMES STREET','James Street','53.343456','-6.287409',1,40),(4,'34','OPEN','2019-09-05 15:28:55',76,'MARKET STREET SOUTH','Market Street South','53.342296','-6.287661',0,38),(0,'29','OPEN','2019-09-05 15:36:47',77,'WOLFE TONE STREET','Wolfe Tone Street','53.348875','-6.267459',0,29),(2,'38','OPEN','2019-09-05 15:31:41',78,'MATER HOSPITAL','Mater Hospital','53.359967','-6.264828',0,40),(6,'21','OPEN','2019-09-05 15:34:57',79,'ECCLES STREET EAST','Eccles Street East','53.358115','-6.265601',0,27),(18,'22','OPEN','2019-09-05 15:33:48',80,'ST JAMES HOSPITAL (LUAS)','St James Hospital (Luas)','53.341359','-6.292951',0,40),(0,'40','OPEN','2019-09-05 15:28:07',81,'ST. JAMES HOSPITAL (CENTRAL)','St. James Hospital (Central)','53.339983','-6.295594',0,40),(0,'22','OPEN','2019-09-05 15:28:03',82,'MOUNT BROWN','Mount Brown','53.341645','-6.29719',0,22),(7,'33','OPEN','2019-09-05 15:31:29',83,'EMMET ROAD','Emmet Road','53.340714','-6.308191',0,40),(3,'27','OPEN','2019-09-05 15:33:19',84,'BROOKFIELD ROAD','Brookfield Road','53.339005','-6.300217',0,30),(10,'25','OPEN','2019-09-05 15:32:55',85,'ROTHE ABBEY','Rothe Abbey','53.338776','-6.30395',1,35),(3,'35','OPEN','2019-09-05 15:36:06',86,'PARKGATE STREET','Parkgate Street','53.347972','-6.291804',1,38),(2,'36','OPEN','2019-09-05 15:36:04',87,'COLLINS BARRACKS MUSEUM','Collins Barracks Museum','53.347477','-6.28525',1,38),(3,'27','OPEN','2019-09-05 15:34:53',88,'BLACKHALL PLACE','Blackhall Place','53.3488','-6.281637',0,30),(32,'8','OPEN','2019-09-05 15:34:49',89,'FITZWILLIAM SQUARE EAST','Fitzwilliam Square East','53.335211','-6.2509',1,40),(35,'3','OPEN','2019-09-05 15:33:35',90,'BENSON STREET','Benson Street','53.344153','-6.233451',0,40),(25,'5','OPEN','2019-09-05 15:28:09',91,'SOUTH DOCK ROAD','South Dock Road','53.341833','-6.231291',0,30),(5,'35','OPEN','2019-09-05 15:32:47',92,'HEUSTON BRIDGE (NORTH)','Heuston Bridge (North)','53.347802','-6.292432',0,40),(0,'40','OPEN','2019-09-05 15:33:08',93,'HEUSTON STATION (CENTRAL)','Heuston Station (Central)','53.346603','-6.296924',0,40),(1,'39','OPEN','2019-09-05 15:36:26',94,'HEUSTON STATION (CAR PARK)','Heuston Station (Car Park)','53.346985','-6.297804',0,40),(1,'39','OPEN','2019-09-05 15:27:06',95,'ROYAL HOSPITAL','Royal Hospital','53.343897','-6.29706',1,40),(0,'30','OPEN','2019-09-05 15:30:14',96,'KILMAINHAM LANE','Kilmainham Lane','53.341805','-6.305085',0,30),(1,'39','OPEN','2019-09-05 15:30:28',97,'KILMAINHAM GAOL','Kilmainham Gaol','53.342113','-6.310015',1,40),(29,'11','OPEN','2019-09-05 15:35:33',98,'FREDERICK STREET SOUTH','Frederick Street South','53.341515','-6.256853',1,40),(27,'3','OPEN','2019-09-05 15:35:08',99,'CITY QUAY','City Quay','53.346637','-6.246154',0,30),(4,'21','OPEN','2019-09-05 15:34:10',100,'HEUSTON BRIDGE (SOUTH)','Heuston Bridge (South)','53.347106','-6.292041',0,25),(0,'30','OPEN','2019-09-05 15:30:16',101,'KING STREET NORTH','King Street North','53.350291','-6.273507',0,30),(3,'37','OPEN','2019-09-05 15:36:58',102,'WESTERN WAY','Western Way','53.354929','-6.269425',0,40),(7,'33','OPEN','2019-09-05 15:33:45',103,'GRANGEGORMAN LOWER (SOUTH)','Grangegorman Lower (South)','53.354663','-6.278681',0,40),(3,'37','OPEN','2019-09-05 15:27:30',104,'GRANGEGORMAN LOWER (CENTRAL)','Grangegorman Lower (Central)','53.355173','-6.278424',1,40),(0,'36','OPEN','2019-09-05 15:30:54',105,'GRANGEGORMAN LOWER (NORTH)','Grangegorman Lower (North)','53.355954','-6.278378',0,36),(1,'39','OPEN','2019-09-05 15:30:20',106,'RATHDOWN ROAD','Rathdown Road','53.35893','-6.280337',0,40),(2,'38','OPEN','2019-09-05 15:35:34',107,'CHARLEVILLE ROAD','Charleville Road','53.359157','-6.281866',1,40),(5,'35','OPEN','2019-09-05 15:29:57',108,'AVONDALE ROAD','Avondale Road','53.359405','-6.276142',0,40),(8,'21','OPEN','2019-09-05 15:35:17',109,'BUCKINGHAM STREET LOWER','Buckingham Street Lower','53.353331','-6.249319',0,29),(3,'37','OPEN','2019-09-05 15:28:52',110,'PHIBSBOROUGH ROAD','Phibsborough Road','53.356307','-6.273717',0,40),(0,'40','OPEN','2019-09-05 15:32:52',111,'MOUNTJOY SQUARE EAST','Mountjoy Square East','53.356717','-6.256359',1,40),(0,'30','OPEN','2019-09-05 15:33:40',112,'NORTH CIRCULAR ROAD (O\'CONNELL\'S)','North Circular Road (O\'Connell\'s)','53.357841','-6.251557',0,30),(31,'9','OPEN','2019-09-05 15:35:51',113,'MERRION SQUARE SOUTH','Merrion Square South','53.338614','-6.248606',1,40),(34,'6','OPEN','2019-09-05 15:34:59',114,'WILTON TERRACE (PARK)','Wilton Terrace (Park)','53.333653','-6.248345',1,40),(5,'25','OPEN','2019-09-05 15:34:56',115,'KILLARNEY STREET','Killarney Street','53.354845','-6.247579',0,30);
/*!40000 ALTER TABLE `latestInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather`
--

DROP TABLE IF EXISTS `weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather` (
  `last_time` datetime NOT NULL,
  `temp` float DEFAULT NULL,
  `wind_speed` float DEFAULT NULL,
  `visibility` float DEFAULT NULL,
  `main` float DEFAULT NULL,
  `description` float DEFAULT NULL,
  PRIMARY KEY (`last_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather`
--

LOCK TABLES `weather` WRITE;
/*!40000 ALTER TABLE `weather` DISABLE KEYS */;
INSERT INTO `weather` VALUES ('2019-09-05 13:36:16',15.92,9.3,10000,0,0);
/*!40000 ALTER TABLE `weather` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-05 15:55:03
