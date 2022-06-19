create table "League"
(
    "LeagueID"      int          not null
        constraint LEAGUE_PK
            primary key,
    "LeagueName"    varchar2(50) not null,
    "LeagueCountry" varchar2(50) not null
);

create unique index LEAGUE_LEAGUEID_UINDEX
    on "League" ("LeagueID");

create table "Team"
(
    "TeamID"         int          not null
        constraint TEAM_PK
            primary key,
    "TeamName"       varchar2(50) not null,
    "FoundationYear" int          not null,
    "LeagueID"       int          not null
);

create unique index TEAM_TEAMID_UINDEX
    on "Team" ("TeamID");
    
ALTER TABLE "Team"
ADD (CONSTRAINT  team_league_fk
    FOREIGN KEY ("LeagueID")
    REFERENCES "League"("LeagueID"));

CREATE TABLE "Ranking"
(
    "RankingID" int not null
        constraint RANKING_PK
            primary key,
    "Points"    int,
    "LeagueID"  int not null,
    "TeamID"    int not null
);

ALTER TABLE "Ranking"
ADD (CONSTRAINT ranking_league_fk
    FOREIGN KEY ("LeagueID")
    REFERENCES "League"("LeagueID"),
    CONSTRAINT ranking_team_fk
    FOREIGN KEY ("TeamID")
    REFERENCES "Team"("TeamID"));
    

create table "Stadium"
(
    "StadiumID"       int
        constraint STADIUM_PK
            primary key,
    "TeamID"          int          not null,
    "StadiumName"     varchar2(50) not null,
    "StadiumCapacity" int          not null,
    "BuildingYear"    int          not null,
    "UefaStars"       int          not null,
    "StadiumCity"     varchar2(50) not null
);

create unique index STADIUM_STADIUMID_UINDEX
    on "Stadium" ("StadiumID");

alter table "Stadium"
ADD (CONSTRAINT stadium_team_fk
    FOREIGN KEY ("TeamID")
    REFERENCES "Team"("TeamID"));

create table "Country"
(
    "CountryID"        int          not null
        constraint COUNTRY_PK
            primary key,
    "CountryName"      varchar2(50) not null,
    "CountryContinent" varchar2(50) not null
);

create table "Job"
(
    "JobID"     int          not null
        constraint JOB_PK
            primary key,
    "JobName"   varchar2(50) not null,
    "JobSalary" varchar2(50) not null
);

create table "Manager"
(
    "ManagerID"   int          not null
        constraint MANAGER_PK
            primary key,
    "CountryID"   int          not null,
    "TeamID"      int          not null,
    "ManagerName" varchar2(50) not null
);

alter table "Manager"
ADD (CONSTRAINT manager_country_fk
    FOREIGN KEY ("CountryID")
    REFERENCES "Country"("CountryID"),
    CONSTRAINT manager_team_fk
    FOREIGN KEY ("TeamID")
    REFERENCES "Team"("TeamID")
    );

create table "Employee"
(
    "EmployeeID"   int          not null
        constraint EMPLOYEE_PK
            primary key,
    "JobID"        int          not null,
    "CountryID"    int          not null,
    "TeamID"       int          not null,
    "EmployeeName" varchar2(50) not null
);

alter table "Employee"
ADD (CONSTRAINT employee_job_fk
    FOREIGN KEY ("JobID")
    REFERENCES "Job"("JobID"),
    CONSTRAINT employee_country_fk
    FOREIGN KEY ("EmployeeID")
    REFERENCES "Employee"("EmployeeID"),
    CONSTRAINT employee_team_fk
    FOREIGN KEY ("TeamID")
    REFERENCES "Team"("TeamID")
    );

create table "Player"
(
    "PlayerID"       int          not null
        constraint PLAYER_PK
            primary key,
    "TeamID"         int          not null,
    "CountryID"      int          not null,
    "PlayerName"     varchar2(50) not null,
    "PlayerPosition" varchar2(50) not null,
    "JerseyNumber"   int          not null
);

alter table "Player"
ADD(CONSTRAINT player_team_fk
    FOREIGN KEY ("TeamID")
    REFERENCES "Team"("TeamID"),
    CONSTRAINT player_country_fk
    FOREIGN KEY ("CountryID")
    REFERENCES "Country"("CountryID"));

