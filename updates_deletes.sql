/* CERERI UPDATE SI SUPRIMARE */

/*
 1. Sa se modernizeze stadioanele care s-au construit mai devreme de anul 1950, cu o capacitate cu 10% mai mare
 decat cea a celui mai mare stadion si cu 5 stele UEFA
 */

update "Stadium"
set "StadiumCapacity" = (
    select s."StadiumCapacity" + ROUND(10 * s."StadiumCapacity" / 100)
    from "Stadium" s
    where s."StadiumCapacity" =
            (
              select MAX("StadiumCapacity")
              from "Stadium"
            )
    ),
    "UefaStars" = 5,
    "BuildingYear" = (
        select EXTRACT(Year from CURRENT_DATE) FROM DUAL
        )
    where "BuildingYear" < 1950;

/*
 2. Sa se produca o modificare in tabel astfel incat contractele de sponsorizare care mai dureaza un singur an
 sa expire. (sa fie sterse)
 */
DELETE FROM "Deal" d
WHERE d."ContractID" in
        (
            select "ContractID" from "Contract"
            where "Years" = 1
        );

select * from "Deal"
where "ContractID" = 1 or "ContractID" = 6;

/*
 3. Sa se mareasca cu 20% salariile din cadrul jobului/joburilor cele mai prost platite
 */

UPDATE "Job"
SET "JobSalary" =
    (
        "JobSalary" * 1.2
        )
    where "JobSalary" = (
        select MIN("JobSalary") FROM "Job"
        );

SELECT * FROM "Job";