﻿--DECLARE @dbname nvarchar(128)
--SET @dbname = N'Base'

--IF (EXISTS (SELECT name 
--FROM master.dbo.sysdatabases 
--WHERE ('[' + name + ']' = @dbname 
--OR name = @dbname)))
---- code mine :)
--PRINT 'db exist';

--CREATE DATABASE Base;

-- êîä íà ñîçäàíèå òàáëèö â áä

USE Base;

CREATE TABLE Teacher
(
	id_teacher INT IDENTITY PRIMARY KEY,
    surname nvarchar(100),
	name_ nvarchar(100),
    patronymic nvarchar(100)
);

CREATE TABLE Chairman_pck
(
	id_chairman_pck INT IDENTITY PRIMARY KEY,
    name_ nvarchar(20),
    surname nvarchar(20),
    patronymic nvarchar(20)
);

CREATE TABLE Speciality
(
	code_speciality nvarchar(100) PRIMARY KEY,
    name_of_speciality nvarchar(100),
);

CREATE TABLE Cycle_commissions
(
	id_cycle_commission INT IDENTITY PRIMARY KEY,
    id_chairman_pck int,
    id_teacher int,
    code_speciality nvarchar(100),
	FOREIGN KEY (code_speciality) REFERENCES Speciality (code_speciality) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_chairman_pck) REFERENCES Chairman_Pck (id_chairman_pck) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_teacher) REFERENCES Teacher (id_teacher) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE Protocols