create table "Sponsor"
(
    "SponsorID"   int          not null
        constraint SPONSOR_PK
            primary key,
    "SponsorName" varchar2(50) not null
);

create table "Contract"
(
    "ContractID"      int                  not null
        constraint CONTRACT_PK
            primary key,
    "ClauzaReziliere" int                  not null,
    "Years"           int                  not null
);



create table "Deal"
(
    "PlayerID"   int not null,
    "SponsorID"  int not null,
    "ContractID" int not null,
    constraint DEAL_PK
        primary key ("PlayerID", "SponsorID", "ContractID")
);

alter table "Deal"
ADD (CONSTRAINT deal_player_fk
    FOREIGN KEY ("PlayerID")
    REFERENCES "Player"("PlayerID"),
    CONSTRAINT deal_sponsor_fk
    FOREIGN KEY ("SponsorID")
    REFERENCES "Sponsor"("SponsorID"),
    CONSTRAINT deal_contract_fk
    FOREIGN KEY ("ContractID")
    REFERENCES "Contract"("ContractID")
    );


create table "Broadcaster"
(
    "BroadcasterID"   int          not null
        constraint BROADCASTER_PK
            primary key,
    "BroadcasterName" varchar2(50) not null,
    "CommentatorName" varchar2(50) not null
);

create table "Livestream"
(
    "LeagueID"    int not null,
    "BroadcasterID" int not null,
    "StartDate"       date         not null,
    "EndDate"         date         not null,
    constraint LIVESTREAM_PK
        primary key ("LeagueID", "BroadcasterID")
);

alter table "Livestream"
ADD (CONSTRAINT livestream_league_fk
    FOREIGN KEY ("LeagueID")
    REFERENCES "League"("LeagueID"),
    CONSTRAINT livestream_broadcast_fk
    FOREIGN KEY ("BroadcasterID")
    REFERENCES "Broadcaster"("BroadcasterID")
    );

CREATE SEQUENCE AUTO_ID
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE;

INSERT INTO "League"("LeagueID", "LeagueName", "LeagueCountry") VALUES (AUTO_ID.nextval, 'Liga 1 Betano','Romania');
INSERT INTO "League"("LeagueID", "LeagueName", "LeagueCountry") VALUES (AUTO_ID.nextval, 'La Liga Santander','Spania');
INSERT INTO "League"("LeagueID", "LeagueName", "LeagueCountry") VALUES (AUTO_ID.nextval, 'English Premier League','Anglia');
INSERT INTO "League"("LeagueID", "LeagueName", "LeagueCountry") VALUES (AUTO_ID.nextval, 'Ligue 1 UberEats','Franta');
INSERT INTO "League"("LeagueID", "LeagueName", "LeagueCountry") VALUES (AUTO_ID.nextval, 'Serie A TIM','Italia');
INSERT INTO "League"("LeagueID", "LeagueName", "LeagueCountry") VALUES (AUTO_ID.nextval, 'Bundesliga','Germania');

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'CFR Cluj', 1907, 1);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'FC Steaua Bucuresti', 1947, 1);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'CS Universitatea Craiova', 1948, 1);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'FC Dinamo Bucuresti', 1948, 1);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'Rapid Bucuresti', 1923, 1);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'SC Otelul Galati', 1964, 1);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'Real Madrid', 1902, 2);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'Liverpool', 1892, 3);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'PSG', 1907, 4);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'AC Milan', 1899, 5);
INSERT INTO "Team"("TeamID", "TeamName", "FoundationYear", "LeagueID")
            VALUES (AUTO_ID.nextval,'Borussia Dortmund', 1909, 6);

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO "Ranking"("RankingID", "Points", "LeagueID", "TeamID")
            VALUES(AUTO_ID.nextval, 57, 1, 1);
INSERT INTO "Ranking"("RankingID", "Points", "LeagueID", "TeamID")
            VALUES(AUTO_ID.nextval, 56, 1, 2);
INSERT INTO "Ranking"("RankingID", "Points", "LeagueID", "TeamID")
            VALUES(AUTO_ID.nextval, 48, 1, 3);
