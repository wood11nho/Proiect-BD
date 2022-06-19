CREATE SEQUENCE AUTO_ID
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE;

INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval, 'Suedia','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval, 'Norvegia','Europa');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval, 'Mexic','America');
INSERT INTO "Country"("CountryID", "CountryName", "CountryContinent") VALUES (AUTO_ID.nextval, 'China','Asia');

DROP SEQUENCE AUTO_ID;