(
	nom_protocol INT IDENTITY PRIMARY KEY,
    date_protocol date,
    id_cycle_commission INT,
	FOREIGN KEY (id_cycle_commission) REFERENCES Cycle_commissions (id_cycle_commission) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Semesters
(
	nom_semester INT IDENTITY PRIMARY KEY,
    academic_year DATE
);


CREATE TABLE Disciplines
(
	id_discipline int IDENTITY PRIMARY KEY,
    name_discipline nvarchar(500)
);

CREATE TABLE Kurs
(
    nom_kurs INT PRIMARY KEY
);

CREATE TABLE Komplect_tickets
(
    nom_komplect INT IDENTITY PRIMARY KEY,
    nom_kurs INT,
    nom_semester INT,
    nom_protocol INT,
	id_discipline nvarchar(100),
	FOREIGN KEY (nom_semester) REFERENCES Semesters (nom_semester) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (nom_kurs) REFERENCES Kurs (nom_kurs) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (nom_protocol) REFERENCES Protocols (nom_protocol) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Questions
(
	id_question INT IDENTITY,
    id_discipline int,
    question nvarchar(500),
    type_question nvarchar(100),
	--PRIMARY KEY(id_question, id_discipline),
	PRIMARY KEY(id_question),
	FOREIGN KEY (id_discipline) REFERENCES Disciplines (id_discipline) ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TABLE Tickets
(
    id_ticket INT IDENTITY,
    nom_quetion_in_ticket INT,
    id_question INT,
    nom_komplect INT,
	PRIMARY KEY(id_ticket, nom_quetion_in_ticket),
	FOREIGN KEY (id_question) REFERENCES Questions (id_question) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (nom_komplect) REFERENCES Komplect_tickets (nom_komplect) ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TABLE Users
(
	nom_user INT IDENTITY PRIMARY KEY,
    login_ nvarchar(50),
    password_ nvarchar(50),
	role_ nvarchar(5)
);

--DELETE FROM Teacher;
INSERT INTO Teacher (surname, name_, patronymic)
VALUES ('Ñìèðíîâ', 'Êîíñòàíòèí', 'Âàäèìîâè÷'),
('Ëàðèîíîâà', 'Åëåíà', 'Àíàòîëüåâíà'),
('Ìóðàøîâ', 'Àíàòîëèé', 'Àëåêñååâè÷'),
('Ãëóñêåð', 'Àëåêñàíäð', 'Èãîðåâè÷'),
('Àëåêñàíäðîâ', 'Ðîìàí', 'Âèêòîðîâè÷'),
('Õðàáðîâ', 'Èëüÿ', 'Íèêîëàåâè÷'),
('Ìàðöèíêåâè÷', 'Ìàêñèì', 'Ñåðãåååâè÷'),
('Ñòàëèí', 'Èîñèô', 'Âèññàðèîíîâè÷'),
('Òðîöêèé', 'Ëåâ', 'Äàâèäîâè÷'),
('×èïîâñêàÿ', 'Àííà', 'Áîðèñîâíàÿ');

--DROP TABLE Chairman_pck;
INSERT INTO Chairman_pck (surname, name_, patronymic)
VALUES ('Êîòèê', 'Âëàäèñëàâà', 'Âàäèìîâè÷'),
('Ëàðèîíîâà', 'Åëåíà', 'Àíàòîëüåâíà'),
('Ìóðàøîâ', 'Àíàòîëèé', 'Àëåêñååâè÷'),
('Ãëóñêåð', 'Àëåêñàíäð', 'Èãîðåâè÷'),
('Ëåíèí', 'Âëàäèìèð', 'Èëüè÷'),
('Êåðåíñêèé', 'Àëåêñàíäð', 'Ô¸äîðîâè÷'),
('Êîðíèëîâ', 'Ëàâð', 'Ãåîðãèåâè÷'),
('Äåíèêèí', 'Àíòîí', 'Èâàíîâè÷'),
('Ñîëîíèí', 'Ìàðê', 'Ñåì¸íîâè÷'),
('Ñóâîðîâ', 'Âèêòîð', 'Áîãäàíîâè÷');

--DELETE FROM Speciality;
INSERT INTO Speciality (code_speciality, name_of_speciality)
VALUES ('09.02.06', 'Ñåòåâîå è ñèñòåìíîé àäìèíèñòðèðîâàíèå'),
('09.02.07', 'Èíôîðìàöèîííûå ñèñòåìû è ïðîãðàììèðîâàíèå'),
('10.02.05', 'Îáåñïå÷åíèå èíôîðìàöèîííîé áåçîïàñíîñòè àâòîìàòèçèðîâàííûõ ñèñòåì'),
('21.02.19', 'Çåìëåóñòðîéñòâî'),
('42.02.01', 'Ðåêëàìà');

INSERT INTO Cycle_commissions (id_chairman_pck, id_teacher, code_speciality)
VALUES ('1', '1', '09.02.06'),
('2', '2', '09.02.07'),
('3', '3', '10.02.05'),
('4', '4', '21.02.19'),
('5', '5', '42.02.01');

--DELETE FROM Protocols;
INSERT INTO Protocols (date_protocol, id_cycle_commission)
VALUES ('02.02.2023', '1'),
('03.03.2023', '2'),
('04.04.2023', '3'),
('05.05.2023', '4'),
('06.06.2023', '5');

--DELETE FROM Semesters;
INSERT INTO Semesters (academic_year)
VALUES ('01.01.2020'),
('05.05.2020'),
('01.01.2021'),
('05.05.2021'),
('01.01.2022');

--DELETE FROM Disciplines;
INSERT INTO Disciplines (name_discipline)
VALUES ('ÎÏ.01. Îïåðàöèîííûå ñèñòåìû'),
('ÎÏ.10. Ìàòåìàòè÷åñêîå ìîäåëèðîâàíèå'),
('ÌÄÊ.02.01. Èíôîêîììóíèêàöèîííûå ñèñòåìû è ñåòè'),
('ÌÄÊ.02.02. Òåõíîëîãèÿ ðàçðàáîòêè è çàùèòû áàç äàííûõ'),
('ÎÃÑÝ.03. Èíîñòðàííûé ÿçûê');

--DELETE FROM Kurs;
INSERT INTO Kurs (nom_kurs)
VALUES ('1'),
('2'),
('3'),
('4'),
('5');

--DELETE FROM Komplect_tickets;
INSERT INTO Komplect_tickets (nom_kurs, nom_semester, nom_protocol, id_discipline)
VALUES ('1', '1', '1', '1'),
('2', '2', '2', '2'),
('3', '3', '3', '3'),
('4', '4', '4', '4'),
('5', '5', '5', '5');

--DELETE FROM Questions;
INSERT INTO Questions (id_discipline, question, type_question)
VALUES 
--ÎÏ.01. Îïåðàöèîííûå ñèñòåìû ïðàêòè÷åñêèå âîïðîñû
('1', 'Ïîðÿäîê çàãðóçêè îïåðàöèîííîé ñèñòåìû.
Óïðàâëåíèå ïàðàìåòðàìè çàãðóçêè îïåðàöèîííîé ñèñòåìû.', 'Ïðàêòè÷åñêèé'),
('1', 'Ïîâûøåíèå îòêàçîóñòîé÷èâîñòè îïåðàöèîííûõ ñèñòåì', 'Ïðàêòè÷åñêèé'),
('1', 'Äîìåííàÿ àðõèòåêòóðà ÎÑ', 'Ïðàêòè÷åñêèé'),
('1', 'Íàñòðîéêà ïàðàìåòðîâ ðàáî÷åé ñðåäû ïîëüçîâàòåëÿ', 'Ïðàêòè÷åñêèé'),
('1', 'Ðàáîòà ñ ïëàíèðîâùèêîì çàäàíèé', 'Ïðàêòè÷åñêèé'),
--==================
('1', 'Ñîçäàíèå è ðåäàêòèðîâàíèå ôàéëîâ â ðåäàêòîðå Edit', 'Ïðàêòè÷åñêèé'),
('1', 'Âûïîëíåíèå êîíôèãóðèðîâàíèÿ àïïàðàòíûõ
óñòðîéñòâ. Ðàñïðåäåëåíèå ðåñóðñîâ', 'Ïðàêòè÷åñêèé'),
('1', 'Èññëåäîâàíèå ñîîòíîøåíèÿ ìåæäó
ïðåäñòàâëÿåìûì è èñòèííûì îáú¸ìîì çàíÿòîé äèñêîâîé ïàìÿòè', 'Ïðàêòè÷åñêèé'),
('1', 'Óïðàâëåíèå ó÷åòíûìè çàïèñÿìè ïîëüçîâàòåëåé', 'Ïðàêòè÷åñêèé'),
('1', 'Óïðàâëåíèå îïåðàòèâíîé ïàìÿòüþ. Ðàñïðåäåëåíèå ôèçè÷åñêîé ïàìÿòè', 'Ïðàêòè÷åñêèé'),
('1', 'Ðàáîòà ñ ôàéëîì ïîäêà÷êè', 'Ïðàêòè÷åñêèé'),
('1', 'Äèíàìè÷åñêàÿ íàñòðîéêà âèðòóàëüíîé ïàìÿòè â ÎÑ Windows', 'Ïðàêòè÷åñêèé'),
('1', 'Äèíàìè÷åñêàÿ íàñòðîéêà âèðòóàëüíîé ïàìÿòè â Linux Ubuntu', 'Ïðàêòè÷åñêèé'),
('1', 'Ðàáîòà ñ âèäàìè ôàéëîâîé ñèñòåìû', 'Ïðàêòè÷åñêèé'),
('1', 'Ðàáîòà â îïåðàöèîííûõ ñèñòåìàõ è ñðåäàõ,
íàáëþäåíèå çà ðàñïðåäåëåíèåì ðåñóðñîâ ÏÊ', 'Ïðàêòè÷åñêèé'),
('1', 'Èçó÷åíèå ñòðóêòóðû ôàéëîâîé ñèñòåìû. Óïðàâëåíèå äèñêàìè è ôàéëîâûìè ñèñòåìàìè', 'Ïðàêòè÷åñêèé'),
('1', 'Ñðàâíåíèå ðàñïðîñòðàíåííûõ ïðîãðàìì ñðåäñòâ
äèàãíîñòèêè è êîððåêöèè îøèáîê ', 'Ïðàêòè÷åñêèé'),
('1', 'Àäìèíèñòðèðîâàíèå â îïåðàöèîííîé ñèñòåìå Windows', 'Ïðàêòè÷åñêèé'),
('1', 'Óïðàâëåíèå ðàçäåëåíèåì ðåñóðñîâ â ëîêàëüíîé ñåòè', 'Ïðàêòè÷åñêèé'),
('1', ' Èññëåäîâàíèå è èçó÷åíèå âëèÿíèÿ êîëè÷åñòâà
ôàéëîâ íà âðåìÿ, íåîáõîäèìîå äëÿ èõ êîïèðîâàíèÿ', 'Ïðàêòè÷åñêèé'),
('1', 'Èçó÷åíèå ñðåäñòâ óïðàâëåíèÿ â ÎÑ Unix
Íàñòðîéêà ñåòåâûõ ïàðàìåòðîâ â ÎÑ Unix', 'Ïðàêòè÷åñêèé'),
('1', 'Ðàáîòà ñ ïðîãðàììàìè àðõèâàöèè ôàéëîâ', 'Ïðàêòè÷åñêèé'),
('1', 'Êîíòðîëü çà ðàáîòîé äèñïåò÷åðà çàäà÷', 'Ïðàêòè÷åñêèé'),
('1', 'Èñïîëüçîâàíèå àíòèâèðóñíûõ ïðîãðàìì', 'Ïðàêòè÷åñêèé'),
('1', 'Èñïîëüçîâàíèå óòèëèò äëÿ ðàáîòû ñ ôàéëàìè', 'Ïðàêòè÷åñêèé'),
('1', 'Îïåðàöèîííàÿ ñèñòåìà MS-DOS ', 'Ïðàêòè÷åñêèé'),
('1', 'Îïåðàöèîííàÿ ñèñòåìà Free-DOS ', 'Ïðàêòè÷åñêèé'),
('1', 'Êîìàíäû îáñëóæèâàíèÿ êàòàëîãîâ. Îáîëî÷êà
NC ', 'Ïðàêòè÷åñêèé'),
('1', 'Ïðîãðàììíîå êîíôèãóðèðîâàíèå
êîìïüþòåðíîé ñèñòåìû', 'Ïðàêòè÷åñêèé'),
('1', 'Èñïîëüçîâàíèå ìåíþ â ôàéëàõ êîíôèãóðàöèè', 'Ïðàêòè÷åñêèé'),
('1', 'Îïðåäåëèòå (â %) ðàçìåð îñíîâíîãî ðàçäåëà äèñêà, åñëè äîïîëíèòåëüíûé (ðàñøèðåííûé)
ðàçäåë ñîñòîèò èç äâóõ ëîãè÷åñêèõ ðàçäåëîâ ðàçìåðîì 30% è 20 %. Çàïóñòèòå ïðîãðàììó
DiskDirectSuite. Ðàçáåéòå äèñê íà óêàçàííûå ðàçäåëû.', 'Ïðàêòè÷åñêèé'),
('1', 'Íàçíà÷åíèå ïðîãðàììû DiskDirectSuite. Îïðåäåëèòå êîëè÷åñòâî ñåêòîðîâ îáëàñòè äàííûõ
ÃÌÄ, åñëè âñåãî íà ãèáêîì äèñêå 2880 ñåêòîðîâ, ñëóæåáíàÿ îáëàñòü çàíèìàåò 33 ñåêòîðà, à
ðàçìåð FAT  18 ñåêòîðîâ.', 'Ïðàêòè÷åñêèé'),
('1', 'Íàçíà÷åíèå ïðîãðàììû DiskDirectSuite. Ðàçìåð ðàçäåëà æåñòêîãî äèñêà ðàâåí 2048 Êáàéò.
Ñêîëüêî ñåêòîðîâ áóäåò ñîäåðæàòü ðàçäåë? Ñîçäàéòå ðàçäåë òàêîãî ðàçìåðà ñ ôàéëîâîé
ñèñòåìîé fat.', 'Ïðàêòè÷åñêèé'),
('1', 'Íàðèñóéòå öåïî÷êó êëàñòåðîâ ôàéëà, åñëè åãî äëèíà 3410 áàéò, ðàçìåð êëàñòåðà  2 ñåêòîðà, à
ïðè åãî çàïèñè áûëè ñâîáîäíû òîëüêî êëàñòåðû 5, 7, 10, 13, 14, 18.', 'Ïðàêòè÷åñêèé'),
('1', 'Çàïóñòèòå óòèëèòó KSysGuard. Êàêîâû îñíîâíûå âîçìîæíîñòè óòèëèòû? Ïðîñìîòðèòå
ñèñòåìíûå ïðîöåññû. Ïðîàíàëèçèðóéòå õàðàêòåðèñòèêè ïðîöåññà ñ èäåíòèôèêàòîðîì 1:
ñîñòîÿíèå, ïðèîðèòåò, ðàçìåð âèðòóàëüíîé è ôèçè÷åñêîé ïàìÿòè, çàíèìàåìîé ïðîöåññîì,
ðîäèòåëüñêèé ïðîöåññ, èìÿ ïîëüçîâàòåëÿ, çàïóñòèâøåãî ïðîöåññ. Èçìåíèòå åãî ïðèîðèòåò.
Êàê èçìåíåíèå ïðèîðèòåòà âëèÿåò íà ñêîðîñòü ðàáîòû ïðîöåññà?', 'Ïðàêòè÷åñêèé'),
('1', 'Íàðèñóéòå öåïî÷êó êëàñòåðîâ ôàéëà, åñëè åãî äëèíà 2,3 Êá, ðàçìåð êëàñòåðà  1 ñåêòîð, à ïðè
åãî çàïèñè áûëè ñâîáîäíû òîëüêî êëàñòåðû 2, 4, 8, 10, 14, 23.', 'Ïðàêòè÷åñêèé'),
('1', 'Çàïóñòèòå ðåäàêòîð ðååñòðà regedit. Íàéäèòå âåòâü ðååñòðà
HKEY_CURRENT_USER\ControlPanel\Desktop\WindowsMetrics è ýêñïîðòèðóéòå åå â êàòàëîã
ñâîåé ãðóïïû. Èçìåíèòå ïàðàìåòð IconSpasing íà 25. Ïåðåçàãðóçèòå ìàøèíó è ïîñìîòðèòå
ðåçóëüòàò. Èìïîðòèðóéòå ñîõðàíåííûé ðàíåå ôàéë â ðååñòð. Äëÿ ÷åãî íåîáõîäèìî
ïðîèçâîäèòü ýêñïîðò è èìïîðò âåòâåé ðååñòðà?', 'Ïðàêòè÷åñêèé'),
('1', 'Çàïóñòèòå ðåäàêòîð ðååñòðà regedit. Íàéäèòå âåòâü ðååñòðà HKEY_USERS è ýêñïîðòèðóéòå åå
â êàòàëîã ñâîåé ãðóïïû. Èìïîðòèðóéòå ñîõðàíåííûé ðàíåå ôàéë â ðååñòð.', 'Ïðàêòè÷åñêèé'),
('1', 'Çàïóñòèòå óòèëèòó KSysGuard. Êàêîâû îñíîâíûå âîçìîæíîñòè óòèëèòû? Ïðîñìîòðèòå
ñèñòåìíûå ïðîöåññû. Ïðîàíàëèçèðóéòå õàðàêòåðèñòèêè ïðîöåññà ñ èäåíòèôèêàòîðîì 10:
ñîñòîÿíèå, ïðèîðèòåò, ðàçìåð âèðòóàëüíîé è ôèçè÷åñêîé ïàìÿòè, çàíèìàåìîé ïðîöåññîì,
ðîäèòåëüñêèé ïðîöåññ, èìÿ ïîëüçîâàòåëÿ, çàïóñòèâøåãî ïðîöåññ. ', 'Ïðàêòè÷åñêèé'),
('1', 'Çàïóñòèòå óòèëèòó KSysGuard. Êàêîâû îñíîâíûå âîçìîæíîñòè óòèëèòû? Çàïóñòèòå ëþáîé
ïîëüçîâàòåëüñêèé ïðîöåññ. Ïîøëèòå ïðîöåññó ñèãíàë îñòàíîâà? Êàê ýòî ïîâëèÿëî íà ðàáîòó
ïðîöåññà? Ïîøëèòå ïðîöåññó ñèãíàë SIGCONT. ×òî ïðîèçîøëî ñ ïðîöåññîì? Çàâåðøèòå
ðàáîòó ïðîöåññà.', 'Ïðàêòè÷åñêèé'),
('1', 'Ïðîñìîòðèòå îñíîâíûå ñâåäåíèÿ î ïðîèçâîäèòåëüíîñòè ÖÏ óòèëèòîé KSysInfo. Çàïóñòèòå
óòèëèòó KSysGuard. Êàêîâû îñíîâíûå âîçìîæíîñòè óòèëèòû? Ïðîàíàëèçèðóéòå êàê
ìåíÿåòñÿ çàãðóçêà ïðîöåññîðà.', 'Ïðàêòè÷åñêèé'),
('1', 'Óñòàíîâèòå íà âèðòóàëüíóþ ìàøèíó îïåðàöèîííóþ ñèñòåìó Windows XP', 'Ïðàêòè÷åñêèé'),
('1', 'Óñòàíîâèòå íà âèðòóàëüíóþ ìàøèíó îïåðàöèîííóþ ñèñòåìó Linux.', 'Ïðàêòè÷åñêèé'),
('1', 'Êàêèå ïðîãðàììû îáñëóæèâàíèÿ Windows Âû çíàåòå? Êàêîâî èõ íàçíà÷åíèå? Ïðîâåäèòå
î÷èñòêó äèñêà è àíàëèç ôðàãìåíòàöèè ëþáîãî ðàçäåëà Ñ: ', 'Ïðàêòè÷åñêèé'),
('1', 'Ñîçäàéòå ó÷åòíóþ çàïèñü äëÿ ïîëüçîâàòåëÿ user. Óñòàíîâèòå êâîòû íà èñïîëüçîâàíèå
äèñêîâîãî ïðîñòðàíñòâà è ïîðîã âûäà÷è ïðåäóïðåæäåíèÿ äëÿ ñîçäàííîãî ïîëüçîâàòåëÿ', 'Ïðàêòè÷åñêèé'),
('1', 'Ñîçäàéòå ãðóïïó news. Ñîçäàéòå ó÷åòíóþ çàïèñü monthly. Äîáàâüòå êîììåíòàðèè ê ó÷åòêå.
Èçìåíèòå èìÿ ó÷åòêè ñ monthly íà weekly. ', 'Ïðàêòè÷åñêèé'),
('1', 'Ñîçäàéòå â Windows ó÷¸òíûå çàïèñè ïîëüçîâàòåëåé student è teacher. Óñòàíîâèòå ïðàâà
äîñòóïà ê ïàïêàì:
â ïàïêó Otvet äîëæíû çàïèñûâàòüñÿ è ñòèðàòüñÿ ôàéëû îòâåòîâ ïîëüçîâàòåëÿ student;
â ïàïêå Zadanie ïîëüçîâàòåëü student ìîæåò òîëüêî ÷èòàòü ôàéëû, à ïîëüçîâàòåëü teacher
ìîæåò äîáàâëÿòü è èçìåíÿòü ôàéëû.', 'Ïðàêòè÷åñêèé'),
('1', 'Ñîçäàéòå ãðóïïó news. Â ãðóïïó äîáàâüòå ó÷åòíûå çàïèñè tabló è monthly. Íàçíà÷üòå ïàðîëè
ê ó÷åòíûì çàïèñÿì. Ñîçäàéòå ïàïêó WORK. Íàçíà÷üòå îáùèé äîñòóï ê ýòîé ïàïêå.', 'Ïðàêòè÷åñêèé'),
('1', 'Âûâåäèòå ëèñòèíã ôàéëîâ /etc/passwd è /etc/group. Äàéòå ðàñøèôðîâêó èõ ñîäåðæèìîãî', 'Ïðàêòè÷åñêèé'),
('1', 'Íàðèñóéòå öåïî÷êó êëàñòåðîâ äëÿ àðõèâíîãî ôàéëà Prog.rar ðàçìåðîì 4 êá, åñëè èçâåñòíî,
ñâîáîäíûå êëàñòåðû íà÷èíàþòñÿ ñ 15 è êëàñòåðû 17, 19 çàðåçåðâèðîâàíû, à 20 êëàñòåð
èñïîð÷åííûé. Ïðè ýòî ðàçìåð êëàñòåðà 1024 áàéò. Ïðèåìëåì ëè âûáðàííûé ðàçìåð êëàñòåðà
äëÿ äàííîãî ôàéëà? Åñòü ëè ïîòåðè ìåñòà íà ÆÄ?', 'Ïðàêòè÷åñêèé'),
('1', 'Íàðèñóéòå öåïî÷êó êëàñòåðîâ ôàéëà, åñëè åãî äëèíà 2000 áàéò, ðàçìåð êëàñòåðà  1 ñåêòîð, à
ïðè åãî çàïèñè áûëè ñâîáîäíû òîëüêî êëàñòåðû 5, 7, 10, 13.', 'Ïðàêòè÷åñêèé'),
('1', 'Çàïóñòèòå ðåäàêòîð ðååñòðà regedit. Íàéäèòå âåòâü ðååñòðà
HKEY_CURRENT_USER\ControlPanel\Desktop\WindowsMetrics è ýêñïîðòèðóéòå åå â êàòàëîã
ñâîåé ãðóïïû. Èçìåíèòå ïàðàìåòð IconSpasing íà 25. Ïåðåçàãðóçèòå ìàøèíó è ïîñìîòðèòå
ðåçóëüòàò. Èìïîðòèðóéòå ñîõðàíåííûé ðàíåå ôàéë â ðååñòð. Äëÿ ÷åãî íåîáõîäèìî
ïðîèçâîäèòü ýêñïîðò è èìïîðò âåòâåé ðååñòðà?', 'Ïðàêòè÷åñêèé'),
('1', 'Îïðåäåëèòå (â %) ðàçìåð îñíîâíîãî ðàçäåëà äèñêà, åñëè äîïîëíèòåëüíûé (ðàñøèðåííûé)
ðàçäåë ñîñòîèò èç äâóõ ëîãè÷åñêèõ ðàçäåëîâ ðàçìåðîì 20% è 15 %. Çàïóñòèòå ïðîãðàììó
DiskDirectSuite. Ðàçáåéòå äèñê íà óêàçàííûå ðàçäåëû.', 'Ïðàêòè÷åñêèé'),
--ÎÏ.01. Îïåðàöèîííûå ñèñòåìû òåîðåòè÷åêèå âîïðîñû
('1', '×òî òàêîå îïåðàöèîííàÿ ñèñòåìà, îïåðàöèîííàÿ ñðåäà,
îïåðàöèîííàÿ îáîëî÷êà?', 'Òåîðåòè÷åñêèé'),
('1', 'Íàçíà÷åíèå è ôóíêöèè îïåðàöèîííîé ñèñòåìû.', 'Òåîðåòè÷åñêèé'),
('1', 'Ïîíÿòèå ïðîãðàììíîãî èíòåðôåéñà, åãî íàçíà÷åíèå. Âèäû èíòåðôåéñîâ', 'Òåîðåòè÷åñêèé'),
('1', 'Êîìàíäíûé èíòåðôåéñ. Âèäû ðåàëèçàöèè.', 'Òåîðåòè÷åñêèé'),
('1', 'WIMP-èíòåðôåéñ. SILK-èíòåðôåéñ.Âèäû ðåàëèçàöèè.', 'Òåîðåòè÷åñêèé'),
--==================
('1', 'Îïðåäåëåíèå è ôóíêöèè îïåðàöèîííûõ ñèñòåì. Ýâîëþöèÿ ÎÑ', 'Òåîðåòè÷åñêèé'),
('1', 'Àðõèòåêòóðà ÎÑ: ÿäðî è âñïîìîãàòåëüíûå ìîäóëè, ðåæèìû ðàáîòû ïðîöåññîðà:
ïðèâèëåãèðîâàííûé è ïîëüçîâàòåëüñêèé, ðàáîòà ÿäðà â ïðèâèëåãèðîâàííîì ðåæèìå', 'Òåîðåòè÷åñêèé'),
('1', 'Ôàéëîâàÿ ñèñòåìà Linux: ñòðóêòóðà êàòàëîãîâ ôàéëîâîé ñèñòåìû. Îñíîâíûå êàòàëîãè Linux', 'Òåîðåòè÷åñêèé'),
('1', 'Êîíöåïöèÿ ìèêðîÿäåðíîé àðõèòåêòóðû', 'Òåîðåòè÷åñêèé'),
('1', 'Ñîñòîÿíèå ïîòîêîâ íà ðàçíûõ ýòàïàõ èõ ðàçðàáîòêè.Àëãîðèòì ïëàíèðîâàíèÿ ïðîöåññîâ
îñíîâàííûé íà êâàíòîâàíèè', 'Òåîðåòè÷åñêèé'),
('1', 'Ñîñòîÿíèå ïîòîêîâ íà ðàçíûõ ýòàïàõ èõ ðàçðàáîòêè.Àëãîðèòì ïëàíèðîâàíèÿ ïðîöåññîâ
îñíîâàííûé íà îòíîñèòåëüíûõ ïðèîðèòåòàõ', 'Òåîðåòè÷åñêèé'),
('1', 'Ñîñòîÿíèå ïîòîêîâ íà ðàçíûõ ýòàïàõ èõ ðàçðàáîòêè.Àëãîðèòì ïëàíèðîâàíèÿ ïðîöåññîâ
îñíîâàííûé íà àáñîëþòíûõ ïðèîðèòåòàõ', 'Òåîðåòè÷åñêèé'),
('1', 'Íàçíà÷åíèå è òèïû ïðåðûâàíèé', 'Òåîðåòè÷åñêèé'),
('1', 'Òèïû àäðåñîâ (ñèìâîëüíûå, âèðòóàëüíûå, ôèçè÷åñêèå). Êëàññèôèêàöèÿ ìåòîäîâ
ðàñïðåäåëåíèÿ îïåðàòèâíîé ïàìÿòè', 'Òåîðåòè÷åñêèé'),
('1', 'Ïîíÿòèå îïåðàòèâíîé ïàìÿòè.Ðàñïðåäåëåíèå ïàìÿòè ôèêñèðîâàííûìè ðàçäåëàìè', 'Òåîðåòè÷åñêèé'),
('1', 'Ïîíÿòèå îïåðàòèâíîé ïàìÿòè.Ðàñïðåäåëåíèå ïàìÿòè äèíàìè÷åñêèìè ðàçäåëàìè (ðàçäåëàìè
ïåðåìåííîé âåëè÷èíû)', 'Òåîðåòè÷åñêèé'),
('1', 'Ïîíÿòèå îïåðàòèâíîé ïàìÿòè. Ðàñïðåäåëåíèå ïàìÿòè ïåðåìåùàåìûìè ðàçäåëàìè', 'Òåîðåòè÷åñêèé'),
('1', '. Ïîíÿòèå âèðòóàëüíîé ïàìÿòè. Ñòðàíè÷íîå ðàñïðåäåëåíèå.', 'Òåîðåòè÷åñêèé'),
('1', 'Ïîíÿòèå âèðòóàëüíîé ïàìÿòè. Ñåãìåíòíîå ðàñïðåäåëåíèå.', 'Òåîðåòè÷åñêèé'),
('1', 'Ïîíÿòèå âèðòóàëüíîé ïàìÿòè. Ñåãìåíòíî - ñòðàíè÷íîå ðàñïðåäåëåíèå.', 'Òåîðåòè÷åñêèé'),
('1', 'Ìåòîäû ðàñïðåäåëåíèÿ îïåðàòèâíîé ïàìÿòè áåç èñïîëüçîâàíèÿ äèñêîâîãî ïðîñòðàíñòâà.', 'Òåîðåòè÷åñêèé'),
('1', 'Ìåòîäû ðàñïðåäåëåíèÿ îïåðàòèâíîé ïàìÿòè ñ èñïîëüçîâàíèåì äèñêîâîãî ïðîñòðàíñòâà.', 'Òåîðåòè÷åñêèé'),
('1', 'Ñâîïèíã, êàê ÷àñòíûé ñëó÷àé âèðòóàëüíîé ïàìÿòè', 'Òåîðåòè÷åñêèé'),
('1', 'Öåëè è çàäà÷è ôàéëîâîé ñèñòåìû. Òèïû ôàéëîâ. Èìåíîâàíèå ôàéëîâ. Àòðèáóòû ôàéëîâ.', 'Òåîðåòè÷åñêèé'),
('1', 'Ôèçè÷åñêàÿ îðãàíèçàöèÿ ìàãíèòíîãî äèñêà: ðàçäåëû, ñåêòîðû, êëàñòåðû, äîðîæêè, öèëèíäð,
ïðîöåññ ðàçáèåíèÿ äèñêà íà ðàçäåëû.', 'Òåîðåòè÷åñêèé'),
('1', 'Ôàéëîâàÿ ñèñòåìà FAT. Ëîãè÷åñêèå îáëàñòè ðàçäåëà FAT', 'Òåîðåòè÷åñêèé'),
('1', 'Ôàéëîâàÿ ñèñòåìà NTFS. Ëîãè÷åñêèå îáëàñòè ðàçäåëà NTFS.', 'Òåîðåòè÷åñêèé'),
('1', 'Áàçîâûå êîìàíäû ÎÑ Linux', 'Òåîðåòè÷åñêèé'),
('1', 'Ïîíÿòèå êýø-ïàìÿòè. Ïðèíöèï äåéñòâèÿ êýø-ïàìÿòè', 'Òåîðåòè÷åñêèé'),
('1', 'Áàçîâûå êîìàíäû MS DOS.', 'Òåîðåòè÷åñêèé'),
('1', 'Ðååñòð Windows: îñíîâíûå ïîíÿòèÿ, âåòâè, ñïîñîáû ðåäàêòèðîâàíèÿ. ', 'Òåîðåòè÷åñêèé'),
('1', 'Ñîñòàâíûå ìîäóëè ÿäðà ÎÑ.', 'Òåîðåòè÷åñêèé'),
('1', 'Àóòåíòèôèêàöèÿ, ïàðîëè, àâòîðèçàöèÿ, àóäèò', 'Òåîðåòè÷åñêèé'),
('1', 'Àäìèíèñòðèðîâàíèå ó÷¸òíûõ çàïèñåé è ãðóïï â ÎÑ Windows XP.', 'Òåîðåòè÷åñêèé'),
('1', 'Àäìèíèñòðèðîâàíèå ó÷¸òíûõ çàïèñåé è ãðóïï â ÎÑ Linux.', 'Òåîðåòè÷åñêèé'),
--ÎÏ.10. Ìàòåìàòè÷åñêîå ìîäåëèðîâàíèå òåîðåòè÷åñêèå âîïðîñû
('2', 'Ïîíÿòèå ìîäåëè, ìîäåëèðîâàíèÿ.
Ïðåäìåòíûå, àíàëîãîâûå è ìàòåìàòè÷åñêèå ìîäåëè.
Îáùàÿ ñõåìà ìåòîäà ìîäåëèðîâàíèÿ ñëîæíûõ ñèñòåì.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìåòîä ìàòåìàòè÷åñêîãî ìîäåëèðîâàíèÿ.
Êëàññèôèêàöèÿ ìîäåëåé.
Ïåðñïåêòèâû ïðèìåíåíèÿ ìíîãîïðîöåññîðíûõ âû÷èñëèòåëüíûõ ñèñòåì.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïîñòðîåíèå ñòàöèîíàðíîé ìîäåëè ïî äèñêðåòíîìó íàáîðó äàííûõ.
Ñâÿçü çàäà÷è èäåíòèôèêàöèè ïàðàìåòðîâ ñòàöèîíàðíîé ìîäåëè òèïà ÷åðíûé ÿùèê ñ çàäà÷åé èíòåðïîëÿöèè
è çàäà÷åé íàèëó÷øåãî ïðèáëèæåíèÿ ôóíêöèè.', 'Òåîðåòè÷åñêèé'),
('2', 'Ëèíåéíàÿ èíòåðïîëÿöèÿ.
Ïðàêòè÷åñêèé ñïîñîá èíòåðïîëÿöèè.
Ïðÿìîå ïîñòðîåíèå èíòåðïîëÿöèîííîãî ìíîãî÷ëåíà Ëàãðàíæà
è òðèãîíîìåòðè÷åñêîãî èíòåðïîëÿöèîííîãî ìíîãî÷ëåíà.', 'Òåîðåòè÷åñêèé'),
('2', 'Ðàçäåëåííûå ðàçíîñòè.
Èíòåðïîëÿöèîííûé ìíîãî÷ëåí â ôîðìå Íüþòîíà.
Èíòåðïîëÿöèÿ ñ êðàòíûìè óçëàìè.
Ìíîãî÷ëåíû Ýðìèòà.
Çàäà÷è íà ïîñòðîåíèå ýðìèòîâûõ ñïëàéíîâ.', 'Òåîðåòè÷åñêèé'),
('2', 'Êëàññèôèêàöèÿ ìîäåëåé.', 'Òåîðåòè÷åñêèé'),
('2', 'Îñíîâíûå ýòàïû ìàòåìàòè÷åñêîãî ìîäåëèðîâàíèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìàòåìàòè÷åñêàÿ ìîäåëü òðàíñïîðòíîé çàäà÷è.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìàòåìàòè÷åñêàÿ ìîäåëü çàäà÷è î âûïóñêå ïðîäóêöèè.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìàòåìàòè÷åñêàÿ ìîäåëü çàäà÷è î ðàíöå.', 'Òåîðåòè÷åñêèé'),
('2', 'Ñëó÷àéíûå ïðîöåññû è èõ êëàññèôèêàöèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìàòåìàòè÷åñêàÿ ìîäåëü çàäà÷è î íàçíà÷åíèÿõ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïðåäìåò, çàäà÷à è îñíîâíûå ïîíÿòèÿ ìàòåìàòè÷åñêîãî
ïðîãðàììèðîâàíèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Êëàññèôèêàöèÿ çàäà÷ ìàòåìàòè÷åñêîãî ïðîãðàììèðîâàíèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Çàäà÷à ëèíåéíîãî ïðîãðàììèðîâàíèÿ è åå îáùàÿ ôîðìà.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïðèâåäåíèå çàäà÷è ëèíåéíîãî ïðîãðàììèðîâàíèÿ ê êàíîíè÷åñêîé
ôîðìå.', 'Òåîðåòè÷åñêèé'),
('2', 'Ãåîìåòðè÷åñêàÿ èíòåðïðåòàöèÿ çàäà÷è ëèíåéíîãî ïðîãðàììèðîâàíèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Âîçìîæíûå ìíîæåñòâà ðåøåíèé çàäà÷è ëèíåéíîãî
ïðîãðàììèðîâàíèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Îáùàÿ õàðàêòåðèñòèêà ñèìïëåêñ  ìåòîäà.', 'Òåîðåòè÷åñêèé'),
('2', 'Çàïîëíåíèå íà÷àëüíîé ñèìïëåêñ  òàáëèöû.', 'Òåîðåòè÷åñêèé'),
('2', 'Êðèòåðèé îïòèìàëüíîñòè ïëàíà çàäà÷è ëèíåéíîãî ïðîãðàììèðîâàíèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìåòîä ïîñòðîåíèÿ íîâîãî ïëàíà â ðàìêàõ ñèìïëåêñ  ìåòîäà.', 'Òåîðåòè÷åñêèé'),
('2', 'Âñïîìîãàòåëüíàÿ çàäà÷à.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìîäåëü òðàíñïîðòíîé çàäà÷è â ôîðìå òàáëèöû.', 'Òåîðåòè÷åñêèé'),
('2', 'Áàëàíñèðîâêà òðàíñïîðòíîé çàäà÷è.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìåòîä ñåâåðî-çàïàäíîãî óãëà.', 'Òåîðåòè÷åñêèé'),
('2', 'Îáùàÿ õàðàêòåðèñòèêà ìåòîäà ïîòåíöèàëîâ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïðîâåðêà ïëàíà òðàíñïîðòíîé çàäà÷è íà îïòèìàëüíîñòü.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïîñòðîåíèå íîâîãî ïëàíà â ìåòîäå ïîòåíöèàëîâ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïðåäìåò, îáëàñòü ïðèìåíåíèÿ è îñíîâíûå ïîíÿòèÿ òåîðèè ãðàôîâ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïðåäìåò è îáëàñòü ïðèìåíåíèÿ ñèñòåìû ñåòåâîãî ïëàíèðîâàíèÿ è
óïðàâëåíèÿ.', 'Òåîðåòè÷åñêèé'),
('2', 'Ñåòåâîé ãðàôèê è åãî ýëåìåíòû.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïàðàìåòðû ñîáûòèé è ðàáîò.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìåòîäèêà ðàñ÷åòà ïàðàìåòðîâ ñåòåâîãî ãðàôèêà.', 'Òåîðåòè÷åñêèé'),
('2', 'Êðèòè÷åñêèé ïóòü è åãî ñîäåðæàòåëüíûé ñìûñë.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïîñòàíîâêà çàäà÷è î êðàò÷àéøåì ìàðøðóòå.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïîñòàíîâêà çàäà÷è î ìàêñèìàëüíîì ïîòîêå.', 'Òåîðåòè÷åñêèé'),
('2', 'Ðàçðåç è åãî ïðîïóñêíàÿ ñïîñîáíîñòü.', 'Òåîðåòè÷åñêèé'),
('2', 'Òåîðåìà Ôîðäà  Ôàëêåðñîíà.', 'Òåîðåòè÷åñêèé'),
('2', 'Ìåòîäîëîãèÿ ìåòîäà âåòâåé è ãðàíèö.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïîñòàíîâêà çàäà÷è êîììèâîÿæåðà.', 'Òåîðåòè÷åñêèé'),
('2', 'Àëãîðèòì ïðèâåäåíèÿ ìàòðèöû ðàñõîäîâ â çàäà÷å êîììèâîÿæåðà.', 'Òåîðåòè÷åñêèé'),
('2', 'Àëãîðèòì äåëåíèÿ ìíîæåñòâà ìàðøðóòîâ íà ÷àñòè.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïðîöåññû ðàçìíîæåíèÿ è ãèáåëè.', 'Òåîðåòè÷åñêèé'),
('2', 'Ïðîöåññ Ìàðêîâà è åãî ñâîéñòâà.', 'Òåîðåòè÷åñêèé'),
--ÎÏ.10. Ìàòåìàòè÷åñêîå ìîäåëèðîâàíèå ïðàêòè÷åñêèå âîïðîñû
('2', 'Ïîñòðîåíèå ïðîñòåéøèõ ìàòåìàòè÷åñêèõ ìîäåëåé.', 'Ïðàêòè÷åñêèé'),
('2', 'Ðåøåíèå ïðîñòåéøèõ îäíîêðèòåðèàëüíûõ çàäà÷', 'Ïðàêòè÷åñêèé'),
('2', 'Çàäà÷à Êîøè äëÿ óðàâíåíèÿ òåïëîïðîâîäíîñòè', 'Ïðàêòè÷åñêèé'),
('2', 'Ðåøåíèå çàäà÷ ëèíåéíîãî ïðîãðàììèðîâàíèÿ
ñèìïëåêñìåòîäîì', 'Ïðàêòè÷åñêèé'),
('2', 'Íàõîæäåíèå íà÷àëüíîãî ðåøåíèÿ òðàíñïîðòíîé
çàäà÷è. Ðåøåíèå òðàíñïîðòíîé çàäà÷è ìåòîäîì ïîòåíöèàëîâ', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóùíîñòü àëãîðèòìà Ôëàíäà.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóòü ñåòåâûõ çàäà÷ ëèíåéíîãî ïðîãðàììèðîâàíèÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóòü çàäà÷è ìèíèìèçàöèè ñåòè.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóòü çàäà÷è î íàõîæäåíèè êðàò÷àéøåãî ïóòè.', 'Ïðàêòè÷åñêèé'),
('2', 'Àëãîðèòì çàäà÷è îïðåäåëåíèÿ ìàêñèìàëüíîãî ïîòîêà.', 'Ïðàêòè÷åñêèé'),
('2', 'Îñíîâíûå êëàññû çàäà÷ â îáëàñòè òðàíñïîðòíîãî ñòðîèòåëüñòâà,
ðåøàåìûå ñ ïðèìåíåíèåì ìîäåëåé ìàññîâîãî îáñëóæèâàíèÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Êëàññèôèêàöèÿ ìîäåëåé óïðàâëåíèÿ çàïàñàìè.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóùíîñòü ìîäåëåé ñ ïåðèîäè÷åñêèì ïîïîëíåíèåì çàïàñîâ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóùíîñòü ìîäåëåé ñ íåïåðèîäè÷åñêèì ïîïîëíåíèåì çàïàñîâ.', 'Ïðàêòè÷åñêèé'),
('2', 'Äîñòîèíñòâà è íåäîñòàòêè ìîäåëåé ñ ïåðèîäè÷åñêèì ïîïîëíåíèåì
çàïàñîâ.', 'Ïðàêòè÷åñêèé'),
('2', 'Äîñòîèíñòâà è íåäîñòàòêè ìîäåëåé ñ íåïåðèîäè÷åñêèì ïîïîëíåíèåì
çàïàñîâ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ìåòîäèêà ðàñ÷åòà îïòèìàëüíîãî ïåðèîäà ïîïîëíåíèÿ çàïàñà íà
ìîäåëè ñ ïåðèîäè÷åñêèì ñïðîñîì.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóòü âåðîÿòíîñòíîé ìîäåëè óïðàâëåíèÿ çàïàñàìè.', 'Ïðàêòè÷åñêèé'),
('2', 'Ïîðÿäîê îáîñíîâàíèÿ îïòèìàëüíîãî ðàçìåðà çàïàñà íà âåðîÿòíîñòíîé
ìîäåëè ñ çàäàííîé íàäåæíîñòüþ ïðè äâóñòîðîííèõ èíòåðâàëüíûõ îöåíêàõ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ãðàôè÷åñêîå ïðåäñòàâëåíèå âåðîÿòíîñòíîé ìîäåëè óïðàâëåíèÿ
çàïàñàìè.', 'Ïðàêòè÷åñêèé'),
('2', 'Ïîñòàíîâêà çàäà÷è óïðàâëåíèÿ çàïàñàìè ñ ó÷åòîì óáûòêîâ îò
íåóäîâëåòâîðåííîãî ñïðîñà.', 'Ïðàêòè÷åñêèé'),
('2', 'Ôîðìóëà îïðåäåëåíèÿ îïòèìàëüíîãî îáúåìà çàïàñà ñ ó÷åòîì óáûòêîâ
îò íåóäîâëåòâîðåííîãî ñïðîñà.', 'Ïðàêòè÷åñêèé'),
('2', 'Îïðåäåëåíèå ñåòåâîé ìîäåëè ñòðîèòåëüñòâà è åå îòëè÷èå îò
òðàäèöèîííîãî ëèíåéíîãî êàëåíäàðíîãî ãðàôèêà.', 'Ïðàêòè÷åñêèé'),
('2', 'Îïðåäåëåíèÿ îñíîâíûì ýëåìåíòàì ñåòåâîé ìîäåëè: ñîáûòèå, ðàáîòà,
ïóòü è èõ õàðàêòåðèñòèêè.', 'Ïðàêòè÷åñêèé'),
('2', 'Îñíîâíûå ôîðìû ñåòåâûõ ìîäåëåé.', 'Ïðàêòè÷åñêèé'),
('2', 'Äîñòîèíñòâà è íåäîñòàòêè ôîðì ñåòåâûõ ìîäåëåé.', 'Ïðàêòè÷åñêèé'),
('2', 'Ïîñëåäîâàòåëüíîñòü ïîñòðîåíèÿ ñåòåâîãî ãðàôèêà ñòðîèòåëüñòâà
òðàíñïîðòíîãî ñîîðóæåíèÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Îïðåäåëåíèå ïîíÿòèÿ «êðèòè÷åñêèé ïóòü» è «êðèòè÷åñêàÿ çîíà» íà
ñåòåâîé ìîäåëè.', 'Ïðàêòè÷åñêèé'),
('2', 'Êîýôôèöèåíò íàïðÿæåííîñòè ðàáîò, ïóòåé è êàê îí ðàññ÷èòûâàåòñÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Îòëè÷èå âåðîÿòíîñòíûõ ñåòåâûõ ìîäåëåé îò äåòåðìèíèðîâàííûõ.', 'Ïðàêòè÷åñêèé'),
('2', 'Çàâèñèìîñòü äëÿ ðàñ÷åòà âåðîÿòíîñòè çàâåðøåíèÿ ðàáîò ïî ñåòåâîìó
ãðàôèêó â çàäàííûå ñðîêè.', 'Ïðàêòè÷åñêèé'),
('2', 'Êàê ðàññ÷èòàòü òðåáóåìûé ðåçåðâ âðåìåíè íà ñåòåâîì ãðàôèêå, åñëè
âåðîÿòíîñòü ñâîåâðåìåííîãî çàâåðøåíèÿ ñòðîèòåëüñòâà çàäàíà, à ðàñ÷åòíûé ñðîê
îêîí÷àíèÿ ðàáîò ïî ãðàôèêó èçâåñòåí.', 'Ïðàêòè÷åñêèé'),
('2', 'Îïðåäåëåíèå òåðìèíà «íàäåæíîñòü òðàíñïîðòíîãî ñîîðóæåíèÿ».', 'Ïðàêòè÷åñêèé'),
('2', 'Ñòàòèñòè÷åñêèé ó÷åò è ñòàòèñòè÷åñêèé àíàëèç â ðàáîòå òðàíñïîðòíîãî
ñîîðóæåíèÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ïîñëåäîâàòåëüíîñòü îáðàáîòêè ñòàòèñòè÷åñêèõ äàííûõ î ðàáîòå
òðàíñïîðòíîãî ñîîðóæåíèÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ðîëü ñòàòèñòè÷åñêîãî àíàëèçà â ïðîåêòèðîâàíèè òðàíñïîðòíîãî
ñîîðóæåíèÿ ñ çàäàííîé íàäåæíîñòüþ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóòü ïðîãíîçèðîâàíèÿ íà îñíîâå ñòàòèñòè÷åñêîãî àíàëèçà.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóùíîñòü ñòàòèñòè÷åñêîãî êîíòðîëÿ êà÷åñòâà.', 'Ïðàêòè÷åñêèé'),
('2', 'Êðèòåðèè ñóùåñòâîâàíèÿ ñòàòèñòè÷åñêîãî òðåíäà.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóòü ìåòîäèêè ïðîâåðêè ãèïîòåçû î íàëè÷èè âðåìåííîãî òðåíäà íà
îñíîâå ðàçíîñòè ñðåäíèõ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ñóòü ñãëàæèâàíèÿ ñòàòèñòè÷åñêèõ äàííûõ. Êàêèå ìåòîäû
ñòàòèñòè÷åñêîãî ñãëàæèâàíèÿ ñóùåñòâóþò.', 'Ïðàêòè÷åñêèé'),
('2', 'Îñíîâíûå ìåòîäû ïîëó÷åíèÿ îïòèìàëüíûõ ìîäåëåé ñ ïðèìåíåíèåì
ìîäåëåé ëèíåéíîãî ïðîãðàììèðîâàíèÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ïðèìåðû çàäà÷ â äîðîæíîé îòðàñëè, ðåøàåìûå ñ ïðèìåíåíèåì
ìîäåëåé ëèíåéíîãî ïðîãðàììèðîâàíèÿ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ýêñòðåìàëüíûé àíàëèç â ýêîíîìè÷åñêèõ çàäà÷àõ.', 'Ïðàêòè÷åñêèé'),
('2', 'Ýôôåêòèâíîñòü îðãàíèçàöèîííîé ñòðóêòóðû è âèäû ýôôåêòèâíîñòè.', 'Ïðàêòè÷åñêèé'),
('2', 'Ïîñëåäîâàòåëüíîñòü ðåøåíèÿ çàäà÷è àäàïòàöèè ñòðóêòóð.', 'Ïðàêòè÷åñêèé'),
--ÌÄÊ.02.01. Èíôîêîììóíèêàöèîííûå ñèñòåìû è ñåòè òåîðåòè÷åñêèå âîïðîñû
('3', 'Ñôîðìóëèðîâàòü ñîîòíîøåíèå îïåðàöèé ðåëÿöèîííîé àëãåáðû è âûðàæåíèé ðåëÿöèîííîãî èñ÷èñëåíèÿ.
Ïåðå÷èñëèòü ñïåöèàëüíûå ðåëÿöèîííûå îïåðàöèè ðåëÿöèîííîé àëãåáðû.
Äàòü òî÷íîå è ïîëíîå îïðåäåëåíèå êàæäîé ñïåöèàëüíîé ðåëÿöèîííîé îïåðàöèè.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñôîðìóëèðîâàòü îïðåäåëåíèå ïðîöåññà íîðìàëèçàöèè.
Äàòü òî÷íîå è ïîëíîå îïðåäåëåíèå íîðìàëüíîé ôîðìû.
Ïåðå÷èñëèòü ñâîéñòâà íîðìàëüíûõ ôîðì.', 'Òåîðåòè÷åñêèé'),
('3', 'Äàòü îïðåäåëåíèå èçáûòî÷íûõ äàííûõ.
Ðàññìîòðåòü íà ïðèìåðå àíîìàëèè âñòàâêè,
óäàëåíèÿ, ìîäèôèêàöèè.
Ðàññìîòðåòü ñïîñîáû óñòðàíåíèÿ àíîìàëèé è èçáûòî÷íîñòè äàííûõ.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñôîðìóëèðîâàòü îñíîâíûå ñâîéñòâà íîðìàëüíûõ ôîðì.
Äàòü îïðåäåëåíèå ôóíêöèîíàëüíîé çàâèñèìîñòè àòðèáóòîâ îò ïåðâè÷íîãî êëþ÷à.
Äàòü îïðåäåëåíèå ôóíêöèîíàëüíî ïîëíîé çàâèñèìîñòè àòðèáóòîâ
îò ïåðâè÷íîãî êëþ÷à.', 'Òåîðåòè÷åñêèé'),
('3', 'Äàòü îïðåäåëåíèå 1 íîðìàëüíîé ôîðìû.
Äàòü îïðåäåëåíèå 2 íîðìàëüíîé ôîðìû.
Äàòü îïðåäåëåíèå 3 íîðìàëüíîé ôîðìû.', 'Òåîðåòè÷åñêèé'),
('3', 'Ïðèìåíåíèå èíôîðìàöèîííûõ ñåòåé.', 'Òåîðåòè÷åñêèé'),
('3', 'Êëàññèôèêàöèÿ èíôîðìàöèîííûõ ñåòåé ïî ðàçìåðó.', 'Òåîðåòè÷åñêèé'),
('3', 'Êëàññèôèêàöèÿ èíôîðìàöèîííûõ ñåòåé ïî òèïó òîïîëîãèè.', 'Òåîðåòè÷åñêèé'),
('3', 'Êëàññèôèêàöèÿ èíôîðìàöèîííûõ ñåòåé ïî òèïó ôóíêöèîíàëüíîãî
âçàèìîäåéñòâèÿ.', 'Òåîðåòè÷åñêèé'),
('3', 'Êëàññèôèêàöèÿ èíôîðìàöèîííûõ ñåòåé ïî òèïó òåõíîëîãèè, ñðåäû è ñêîðîñòè
ïåðåäà÷è.', 'Òåîðåòè÷åñêèé'),
('3', 'Ýòàëîííûå ìîäåëè ñåòè. Ïðîòîêîë è ñòåê ïðîòîêîëîâ.', 'Òåîðåòè÷åñêèé'),
('3', 'Ýòàëîííûå ìîäåëè ñåòè. Ýòàëîííàÿ ìîäåëü OSI.', 'Òåîðåòè÷åñêèé'),
('3', 'Ýòàëîííûå ìîäåëè ñåòè. Ýòàëîííàÿ ìîäåëü TCP/IP.', 'Òåîðåòè÷åñêèé'),
('3', 'Ýòàëîííûå ìîäåëè ñåòè. Ãèáðèäíàÿ ýòàëîííàÿ ìîäåëü.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñåòåâûå óñòðîéñòâà è ñåòåâûå àäàïòåðû. Ïàññèâíûå ñåòåâûå óñòðîéñòâà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñåòåâûå óñòðîéñòâà è ñåòåâûå àäàïòåðû. Àêòèâíûå ñåòåâûå óñòðîéñòâà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ëèíèè è êàíàëû ñâÿçè. Òèïû êàíàëîâ. Ïåðâè÷íûå è âòîðè÷íûå ñåòè.', 'Òåîðåòè÷åñêèé'),
('3', 'Êàáåëüíûå ëèíèè ñâÿçè. Âèòàÿ ïàðà.', 'Òåîðåòè÷åñêèé'),
('3', 'Êàáåëüíûå ëèíèè ñâÿçè. Êîàêñèàëüíûé êàáåëü.', 'Òåîðåòè÷åñêèé'),
('3', 'Êàáåëüíûå ëèíèè ñâÿçè. Îïòîâîëîêîííûé êàáåëü.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå ëèíèè ñâÿçè. Ðàäèîñâÿçü. Ñïóòíèêîâàÿ ñâÿçü.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Ìåòîä äîñòóïà CSMA/CD è ìàðêåðíûé äîñòóï.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèÿ Ethernet. Ôîðìàò êàäðà Ethernet.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèÿ Ethernet. Ñïåöèôèêàöèÿ Ethernet
10Base-5.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèÿ Ethernet. Ñïåöèôèêàöèÿ Ethernet
10Base-2.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèÿ Ethernet. Ñïåöèôèêàöèè Ethernet
10Base-T è Ethernet 10Base-FL.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèÿ Ethernet. Ñïåöèôèêàöèè Fast Ethernet.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèÿ Ethernet. Ñïåöèôèêàöèè Gigabit
Ethernet..', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèÿ Ethernet. Ñïåöèôèêàöèè 10Gigabit
Ethernet.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçîâûå ñåòåâûå òåõíîëîãèè. Òåõíîëîãèè Token Ring è FDDI.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå òåõíîëîãèè. Bluetooth. Àðõèòåêòóðà Bluetooth.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå òåõíîëîãèè. Bluetooth. Ïåðåäà÷à äàííûõ â Bluetooth.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå òåõíîëîãèè. Bluetooth. Ïðîôèëè Bluetooth.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå òåõíîëîãèè. Bluetooth. Ñïåöèôèêàöèè Bluetooth.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå òåõíîëîãèè. Wi-Fi. Àðõèòåêòóðà Wi-Fi.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå òåõíîëîãèè. Wi-Fi. Ñòàíäàðòû Wi-Fi.', 'Òåîðåòè÷åñêèé'),
('3', 'Áåñïðîâîäíûå òåõíîëîãèè. Wi-Fi. Ìåòîä äîñòóïà CSMA/CA è ïðîáëåìà
ñêðûòîãî óçëà.', 'Òåîðåòè÷åñêèé'),
('3', 'Àäðåñàöèÿ â èíôîðìàöèîííûõ ñåòÿõ. MAC-àäðåñ.', 'Òåîðåòè÷åñêèé'),
('3', 'Àäðåñàöèÿ â èíôîðìàöèîííûõ ñåòÿõ. IP-àäðåñ. Êëàññîâàÿ àäðåñàöèÿ..', 'Òåîðåòè÷åñêèé'),
('3', 'Àäðåñàöèÿ â èíôîðìàöèîííûõ ñåòÿõ. IP-àäðåñ. Áåñêëàññîâàÿ àäðåñàöèÿ.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Ïóáëè÷íûå è ÷àñòíûå àäðåñà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Øèðîêîâåùàòåëüíûå àäðåñà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Ãðóïïîâûå àäðåñà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Àäðåñ îáðàòíîé ïåòëè.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Àäðåñà IPv4, îòîáðàæåííûå â IPv6.', 'Òåîðåòè÷åñêèé'),
('3', 'Ôîðìàò IP-ïàêåòà. Çàãîëîâîê ïàêåòà IPv4.', 'Òåîðåòè÷åñêèé'),
('3', 'Ôîðìàò IP-ïàêåòà. Çàãîëîâîê ïàêåòà IPv6.', 'Òåîðåòè÷åñêèé'),
('3', 'Àäðåñàöèÿ â èíôîðìàöèîííûõ ñåòÿõ. Ñèñòåìà äîìåííûõ èìåí.', 'Òåîðåòè÷åñêèé'),
('3', 'Àäðåñàöèÿ â èíôîðìàöèîííûõ ñåòÿõ. IP-àäðåñ. Êëàññîâàÿ àäðåñàöèÿ.', 'Òåîðåòè÷åñêèé'),
('3', 'Àäðåñàöèÿ â èíôîðìàöèîííûõ ñåòÿõ. IP-àäðåñ. Áåñêëàññîâàÿ àäðåñàöèÿ.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Ïóáëè÷íûå è ÷àñòíûå àäðåñà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Øèðîêîâåùàòåëüíûå àäðåñà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Ãðóïïîâûå àäðåñà.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Àäðåñ îáðàòíîé ïåòëè.', 'Òåîðåòè÷åñêèé'),
('3', 'Ñïåöèàëüíûå IP-àäðåñà. Àäðåñà IPv4, îòîáðàæåííûå â IPv6.', 'Òåîðåòè÷åñêèé'),
('3', 'Ôîðìàò IP-ïàêåòà. Çàãîëîâîê ïàêåòà IPv4.', 'Òåîðåòè÷åñêèé'),
('3', 'Ôîðìàò IP-ïàêåòà. Çàãîëîâîê ïàêåòà IPv6.', 'Òåîðåòè÷åñêèé'),
('3', 'Àäðåñàöèÿ â èíôîðìàöèîííûõ ñåòÿõ. Ñèñòåìà äîìåííûõ èìåí.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçà äàííûõ DNS. Çàïèñü SOA.', 'Òåîðåòè÷åñêèé'),
('3', 'Áàçà äàííûõ DNS. Çàïèñè A è PTR.', 'Òåîðåòè÷åñêèé'),
--ÌÄÊ.02.01. Èíôîêîììóíèêàöèîííûå ñèñòåìû è ñåòè ïðàêòè÷åñêèå âîïðîñû
('3', 'Ìîíòàæ êàáåëüíûõ ñðåä òåõíîëîãèé Ethernet', 'Ïðàêòè÷åñêèé'),
('3', 'Îòñëåæèâàíèå ïðîõîæäåíèÿ ïàêåòîâ ÷åðåç ñåòü', 'Ïðàêòè÷åñêèé'),
('3', 'Ðàçáèåíèå ñåòè íà ïîäñåòè', 'Ïðàêòè÷åñêèé'),
('3', 'Îïðåäåëåíèå ìàðøðóòîâ ñëåäîâàíèÿ äàííûõ â ñåòè', 'Ïðàêòè÷åñêèé'),
('3', 'Îïðåäåëåíèå îáîðóäîâàíèÿ, óäîâëåòâîðÿþùåãî òðåáîâàíèÿì çàêàç÷èêà', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîë DNS. Çàãîëîâîê è áëîêè äàííûõ â ñîîáùåíèè DNS-ïàêåòà', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîë DHCP. Àðåíäà IP-àäðåñà', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîë ARP. Îïðåäåëåíèå MAC-àäðåñà äëÿ çàäàííîãî IP-àäðåñà', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîë ICMP. Ýõî-ñîîáùåíèÿ', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîë ICMP. Íåäîñòèæèìîñòü óçëà íàçíà÷åíèÿ', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîë ICMP. Îïðåäåëåíèå MAC-àäðåñà äëÿ çàäàííîãî àäðåñà IPv6', 'Ïðàêòè÷åñêèé'),
('3', 'Îáúåäèíåíèå ñåòåé ñ ïîìîùüþ ìîñòîâ. Ïðîçðà÷íîå ìîñòîâîå ñîåäèíåíèå', 'Ïðàêòè÷åñêèé'),
('3', 'Ïåòëè â ñåòÿõ, îáúåäèíåííûõ ñ ïîìîùüþ ìîñòîâ', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîë ñâÿçóþùåãî äåðåâà', 'Ïðàêòè÷åñêèé'),
('3', 'Îáúåäèíåíèå ñåòåé ñ ïîìîùüþ ìàðøðóòèçàòîðîâ. Àëãîðèòìû ìàðøðóòèçàöèè', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîëû ìàðøðóòèçàöèè. Ïðîòîêîë RIPv1', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîëû ìàðøðóòèçàöèè. Ïðîòîêîë RIPv2', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîëû ìàðøðóòèçàöèè. Ïðîòîêîë RIPng.', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîëû ìàðøðóòèçàöèè. Ïðîòîêîë OSPF', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðîòîêîëû ìàðøðóòèçàöèè. Âíåøíèå øëþçîâûå ïðîòîêîëû', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðåîáðàçîâàíèå ñåòåâûõ àäðåñîâ. Ïðåîáðàçîâàíèå âíóòðåííèõ àäðåñîâ', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðåîáðàçîâàíèå ñåòåâûõ àäðåñîâ. Ïåðåãðóçêà ãëîáàëüíûõ àäðåñîâ', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðåîáðàçîâàíèå ñåòåâûõ àäðåñîâ. Ïðåîáðàçîâàíèå ïðè ïåðåêðûòèè àäðåñîâ', 'Ïðàêòè÷åñêèé'),
('3', 'Òðàíñïîðòíûå ïðîòîêîëû TCP/IP. Ïîðòû.', 'Ïðàêòè÷åñêèé'),
('3', 'Òðàíñïîðòíûå ïðîòîêîëû TCP/IP. UDP-äåéòàãðàììà.', 'Ïðàêòè÷åñêèé'),
('3', 'Òðàíñïîðòíûå ïðîòîêîëû TCP/IP. Óñòàíîâëåíèå è çàâåðøåíèå TCP-ñîåäèíåíèÿ.', 'Ïðàêòè÷åñêèé'),
('3', 'Òðàíñïîðòíûå ïðîòîêîëû TCP/IP. Ñîñòîÿíèÿ TCP-ñîåäèíåíèÿ.', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðèêëàäíûå ïðîòîêîëû TCP/IP. Ïðîòîêîë FTP.', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðèêëàäíûå ïðîòîêîëû TCP/IP. Ïðîòîêîë HTTP.', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðèêëàäíûå ïðîòîêîëû TCP/IP. Ïðîòîêîë SMTP.', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðèêëàäíûå ïðîòîêîëû TCP/IP. Ïðîòîêîë POP3.', 'Ïðàêòè÷åñêèé'),
('3', 'Ïðèêëàäíûå ïðîòîêîëû TCP/IP. Ïðîòîêîë TELNET', 'Ïðàêòè÷åñêèé'),
('3', 'Àäìèíèñòðèðîâàíèå èíôîðìàöèîííûõ ñåòåé. Çàäà÷è ñèñòåì óïðàâëåíèÿ ñåòÿìè.', 'Ïðàêòè÷åñêèé'),
--ÌÄÊ.02.02. Òåõíîëîãèÿ ðàçðàáîòêè è çàùèòû áàç äàííûõ òåîðåòè÷åñêèå âîïðîñû
('4', 'Äàòü îïðåäåëåíèå ÑÓÁÄ.
Ïåðå÷èñëèòü è êðàòêî îõàðàêòåðèçîâàòü îñíîâíûå ôóíêöèè ÑÓÁÄ.
Ïåðå÷èñëèòü îñíîâíûå ýëåìåíòû òèïîâîé îðãàíèçàöèè ÑÓÁÄ.', 'Òåîðåòè÷åñêèé'),
('4', 'Ïðèâåñòè ïðèìåðû ñîâðåìåííûõ ÑÓÁÄ.
Ïåðå÷èñëèòü è îõàðàêòåðèçîâàòü îñíîâíûå ôóíêöèè ñîâðåìåííûõ ÑÓÁÄ.
Ïåðå÷èñëèòü îñíîâíûå ýëåìåíòû òèïîâîé îðãàíèçàöèè ÑÓÁÄ.', 'Òåîðåòè÷åñêèé'),
('4', 'Ïåðå÷èñëèòü îñíîâíûå ìîäåëè äàííûõ.
Ïðîàíàëèçèðîâàòü äîñòîèíñòâà è íåäîñòàòêè êàæäîé ìîäåëè.
Ñôîðìóëèðîâàòü ïðåèìóùåñòâà ðåëÿöèîííîé ìîäåëè.', 'Òåîðåòè÷åñêèé'),
('4', 'Ñôîðìóëèðîâàòü äîñòîèíñòâà è íåäîñòàòêè ðåëÿöèîííîé ìîäåëè äàííûõ.
Äàòü îïðåäåëåíèå îòíîøåíèÿ.
Ïåðå÷èñëèòü è êðàòêî îõàðàêòåðèçîâàòü ôóíäàìåíòàëüíûå ñâîéñòâà îòíîøåíèé.', 'Òåîðåòè÷åñêèé'),
('4', 'Äàòü îïðåäåëåíèå îòíîøåíèÿ.
Ïåðå÷èñëèòü è êðàòêî îõàðàêòåðèçîâàòü ôóíäàìåíòàëüíûå ñâîéñòâà îòíîøåíèé.
Äàòü îïðåäåëåíèÿ ýëåìåíòîâ îòíîøåíèÿ:
ïåðâè÷íûé êëþ÷, êîðòåæ, àòðèáóò, ñõåìà îòíîøåíèÿ, âíåøíèé êëþ÷.', 'Òåîðåòè÷åñêèé'),
--ÌÄÊ.02.02. Òåõíîëîãèÿ ðàçðàáîòêè è çàùèòû áàç äàííûõ ïðàêòè÷åñêèå âîïðîñû
('4', 'Ïðîåêòèðîâàíèå ðåëÿöèîííîé ñõåìû áàçû
äàííûõ â ñðåäå ÑÓÁÄ.', 'Ïðàêòè÷åñêèé'),
('4', 'Ñîçäàíèå áàçû äàííûõ â ñðåäå
ðàçðàáîòêè', 'Ïðàêòè÷åñêèé'),
('4', 'Âûïîëíåíèå ðåçåðâíîãî êîïèðîâàíèÿ', 'Ïðàêòè÷åñêèé'),
('4', '«Âîññòàíîâëåíèå áàçû äàííûõ èç
ðåçåðâíîé êîïèè', 'Ïðàêòè÷åñêèé'),
('4', 'Óñòàíîâêà ïðèîðèòåòîâ', 'Ïðàêòè÷åñêèé'),
--ÎÃÑÝ.03. Èíîñòðàííûé ÿçûê òåîðåòè÷åñêèå âîïðîñû
('5', 'Present Continuous â óòâåðäèòåëüíîé è îòðèöàòåëüíîé ôîðìå', 'Òåîðåòè÷åñêèå'),
('5', 'Òèïû âîïðîñîâ', 'Òåîðåòè÷åñêèå'),
('5', 'Present Simple : îáðàçîâàíèå, óïîòðåáëåíèå.', 'Òåîðåòè÷åñêèå'), 
('5', 'Present Continuous : îáðàçîâàíèå, óïîòðåáëåíèå.', 'Òåîðåòè÷åñêèå'), 
('5', 'Ïðèìåðû ìîäàëüíûõ ãëàãîëîâ ñ ïåðåâîäîì', 'Òåîðåòè÷åñêèå'),
--ÎÃÑÝ.03. Èíîñòðàííûé ÿçûê ïðàêòè÷åñêèå âîïðîñû
('5', 'Ïîðÿäîê ñëîâ â ïðîñòîì ïðåäëîæåíèè.', 'Ïðàêòè÷åñêèé'),
('5', 'Èñïðàâüòå îøèáêè â òåêñòå', 'Ïðàêòè÷åñêèé'),
('5', 'Ïåðåâîä ïðåäëîæåíèé ñ there is, there are.', 'Ïðàêòè÷åñêèé'),
('5', 'Íåîïðåäåë¸ííûé àðòèêëü', 'Ïðàêòè÷åñêèé'),
('5', 'Âñïîìîãàòåëüíûå ãëàãîëû â àíãëèéñêîì ÿçûêå', 'Ïðàêòè÷åñêèé');
--DELETE FROM Tickets;
INSERT INTO Tickets (nom_quetion_in_ticket, id_question, nom_komplect)
VALUES ('1', '1', '1'),
('2', '2', '2'),
('3', '3', '3'),
('4', '4', '4'),
('5', '5', '5');

--DELETE FROM Users;
INSERT INTO Users (login_, password_, role_)
VALUES ('Consta', '34', 'User'),
('Nohcha', '11','User'),
('Alex', '12','Admin'),
('Elena', '13','Admin'),
('Parampampam', '14','User');