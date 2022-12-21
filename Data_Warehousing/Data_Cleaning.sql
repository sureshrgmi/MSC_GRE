-------------------------------------------------------------------------------
--------------------- Data Cleaning (Staging )-------------------------------------------
-------------------------------------------------------------------------------

------------------------------- Table : TEMP ----------------------------------

-- Deleting record with first name null or '........'
DELETE FROM "TEMP"
WHERE
    "First Name" IS NULL
    OR "First Name" LIKE '%.....%';

-- Deleting this specific recrod as it does not have details associated
DELETE FROM "TEMP"
WHERE
    "TempID" = 183;

-- Remove leading and lagging space from First and Last Name
UPDATE "TEMP"
SET
    "First Name" = TRIM("First Name"),
    "Last Name" = TRIM("Last Name");
 
-- Updateing County Kent to make it consistent
UPDATE "TEMP"
SET
    "County" = 'Kent'
WHERE
    "County" LIKE '%Kent';


------------------------ Table : TEMP_NATIONALITY ------------------------------

-- Delete NULL NationalityDescription from the table
DELETE FROM "TEMP_NATIONALITY"
WHERE
    "NationalityDescription" IS NULL;

-- Updating Hindi with Indian

UPDATE "TEMP_NATIONALITY"
SET
    "NationalityDescription" = 'Indian'
WHERE
    "NationalityDescription" = 'Hindi';



----------------------- Table : Local Council ----------------------------------
 
-- Delete records with null local council name
Delete from local_council where "LocalCouncilName" is null;

