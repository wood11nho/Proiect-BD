/*1. Sa se afiseze numele, echipa, numarul de pe tricou si sponsorul jucatorilor care activeaza la o echipa care a terminat pe primul loc in
  campionatul din Romania si care au o clauza de reziliere activa in contractul cu sponsorii lor. Acestia vor fi si
  ordonati crescator dupa numarul de pe tricou.
 */

WITH clasament as(
    SELECT r."Points",r."TeamID" FROM "Ranking" r
    LEFT OUTER JOIN "League" l on (l."LeagueCountry" = 'Romania')
)
SELECT p."PlayerName", t1."TeamName", p."JerseyNumber", s."SponsorName" from "Player" p
FULL OUTER JOIN "Team" t1 on (t1."TeamID" = p."TeamID")
FULL OUTER JOIN "Deal" d on (d."PlayerID" = p."PlayerID")
FULL OUTER JOIN "Contract" c on (c."ContractID" = d."ContractID")
FULL OUTER JOIN "Sponsor" s on (s."SponsorID" = d."SponsorID")
WHERE t1."TeamID" =
(
    SELECT t."TeamID" from "Team" t
    FULL OUTER JOIN clasament c on (t."TeamID" = c."TeamID")
    WHERE c."Points" = (
                        SELECT MAX(c1."Points") FROM clasament c1
                        )
)
AND
    c."ClauzaReziliere" = 1
ORDER BY p."JerseyNumber";



/* 2. Sa se afiseze comentatorii al caror nume incepe cu litera D, iar postul de televiziune la care lucreaza sa
   fii avut vreodata un contract de minim 2 ani. Daca nu exista, se va afisa mesajul "Nu exista".
 */

WITH aux as(
    select l1."EndDate" - l1."StartDate" AS suma, l1."StartDate", l1."EndDate", b."CommentatorName" from "Livestream" l1
    FULL OUTER JOIN "Broadcaster" b on (b."BroadcasterID" = l1."BroadcasterID")
    WHERE EXTRACT(YEAR FROM l1."EndDate") - EXTRACT(YEAR FROM l1."StartDate") >= 2
    and SUBSTR(b."CommentatorName",0,1) = 'D'
)
SELECT COUNT(suma) as Numar_Contracte,
CASE
    WHEN COUNT(suma) >= 1 THEN "CommentatorName"
    ELSE 'Nu exista'
END AS Comentator
FROM aux
group by "CommentatorName";

/*
 3. Sa se afiseze mesajul 'Fara Antrenor' pentru echipele care nu au un manager principal si, in functie de cate stele
 UEFA are stadionul acesteia, se vor afisa alte mesaje relevante.
 */
SELECT t."TeamName",
       NVL(m."ManagerName", 'Fara Antrenor') as Antrenor,
       DECODE(s."UefaStars",
           1, 'Stadion in pericol de demolare',
           2, 'Stadion mediocru spre acceptabil',
           3, 'Stadion cochet',
           4, 'Stadion modern',
           5, 'Stadion de ultima generatie') as Calitate_Stadion
       from "Team" t
FULL OUTER JOIN "Manager" m on (m."TeamID" = t."TeamID")
FULL OUTER JOIN "Stadium" s on (s."TeamID" = t."TeamID")
where t."TeamID" not in
        (
        SELECT m1."TeamID" FROM "Manager" m1
        );

/*
 4.Sa se afiseze toate echipele de club care au mai mult de 10 angajati, numarul de angajati si salariul mediu
 al angajatilor din club
 */

SELECT t."TeamName", COUNT(e."EmployeeID") as NumarAngajati, ROUND(AVG(j."JobSalary"), 2) as SalariuMediu from "Team" t
FULL OUTER JOIN "Employee" e on (e."TeamID" = t."TeamID")
FULL OUTER JOIN "Job" j on (j."JobID" = e."JobID")
group by t."TeamName"
having COUNT(e."EmployeeID") > 10
order by NumarAngajati;


/*
 5. Sa se afiseze datele despre stadion si echipele al caror stadion are mai multe locuri decat
 media locurilor tuturor stadioanelor construite in acelasi secol, iar cuvantul din limba romana sa se inlocuiasca cu
 traducerea sa in engleza
 */
SELECT REPLACE("StadiumName", 'Stadionul', 'Stadium'), t."TeamName", "BuildingYear", "StadiumCapacity" from "Stadium" s
FULL OUTER JOIN "Team" t on (t."TeamID" = s."TeamID")
WHERE "StadiumCapacity" >
      (
          SELECT AVG("StadiumCapacity")
          FROM "Stadium"
          WHERE FLOOR("BuildingYear" / 100) * 100 = FLOOR(s."BuildingYear" / 100) * 100
          );