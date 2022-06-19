 /*1. Sa se afiseze numele, echipa, numarul de pe tricou si sponsorul jucatorilor care activeaza la o echipa care a terminat pe primul loc in campionatul din Romania si care au o clauza de reziliere activa in contractul cu sponsorii lor. Acestia vor fi si ordonati crescator dupa numarul de pe tricou.
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








/*
 Division
 1. Sa se obtina numele sponsorilor care au contracte cu toti jucatorii care evolueaza in poarta.
 */
SELECT s."SponsorName" FROM "Deal" d
JOIN "Sponsor" s on (s."SponsorID" = d."SponsorID")
WHERE d."PlayerID" in
      (
          SELECT "PlayerID"
          FROM "Player"
          WHERE "PlayerPosition" = 'GK'
          )
GROUP BY s."SponsorName"
HAVING COUNT(d."PlayerID") = (
    SELECT COUNT(*)
    FROM "Player"
    WHERE "PlayerPosition" = 'GK'
    );


/*
 2. Sa se obtina numele ligilor care sunt transmise pe toate canalele care contin 'Sport' in nume
 */

SELECT b."BroadcasterName" FROM "Livestream" l
JOIN "Broadcaster" b on (b."BroadcasterID" = l."BroadcasterID")
WHERE l."BroadcasterID" in
      (
          SELECT "BroadcasterID"
          FROM "Broadcaster"
          WHERE "BroadcasterName" LIKE '%Sport%'
          )
GROUP BY b."BroadcasterName"
HAVING COUNT(l."BroadcasterID") = (
    SELECT COUNT(*)
    FROM "Broadcaster"
    WHERE "BroadcasterName" LIKE '%Sport%'
    )