INSERT INTO "Ranking"("RankingID", "Points", "LeagueID", "TeamID")
            VALUES(AUTO_ID.nextval, 49, 1, 4);
INSERT INTO "Ranking"("RankingID", "Points", "LeagueID", "TeamID")
            VALUES(AUTO_ID.nextval, 45, 1, 5);
INSERT INTO "Ranking"("RankingID", "Points", "LeagueID", "TeamID")
            VALUES(AUTO_ID.nextval, 45, 1, 6);


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;


INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,4,'Stadionul Stefan cel Mare',15032,1952,2,'Bucuresti');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,2,'Stadionul Ghencea',31254,2021,4,'Bucuresti');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,1,'Stadionul Dr. Constantin Radulescu',22198,1973,3,'Cluj-Napoca');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,5,'Stadionul Giulesti',14047,2022,3,'Bucuresti');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,6,'Stadionul Otelul',13932,1982,2,'Galati');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,11,'Signal Iduna Park',81365,1974,5,'Dortmund');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,9,'Parc des Princes',47929,1972,5,'Paris');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,8,'Anfield Stadium',53594,1884,5,'Liverpool');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,7,'Stadio Bernabeu',81044,1947,5,'Madrid');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,10,'San Siro',80018,1926,5,'Milano');
INSERT INTO "Stadium"("StadiumID", "TeamID", "StadiumName", "StadiumCapacity", "BuildingYear", "UefaStars", "StadiumCity")
VALUES (AUTO_ID.nextval,3,'Stadionul Ion Oblemenco',30944,2017,4,'Craiova');

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Romania','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Coasta de Fildes','Africa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Italia','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Republica Moldova','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Brazilia','America');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Bosnia si Herzegovina','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Ghana','Africa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Islanda','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Franta','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Croatia','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Muntenegru','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Portugalia','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Argentina','America');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Bulgaria','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Macedonia de Nord','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Nigeria','Africa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Estonia','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Maroc','Africa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval,'Germania','Europa');

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 1, 'Dur-Bozoanca','GK',13);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 1, 'Ursu','GK',1);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 2, 'Yabre','DEF',15);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 1, 'Sirghi','DEF',33);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 1, 'Ghiocel','DEF', 16);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 1, 'Neagu','MID', 8);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 4, 'Jardan','MID',23);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 1, 'Nica','MID',11);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 3, 'Cisotti','ATT',30);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 1, 'Cirjan','ATT',7);
INSERT INTO "Player"("PlayerID", "TeamID", "CountryID", "PlayerName", "PlayerPosition", "JerseyNumber")
VALUES (AUTO_ID.nextval, 6, 4, 'Cricimari', 'ATT', 9);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Hindrich', 'GK', 89);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Balgradean', 'GK', 34);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Stefan', 'DEF', 78);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Camora', 'DEF', 45);
insert into "Player" values (AUTO_ID.nextval, 1, 5,'Yuri', 'DEF', 44);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Burca', 'DEF', 3);
insert into "Player" values (AUTO_ID.nextval, 1, 6,'Graovac', 'DEF', 6);
insert into "Player" values (AUTO_ID.nextval, 1, 6,'Susic', 'DEF', 16);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Manea', 'DEF', 4);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Deac', 'MID', 10);
insert into "Player" values (AUTO_ID.nextval, 1, 7,'Boateng', 'MID', 21);
insert into "Player" values (AUTO_ID.nextval, 1, 8,'Sigurjonsson', 'MID', 8);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Bordeianu', 'MID', 37);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Gidea', 'MID', 98);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Paun', 'MID', 7);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Costache', 'ATT', 18);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Petrila', 'ATT', 27);
insert into "Player" values (AUTO_ID.nextval, 1, 5,'Roger', 'ATT', 77);
insert into "Player" values (AUTO_ID.nextval, 1, 9,'Omrani', 'ATT', 9);
insert into "Player" values (AUTO_ID.nextval, 1, 10,'Dugandzic', 'ATT', 17);
insert into "Player" values (AUTO_ID.nextval, 1, 10,'Debeljuh', 'ATT', 22);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Negut', 'ATT', 75);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Birligea', 'ATT', 30);
insert into "Player" values (AUTO_ID.nextval, 1, 1,'Bus', 'ATT', 99);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Vlad', 'GK', 99);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Tarnovanu', 'GK', 32);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Straton', 'GK', 1);
insert into "Player" values (AUTO_ID.nextval, 2, 11,'Radunovic', 'DEF', 33);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Serban', 'DEF', 77);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Pantiru', 'DEF', 3);
insert into "Player" values (AUTO_ID.nextval, 2, 5,'Vinicius', 'DEF', 55);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Cristea', 'DEF', 17);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Miron', 'DEF', 4);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Cretu', 'DEF', 2);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Achim', 'DEF', 21);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Popescu', 'MID', 23);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Tanase', 'MID', 10);
insert into "Player" values (AUTO_ID.nextval, 2, 9,'Edjouma', 'MID', 18);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Perianu', 'MID', 25);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Sut', 'MID', 8);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Oaida', 'MID', 26);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Olaru', 'MID', 27);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Musi', 'MID', 30);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Popescu', 'ATT', 9);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Burlacu', 'ATT', 20);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Coman', 'ATT', 7);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Stoica', 'ATT', 19);
insert into "Player" values (AUTO_ID.nextval, 2, 10,'Mamut', 'ATT', 31);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Dumiter', 'ATT', 13);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Gheorghe', 'ATT', 22);
insert into "Player" values (AUTO_ID.nextval, 2, 1,'Cordea', 'ATT', 98);
insert into "Player" values (AUTO_ID.nextval, 3, 3,'Pigliacelli', 'GK', 13);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Lazar', 'GK', 1);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Bancu', 'DEF', 11);
insert into "Player" values (AUTO_ID.nextval, 3, 9,'Conte', 'DEF', 29);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Gaman', 'DEF', 25);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Papp', 'DEF', 2);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Constantin', 'DEF', 23);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Screciu', 'DEF', 6);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Vladoiu', 'DEF', 18);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Vatajelu', 'DEF', 5);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Mateiu', 'MID', 8);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Capatina', 'MID', 33);
insert into "Player" values (AUTO_ID.nextval, 3, 10,'Rogulic', 'MID', 24);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Bic', 'MID', 27);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Cretu', 'MID', 14);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Nistor', 'MID', 16);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Vina', 'MID', 10);
insert into "Player" values (AUTO_ID.nextval, 3, 9,'Houri', 'MID', 15);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Baiaram', 'ATT', 17);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Ivan', 'ATT', 9);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Markovic', 'ATT', 20);
insert into "Player" values (AUTO_ID.nextval, 3, 6,'Koljic', 'ATT', 19);
insert into "Player" values (AUTO_ID.nextval, 3, 1,'Cimpanu', 'ATT', 7);
insert into "Player" values (AUTO_ID.nextval, 3, 5,'Gustavo', 'ATT', 22);
insert into "Player" values (AUTO_ID.nextval, 4, 12,'Figueiredo', 'GK', 13);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Esanu', 'GK', 12);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Giafer', 'DEF', 24);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Ehmann', 'DEF', 6);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Carp', 'DEF', 71);
insert into "Player" values (AUTO_ID.nextval, 4, 10,'Jovanovic', 'DEF', 4);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Grigore', 'DEF', 27);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Tomozei', 'DEF', 26);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Patriche', 'DEF', 23);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Radu', 'DEF', 3);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Buleica', 'DEF', 77);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Rauta', 'MID', 5);
insert into "Player" values (AUTO_ID.nextval, 4, 13,'Rodriguez', 'MID', 18);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Matei', 'MID', 10);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Bani', 'MID', 38);
insert into "Player" values (AUTO_ID.nextval, 4, 14,'Ivanov', 'MID', 99);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Cretu', 'MID', 32);
insert into "Player" values (AUTO_ID.nextval, 4, 5,'deMoura', 'MID', 2);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Gradinaru', 'MID', 21);
insert into "Player" values (AUTO_ID.nextval, 4, 9,'Pierret', 'MID', 8);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Borcea', 'MID', 28);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Torje', 'ATT', 22);
insert into "Player" values (AUTO_ID.nextval, 4, 15,'Ivanovski', 'ATT', 44);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Bordusanu', 'ATT', 20);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Morar', 'ATT', 70);
insert into "Player" values (AUTO_ID.nextval, 4, 16,'Irobiso', 'ATT', 35);
insert into "Player" values (AUTO_ID.nextval, 4, 1,'Mihaiu', 'ATT', 98);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Moldovan', 'GK', 31);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Draghia', 'GK', 90);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Belu-Iordache', 'DEF', 77);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Sapunaru', 'DEF', 22);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Grigore', 'DEF', 27);
insert into "Player" values (AUTO_ID.nextval, 5, 5,'Junior-Morais', 'DEF', 11);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Dandea', 'DEF', 30);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Demici', 'DEF', 44);
insert into "Player" values (AUTO_ID.nextval, 5, 13,'Acuna', 'DEF', 21);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Goge', 'DEF', 13);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Onea', 'DEF', 19);
insert into "Player" values (AUTO_ID.nextval, 5, 17, 'Kait', 'MID', 14);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Albu', 'MID', 23);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Sefer', 'MID', 7);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Stahl', 'MID', 29);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Ilie', 'MID', 10);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Carnat', 'MID', 8);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Ionita', 'MID', 80);
insert into "Player" values (AUTO_ID.nextval, 5, 10,'Crepulja', 'MID', 4);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Hlistei', 'MID', 94);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Moise', 'MID', 20);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Panoiu', 'MID', 17);
insert into "Player" values (AUTO_ID.nextval, 5, 10,'Vojtus', 'ATT', 71);
insert into "Player" values (AUTO_ID.nextval, 5, 1,'Balan', 'ATT', 9);
insert into "Player" values (AUTO_ID.nextval, 5, 18,'Marzouk', 'ATT', 57);


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;


