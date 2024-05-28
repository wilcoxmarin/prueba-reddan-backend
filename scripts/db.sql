CREATE DATABASE `reddan` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;


-- reddan.cliente definition
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id_cliente` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `apellido` varchar(250) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `telefono` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cliente_unique` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- reddan.factura definition
DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `num_factura` int unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` int unsigned NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`num_factura`),
  KEY `factura_cliente_FK` (`id_cliente`),
  CONSTRAINT `factura_cliente_FK` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- reddan.factura_producto definition
DROP TABLE IF EXISTS `factura_producto`;
CREATE TABLE `factura_producto` (
  `id_factura_producto` int unsigned NOT NULL AUTO_INCREMENT,
  `num_factura` int unsigned NOT NULL,
  `id_producto` int unsigned NOT NULL,
  PRIMARY KEY (`id_factura_producto`),
  KEY `factura_producto_producto_FK` (`id_producto`),
  KEY `factura_producto_factura_FK` (`num_factura`),
  CONSTRAINT `factura_producto_factura_FK` FOREIGN KEY (`num_factura`) REFERENCES `factura` (`num_factura`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_producto_producto_FK` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- reddan.producto definition
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id_producto` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- INSERTS
-- Cliente
INSERT INTO `cliente` VALUES
(1,'Grant','Jacobi','056 Barton Hollow Apt. 257\nLangoshburgh, OK 05797','2002-02-14','948-849-9762x9083','bertram98@herzog.com','howelljacobi'),
(2,'Blanche','Hahn','930 Murazik Neck Suite 057\nLempifort, DE 65393','1978-03-04','922-454-5689','yhowell@ziemebergnaum.info','kuhic'),
(3,'Maye','Paucek','6803 Jolie Point Apt. 985\nAshlymouth, PA 95074','2013-10-20','(777)194-5282x59369','judy.von@nienow.net','hane'),
(4,'Keshaun','Pouros','616 Batz Roads Apt. 301\nNorth Webster, NM 83177-9628','1981-11-26','141-913-4199','hills.ken@lemkenader.com','langworth'),
(5,'Austen','Jenkins','0263 Rau Fords\nQuitzonfurt, ME 98575-0403','1988-11-20','117-109-1366','eudora.kilback@gmail.com','klein'),
(6,'Sandra','Hane','2062 Trenton Highway Suite 699\nWest Eulahstad, MT 35587','1990-08-09','1-544-607-8903','collins.elise@marvinstreich.com','botsfordjones'),
(7,'Ignatius','Gulgowski','131 Dooley Islands Apt. 236\nBeulahbury, NE 59138','1979-02-24','+59(6)3219911936','trent.medhurst@faheyschiller.biz','ebert'),
(8,'Jayden','Hegmann','8262 Flatley Squares Suite 171\nStacyhaven, MS 60729','1971-08-14','+96(3)7884187422','vandervort.elfrieda@hotmail.com','runolfsson'),
(9,'Sydni','Flatley','289 Erdman Inlet\nBrennanburgh, DC 73919','1976-04-22','1-141-045-8529','vhermiston@hotmail.com','hessel'),
(10,'Hosea','Kuvalis','62877 Adriel Center\nFordland, FL 82936-9942','1989-09-27','568.984.9719x701','stoltenberg.mya@schmitt.net','auer'),
(11,'Nia','Kub','949 Leann Square Suite 379\nBednartown, MI 42670','2004-10-08','1-045-982-0592x35148','roger.rippin@hotmail.com','hammes'),
(12,'Gudrun','Erdman','29770 Greenfelder Freeway\nWest Floport, DC 14791','1987-05-17','338.745.3360x7475','kimberly39@kulas.info','metzwintheiser'),
(13,'Hershel','Gleichner','356 Pagac Coves Suite 315\nErnestside, ND 54594-8908','2015-08-27','1-331-331-0060','axel.johns@kreiger.com','kovacek'),
(14,'Amalia','Tremblay','120 Geovanni Estates\nNew Elva, OK 87631','2005-04-09','156-051-8727x871','gideon65@hotmail.com','kovacek'),
(15,'Elijah','Hessel','2039 Boyle Lock Suite 206\nSouth Romantown, WV 53577','1998-05-31','+59(6)6703572506','ferry.ashly@gmail.com','swaniawski'),
(16,'Mabelle','Hartmann','3244 Kaela Brooks Apt. 597\nWest Lilian, SD 40917-2712','2011-09-14','(143)306-8501x8757','aylin.kessler@yahoo.com','becker'),
(17,'Norma','Sipes','543 Letitia Crescent Suite 741\nKreigertown, NE 82912-4205','1982-10-01','102-501-5046','meggie32@nicolas.com','morissette'),
(18,'Kristina','McClure','791 Maggio Tunnel\nHalieville, KY 41503-3927','1999-11-28','945.549.5150x422','vo\'kon@hotmail.com','kesslerkuhn'),
(19,'Emma','Schultz','0289 Tyrese Skyway Suite 088\nBodebury, OH 32814','2010-06-20','1-093-629-9649x194','ima40@stoltenberg.com','morarbins'),
(20,'Kevin','Murphy','6850 Schultz Alley\nLake Deborahmouth, TX 52336','2002-08-02','320-369-0286','gregorio.homenick@hotmail.com','casper'),
(21,'Jarrell','Smith','2080 Rempel Orchard\nHannahmouth, NV 37493','1988-01-03','1-807-722-4368x72680','lavinia38@gmail.com','hintz'),
(22,'Deontae','Harber','947 Cecil River Suite 402\nMollieville, OH 00210','1970-07-27','231-123-6915','sarah87@gmail.com','keebler'),
(23,'Alda','Gusikowski','45744 Doyle Locks Apt. 581\nSouth Chloeberg, GA 44756-5438','2019-03-15','800.703.4772','halvorson.zena@hotmail.com','collierharvey'),
(24,'Chloe','Ziemann','1239 Jazmyn Divide\nLake Lottie, KS 21844-9448','2011-02-12','1-184-460-5645','uarmstrong@yahoo.com','turcotte'),
(25,'Myah','Predovic','73768 Koepp Drives Apt. 628\nWest Pierre, WY 31998-4554','2000-08-08','1-833-083-8376x177','laura.beahan@yahoo.com','fritsch'),
(26,'Xavier','Carroll','2815 Turner Junctions\nNew Rosemary, GA 46494','2002-06-19','(169)933-3861','scot.rogahn@stark.info','nolan'),
(27,'Gregoria','Kohler','1901 Bessie Forge\nTressieview, UT 51532-0741','1979-08-12','300.462.4945','twila.blanda@yahoo.com','gerlach'),
(28,'Maryjane','Rath','75589 Kessler Burgs Suite 583\nSimonisfurt, MS 77972','1996-12-13','1-621-687-0458x1719','archibald.herman@cartwright.com','hauck'),
(29,'Joyce','Nitzsche','9168 Earline Mission Suite 010\nCarolemouth, MI 22559-1394','1970-02-11','1-088-106-4980x2173','demetris.schamberger@hotmail.com','oberbrunner'),
(30,'Reynold','Deckow','5440 Kenny Lane Apt. 922\nRyannshire, MO 92192-6603','1990-07-01','240.318.7023x9976','sarah39@yahoo.com','goldneroconner'),
(31,'Domenica','Lemke','68810 Rosina Land Apt. 305\nNobleshire, VT 86451-1937','1989-03-13','+83(4)6931694371','huel.saige@hotmail.com','oberbrunnerlehner'),
(32,'Chadrick','Greenholt','76169 Bernhard Lakes Apt. 214\nHermannberg, CT 36369-2113','2007-02-14','1-443-639-1155x869','trevor.deckow@grant.com','hermann'),
(33,'Lessie','Boyer','5648 McKenzie Avenue\nNew Annamaeton, AL 50840-8825','2012-05-22','(810)999-0269x154','berge.jessika@bins.com','altenwerthwalsh'),
(34,'Jarrett','Mertz','003 Susie Forge\nEmardfurt, SD 38263','1980-04-22','(807)965-0305','breitenberg.marcos@dubuque.biz','jones'),
(35,'Claud','Halvorson','42044 Gudrun Radial\nLake Maymieport, AL 02190','2020-05-09','03753807630','trantow.ansel@gmail.com','emardmarks'),
(36,'Kale','Funk','1994 Bergstrom Underpass\nDurganport, NH 23607-2530','2006-10-17','446.220.3463x735','mittie36@kuvalis.com','kuhlmanjacobson'),
(37,'Clint','Okuneva','525 Rosina Trace Apt. 252\nKochbury, ID 76042-5918','2013-04-22','(876)496-8474','monahan.ken@ohara.com','terry'),
(38,'Darion','Stiedemann','1959 Barrows Highway Apt. 259\nJoanyland, MT 65334','2013-06-03','468.958.9195x7898','gregg51@hettinger.com','champlin'),
(39,'Ezequiel','Schmitt','822 Hahn Village Suite 893\nRueckertown, ND 24951-4781','1971-04-01','08424779152','katelyn90@langworth.com','baumbach'),
(40,'Ana','Marquardt','812 Beahan Well Suite 293\nNorth Hellen, OR 84632-4875','2024-01-02','+68(3)3533949444','xschuster@croninjast.com','mcdermottbins'),
(41,'Daniella','Turcotte','365 Goodwin Orchard\nSouth Monroe, MN 28189','2002-11-05','01532940828','keeley52@yahoo.com','koelpinprice'),
(42,'Madisen','Halvorson','737 Ryan Cliff Apt. 069\nNew Aaronville, NY 57240','1977-10-13','(350)897-2738x472','faufderhar@yahoo.com','bednar'),
(43,'Carmela','Lueilwitz','1973 Omari Locks Suite 149\nSouth Henriette, MN 55394','2005-10-15','458.483.6961x160','kilback.haylee@grimesweber.info','will'),
(44,'Holly','Altenwerth','832 Vincenza Green Suite 840\nSmithhaven, TX 82771','1976-06-27','1-921-783-8208x488','ashleigh.becker@gmail.com','williamson'),
(45,'Jamarcus','Schmitt','77707 Ricardo Tunnel Suite 132\nGilbertostad, KY 75795-0219','1989-11-12','268-212-4909','odell48@beerhegmann.org','schinner'),
(46,'Laurianne','Welch','4846 Jasper Ports Suite 123\nDelaneymouth, OR 67872','1987-03-17','491.163.3946x6014','earnest.botsford@gmail.com','bruen'),
(47,'Nicola','Maggio','54467 Stracke Courts Suite 728\nWest Sabrynaville, MO 30688','2018-10-06','1-336-983-6680x848','jamie58@hotmail.com','hauck'),
(48,'Vivian','Kirlin','730 Sebastian Lights\nStevechester, TN 42380-0448','2019-07-27','(000)999-2142x17474','lorenzo.monahan@yahoo.com','schaefer'),
(49,'Laila','Weissnat','8186 Asia Haven\nTerryburgh, IL 86801','2016-07-15','1-114-901-3832x2540','vonrueden.lolita@mitchellhaag.com','boehm'),
(50,'Joany','Zieme','635 Willard Crossing\nLake Karianneburgh, GA 47946','1997-04-07','833-121-3072x233','padberg.aileen@langosh.com','vonruedenmcglynn'),
(51,'Leone','Kuvalis','728 Rau Corners\nNorth Juliechester, AL 74044','1983-11-17','1-419-379-0331','reva07@gmail.com','reichel'),
(52,'Kenna','Johnston','42409 Rogahn Falls\nNorth Emanuel, WV 74043-3044','1985-01-29','1-942-413-0374x91512','zaria85@yahoo.com','jast'),
(53,'Collin','West','1698 Wisozk Cove\nNorth Garnett, MA 30346','1972-02-12','517-227-0328','derrick31@tromp.info','powlowskimann'),
(54,'Royal','Funk','529 Cartwright Plaza\nNew Joycestad, ND 29804','1977-08-21','+32(6)0176058578','fernando67@cartwright.com','kohler'),
(55,'Sigrid','Bosco','65578 Gutmann Port Apt. 483\nNew Maritzaside, MD 62215-8864','2016-05-28','1-268-022-7299x107','joannie.kovacek@hotmail.com','fahey'),
(56,'Olaf','Walker','0901 Cale Lights Suite 015\nEast Enricoside, ME 42329-4824','2000-03-30','(781)269-2031','padberg.alexzander@yahoo.com','beatty'),
(57,'Una','Effertz','80672 Ward Radial Apt. 675\nJeramieborough, AL 33599','1974-05-20','1-044-700-7923x91845','travon54@hotmail.com','mitchell'),
(58,'Hazel','Beer','488 Freddie Hollow Suite 534\nAnnamariebury, MA 21175-2807','2021-07-23','1-396-020-4504x66805','dboyer@okuneva.com','fritschdicki'),
(59,'Hermina','Rutherford','900 Roberts Forges\nGislasontown, OR 10221','1989-05-28','1-635-308-4309x1614','annamae.nitzsche@reichertzulauf.com','krajcik'),
(60,'Kayley','Schaefer','85666 Mosciski Road Suite 376\nLake Mireya, OK 37709','1999-01-04','(799)490-4988','princess28@kiehn.biz','jacobi'),
(61,'Jabari','Wiza','395 Reinger Station Apt. 475\nFranciscomouth, MN 46221','1972-01-13','+84(4)2715379746','jweissnat@haleykihn.info','greenfelder'),
(62,'Hope','Collins','3408 Berry Isle\nLake Izabella, AK 01341-5298','1981-05-08','(694)634-6248','jkling@cummerata.org','casper'),
(63,'Pink','Cremin','5350 Schaefer Trail Apt. 649\nHettingermouth, CA 16675-0583','1976-11-26','+13(4)4745268829','ziemann.alessandra@roberts.com','hamill'),
(64,'Quincy','Little','079 Bobbie Lakes\nStephanystad, NE 88074-1903','2000-05-15','04064790231','sean.keeling@yahoo.com','hamillcorkery'),
(65,'Rosalinda','Feil','81866 Harvey Ranch\nGreysonberg, WI 58439-8878','2016-11-02','09195122572','hortense.lubowitz@hotmail.com','douglas'),
(66,'Kyleigh','Rodriguez','3699 O\'Connell Trace\nSouth Fordside, TN 50552-5780','2006-09-06','01880610611','acassin@schustercorkery.com','davis'),
(67,'Daisha','Price','862 Kailey Shores\nAlfredoport, AK 68202','1981-03-26','867-563-3247x13655','josie.durgan@gmail.com','spencer'),
(68,'Caterina','O\'Conner','738 Roberts Road\nNew Jayde, PA 67192','2020-11-17','(259)598-1004x62205','nella.cole@gmail.com','heaney'),
(69,'Teresa','McDermott','3016 Dolly Junction Apt. 501\nHelgaborough, NH 26616','1979-03-12','625.612.8767','liam.greenfelder@thompson.info','lefflerortiz'),
(70,'Velda','Champlin','6419 Pamela Meadows Suite 873\nZacheryview, MI 05398','2015-01-22','666-487-1909','roel00@corwin.biz','mertz'),
(71,'Marlee','Sauer','70619 Nolan Crest\nDibbertfurt, TN 35490','2007-05-15','(339)425-0872','lawson98@hotmail.com','hilll'),
(72,'Rosario','Gislason','81966 Rolfson Motorway\nLake Isidroland, IL 34168','1997-08-12','850-634-3713x687','qschumm@hotmail.com','hudson'),
(73,'Dewitt','Bradtke','2681 Cruickshank Street\nGissellestad, MN 56159','1980-10-14','1-309-958-4554x181','nhills@gmail.com','mccullough'),
(74,'Noe','Murray','5837 Rey Spur\nNorth Darrellborough, IA 34896','2018-10-12','723-848-3651','lgoldner@ledner.com','rice'),
(75,'Fletcher','Zboncak','5401 Mante Ramp\nSchmelerbury, CO 23368-3996','1972-03-19','030.968.9609x7512','simone.schinner@morissette.net','jacobs'),
(76,'Jacynthe','Hackett','28608 Alessia Square Apt. 464\nTrompberg, UT 60980','1979-05-23','594.014.0020x0508','anderson.kiehn@gmail.com','lockman'),
(77,'Eva','Gusikowski','0623 Deonte Orchard Suite 031\nLake Jedidiah, HI 32846','1992-05-31','084-479-6023','kip.herman@hotmail.com','weimanncrooks'),
(78,'Emmanuelle','Herzog','96655 Blanda Islands\nMurphymouth, ND 96444','1971-11-25','+08(8)8392529504','jillian46@abernathy.com','glovermarvin'),
(79,'Jaleel','Maggio','527 Mina Squares Suite 558\nJaydachester, NV 59873','1997-11-13','448.670.6226x511','laverne22@hotmail.com','kutch'),
(80,'Cicero','West','6879 Meda Light\nSouth Arne, VT 49796-5676','1985-12-02','(501)030-6995x77806','qruecker@yahoo.com','lowe'),
(81,'Amy','Witting','801 Giovanni Drive Apt. 291\nNorth Kailee, OR 79694','2016-08-05','943-501-1447','omccullough@rutherford.com','watsica'),
(82,'Jaime','Wiza','9404 Yundt Junction\nJaedenmouth, OR 55769-1510','2017-05-27','342-625-0803x88356','moses.roob@hegmann.com','lubowitz'),
(83,'Rahsaan','Koss','12514 Mante Passage\nLake Jocelynfort, ND 84312-1290','2001-09-16','(743)409-8671x963','pparisian@krajcikward.info','gutmann'),
(84,'Princess','Howell','1969 Schuster Square Suite 627\nSouth Wayneburgh, OK 02122-9431','2023-11-13','454.937.0970','lemke.jabari@botsfordmaggio.com','ullrichgreen'),
(85,'Maureen','Cummerata','095 Hane Branch\nSouth Maxwell, WA 22357','1983-01-15','634-210-5454x423','michale.effertz@stromandaugherty.net','krisschuster'),
(86,'Ella','Abshire','7999 Kirk Street Apt. 792\nLueilwitzburgh, MD 79224','2022-11-20','653.404.3422','fay.mitchel@gmail.com','zboncak'),
(87,'Alexzander','Torphy','8340 Marilou Park Suite 262\nEast Verner, FL 54673','1996-04-18','07448671073','adriana64@yahoo.com','wuckertkassulke'),
(88,'Raul','Cartwright','76803 Dibbert Manors Apt. 738\nGrantfurt, IA 20217-5233','2020-08-30','492.102.7995','ggutmann@hotmail.com','ruecker'),
(89,'Oswald','Balistreri','833 Gottlieb Key\nBernierview, RI 99011','2018-03-05','(290)665-7966x835','krystal.o\'reilly@kuhic.com','sawayn'),
(90,'Keenan','Kunze','51531 Frami Mall Apt. 078\nNew Guadalupechester, WI 96119-8003','2013-09-20','619.688.0142x96691','wolff.geraldine@gmail.com','cruickshank'),
(91,'Dorothy','Witting','2509 Davis Orchard Suite 605\nWest Letitia, AL 11102-6801','1981-06-03','658-444-2723','gottlieb.aurore@okonklein.com','fisher'),
(92,'Watson','Purdy','155 Von Glen Apt. 310\nBellastad, FL 94658','1976-09-30','059-586-7642','schroeder.garrick@kutchtorp.com','yundt'),
(93,'Katrine','Schowalter','714 Nettie Pine Suite 661\nDavisville, IN 65875-1755','1983-09-28','849-386-4641x99516','luna.gaylord@gorczany.net','cummerata'),
(94,'Audra','Wilkinson','4512 Hayes Streets\nCurttown, IN 53202-4113','2001-06-10','407.097.5926x9240','maggio.daron@hudson.biz','swaniawski'),
(95,'Olin','White','8900 Hills Stravenue Suite 200\nNorth Hyman, ND 73269','2002-05-15','1-377-831-2608x251','norn@gmail.com','millerkeebler'),
(96,'Brittany','Murazik','45465 Brian Viaduct\nVioletteland, CO 37059-5341','1981-07-04','(694)014-9951','davion36@hartmann.net','schoenmclaughlin'),
(97,'Kaylee','Corwin','825 Stan Crescent Apt. 121\nPort Ibrahimland, NV 49060','2021-03-18','090.279.4786x8368','sammie77@hotmail.com','prohaska'),
(98,'Shyann','Hartmann','52769 Carter Shore Suite 793\nNew Cary, ID 99864','1994-01-18','598.899.5667x5156','solon.ortiz@ernserhowell.com','lind'),
(99,'Jonathon','Legros','4812 Blaise Locks\nLeilaville, FL 47793-8396','2001-10-08','611-314-6431','mbrakus@kovacek.com','collierhane'),
(100,'Sophie','Johnson','2251 Jamel Stravenue Apt. 511\nWest Ruthe, OR 73734','1979-02-09','(380)052-6364','tia.cole@yahoo.com','feeneyfritsch');

--- Producto
INSERT INTO reddan.producto (id_producto, nombre, precio, stock) 
VALUES
(1, "Essence Mascara Lash Princess", 9.99, 5),
(2, 'Eyeshadow Palette with Mirror', 19.99, 44),
(3, 'Powder Canister', 14.99, 59),
(4, 'Red Lipstick', 12.99, 68),
(5, 'Red Nail Polish', 8.99, 71),
(6, 'Calvin Klein CK One', 49.99, 17),
(7, 'Chanel Coco Noir Eau De', 129.99, 41);

--- Factura

INSERT INTO reddan.factura (num_factura, id_cliente, fecha) 
VALUES
(1, 5, '2024-05-01'),
(2, 10, '2024-04-23'),
(3, 66, '2024-03-23');

--- Factura-Producto
INSERT INTO reddan.factura_producto (id_factura_producto, num_factura, id_producto) 
VALUES
(1, 1, 5),
(2, 1, 6),
(3, 1, 1),
(4, 3, 4),
(5, 3, 3),
(6, 3, 7),
(7, 3, 2),
(8, 2, 1),
(9, 2, 2),
(10, 2, 5);