insert into "Broadcaster"("BroadcasterID", "BroadcasterName", "CommentatorName")
VALUES (AUTO_ID.nextval,'Digi Sport','Dan Stefanescu');
insert into "Broadcaster"("BroadcasterID", "BroadcasterName", "CommentatorName")
VALUES (AUTO_ID.nextval,'PROTV','Mihai Mironica');
insert into "Broadcaster"("BroadcasterID", "BroadcasterName", "CommentatorName")
VALUES (AUTO_ID.nextval,'TVR','Marian Oleianos');
insert into "Broadcaster"("BroadcasterID", "BroadcasterName", "CommentatorName")
VALUES (AUTO_ID.nextval,'LookTV','Emil Gradinescu');
insert into "Broadcaster"("BroadcasterID", "BroadcasterName", "CommentatorName")
VALUES (AUTO_ID.nextval,'Orange Sport','Bogdan Socol');
insert into "Broadcaster"("BroadcasterID", "BroadcasterName", "CommentatorName")
VALUES (AUTO_ID.nextval,'Eurosport','Emanuel Terzian');



insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (1,1,TO_DATE('2019-06-01','YYYY-MM-DD'), TO_DATE('2023-06-01','YYYY-MM-DD'));
insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (1,4,TO_DATE('2020-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));
insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (2,1,TO_DATE('2016-06-01','YYYY-MM-DD'), TO_DATE('2026-06-01','YYYY-MM-DD'));
insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (3,6,TO_DATE('2012-06-01','YYYY-MM-DD'), TO_DATE('2022-06-01','YYYY-MM-DD'));
insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (3,1,TO_DATE('2022-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));
insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (4,5,TO_DATE('2018-06-01','YYYY-MM-DD'), TO_DATE('2021-06-01','YYYY-MM-DD'));
insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (5,3,TO_DATE('2020-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));
insert into "Livestream"("LeagueID", "BroadcasterID", "StartDate", "EndDate")
VALUES (6,1,TO_DATE('2016-06-01','YYYY-MM-DD'), TO_DATE('2022-06-01','YYYY-MM-DD'));

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into "Sponsor"("SponsorID", "SponsorName") VALUES (AUTO_ID.nextval,'Nike');
insert into "Sponsor"("SponsorID", "SponsorName") VALUES (AUTO_ID.nextval,'Adidas');
insert into "Sponsor"("SponsorID", "SponsorName") VALUES (AUTO_ID.nextval,'Puma');
insert into "Sponsor"("SponsorID", "SponsorName") VALUES (AUTO_ID.nextval,'Under Armour');
insert into "Sponsor"("SponsorID", "SponsorName") VALUES (AUTO_ID.nextval,'Joma');
insert into "Sponsor"("SponsorID", "SponsorName") VALUES (AUTO_ID.nextval,'Umbro');


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 1, 1);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 1, 2);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 1, 3);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 1, 4);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 1, 5);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 0, 1);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 0, 2);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 0, 3);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 0, 4);
insert into "Contract"("ContractID", "ClauzaReziliere", "Years") VALUES (AUTO_ID.nextval, 0, 5);



insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(1, 5, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(2, 1, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(3, 3, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(4, 1, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(5, 6, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(6, 3, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(7, 1, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(8, 4, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(9, 1, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(10, 1, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(11, 5, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(12, 4, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(13, 1, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(14, 2, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(15, 2, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(16, 1, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(17, 3, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(18, 1, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(19, 2, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(20, 6, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(21, 3, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(22, 3, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(23, 1, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(24, 5, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(25, 5, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(26, 3, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(27, 2, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(28, 4, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(29, 1, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(30, 1, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(31, 1, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(32, 4, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(33, 4, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(34, 4, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(35, 6, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(36, 5, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(37, 6, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(38, 3, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(39, 6, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(40, 3, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(41, 4, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(42, 4, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(43, 5, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(44, 1, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(45, 4, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(46, 5, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(47, 5, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(48, 2, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(49, 2, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(50, 2, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(51, 5, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(52, 2, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(53, 5, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(54, 2, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(55, 3, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(56, 3, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(57, 5, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(58, 1, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(59, 1, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(60, 5, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(61, 2, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(62, 3, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(63, 3, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(64, 6, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(65, 4, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(66, 1, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(67, 2, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(68, 5, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(69, 1, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(70, 4, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(71, 2, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(72, 1, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(73, 2, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(74, 3, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(75, 2, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(76, 4, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(77, 6, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(78, 1, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(79, 2, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(80, 4, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(81, 5, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(82, 5, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(83, 6, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(84, 3, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(85, 5, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(86, 4, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(87, 1, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(88, 3, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(89, 3, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(90, 3, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(91, 2, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(92, 2, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(93, 6, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(94, 4, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(95, 3, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(96, 3, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(97, 5, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(98, 3, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(99, 4, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(100, 5, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(101, 3, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(102, 2, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(103, 5, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(104, 1, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(105, 5, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(106, 2, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(107, 5, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(108, 5, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(109, 5, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(110, 4, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(111, 2, 3);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(112, 3, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(113, 2, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(114, 3, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(115, 5, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(116, 3, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(117, 1, 9);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(118, 4, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(119, 2, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(120, 1, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(121, 1, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(122, 4, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(123, 1, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(124, 3, 1);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(125, 6, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(126, 1, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(127, 2, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(128, 4, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(129, 3, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(130, 5, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(131, 5, 8);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(132, 2, 4);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(133, 5, 6);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(134, 6, 5);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(135, 2, 2);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(136, 5, 7);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(137, 1, 10);
insert into "Deal"("PlayerID", "SponsorID", "ContractID") VALUES(138, 4, 10);


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,1,1,'Dan Petrescu');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,1,2,'Anton Petrea');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,1,3,'Laszlo Balint');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,1,5,'Adrian Mutu');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,1,6,'Dorinel Munteanu');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,3,7,'Carlo Ancelotti');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,19,8,'Jurgen Klopp');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,9,9,'Zinedine Zidane');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,3,10,'Stefano Pioli');
insert into "Manager"("ManagerID", "CountryID", "TeamID", "ManagerName") VALUES (AUTO_ID.nextval,10,11,'Edin Terzic');


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into "Job"("JobID", "JobName", "JobSalary") VALUES (AUTO_ID.nextval,'Preparator fizic',1500);
insert into "Job"("JobID", "JobName", "JobSalary") VALUES (AUTO_ID.nextval,'Medic',2500);
insert into "Job"("JobID", "JobName", "JobSalary") VALUES (AUTO_ID.nextval,'Copil de mingi',500);
insert into "Job"("JobID", "JobName", "JobSalary") VALUES (AUTO_ID.nextval,'Director tehnic',2500);
insert into "Job"("JobID", "JobName", "JobSalary") VALUES (AUTO_ID.nextval,'Administrator social media',1200);
insert into "Job"("JobID", "JobName", "JobSalary") VALUES (AUTO_ID.nextval,'Finantator',500);



DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into "Employee" VALUES(AUTO_ID.nextval,3, 7, 9, 'Steven');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 4, 9, 'Neena');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 4, 5, 'Lex');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 5, 5, 'Alexander');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 6, 4, 'Bruce');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 1, 3, 'David');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 7, 1, 'Valli');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 8, 2, 'Diana');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 17, 10, 'Nancy');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 7, 1, 'Daniel');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 3, 2, 'John');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 15, 4, 'Ismael');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 12, 8, 'Jose Manuel');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 5, 7, 'Luis');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 12, 6, 'Den');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 15, 6, 'Alexander');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 1, 9, 'Shelli');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 15, 10, 'Sigal');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 17, 8, 'Guy');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 4, 5, 'Karen');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 3, 5, 'Matthew');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 15, 10, 'Adam');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 11, 5, 'Payam');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 1, 2, 'Shanta');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 11, 5, 'Kevin');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 7, 8, 'Julia');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 10, 2, 'Irene');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 10, 2, 'James');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 15, 9, 'Steven');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 4, 7, 'Laura');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 8, 10, 'Mozhe');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 11, 3, 'James');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 11, 10, 'TJ');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 5, 6, 'Jason');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 11, 2, 'Michael');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 17, 5, 'Ki');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 12, 9, 'Hazel');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 12, 1, 'Renske');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 1, 1, 'Stephen');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 1, 6, 'John');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 12, 6, 'Joshua');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 10, 1, 'Trenna');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 14, 6, 'Curtis');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 13, 10, 'Randall');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 15, 9, 'Peter');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 11, 4, 'John');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 16, 3, 'Karen');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 11, 1, 'Alberto');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 3, 7, 'Gerald');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 3, 8, 'Eleni');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 16, 10, 'Peter');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 13, 6, 'David');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 13, 1, 'Peter');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 6, 8, 'Christopher');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 8, 1, 'Nanette');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 5, 7, 'Oliver');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 14, 5, 'Janette');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 16, 3, 'Patrick');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 17, 4, 'Allan');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 12, 2, 'Lindsey');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 12, 4, 'Louise');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 2, 4, 'Sarath');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 8, 8, 'Clara');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 6, 10, 'Danielle');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 8, 5, 'Mattea');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 10, 9, 'David');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 4, 5, 'Sundar');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 12, 9, 'Amit');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 4, 7, 'Lisa');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 16, 10, 'Harrison');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 8, 8, 'Tayler');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 10, 8, 'William');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 10, 5, 'Elizabeth');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 8, 7, 'Sundita');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 10, 3, 'Ellen');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 6, 7, 'Alyssa');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 13, 9, 'Jonathon');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 10, 2, 'Jack');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 8, 7, 'Kimberely');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 5, 4, 'Charles');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 3, 4, 'Winston');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 4, 2, 'Jean');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 17, 6, 'Martha');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 10, 3, 'Girard');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 7, 2, 'Nandita');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 4, 2, 'Alexis');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 16, 7, 'Julia');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 14, 5, 'Anthony');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 17, 4, 'Kelly');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 12, 5, 'Jennifer');
insert into "Employee" VALUES(AUTO_ID.nextval,2, 9, 9, 'Timothy');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 6, 9, 'Randall');
insert into "Employee" VALUES(AUTO_ID.nextval,4, 9, 3, 'Sarah');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 15, 6, 'Britney');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 8, 1, 'Samuel');
insert into "Employee" VALUES(AUTO_ID.nextval,3, 14, 3, 'Vance');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 4, 7, 'Alana');
insert into "Employee" VALUES(AUTO_ID.nextval,1, 9, 10, 'Kevin');
insert into "Employee" VALUES(AUTO_ID.nextval,6, 4, 4, 'Donald');
insert into "Employee" VALUES(AUTO_ID.nextval,5, 13, 10, 'Douglas');
