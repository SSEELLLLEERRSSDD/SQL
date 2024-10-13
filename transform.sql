CREATE TABLE IF NOT EXISTS clean_table AS 
SELECT * FROM raw_table WITH NO DATA;

CREATE OR REPLACE FUNCTION transform_data(start_date DATE, end_date DATE)
RETURNS VOID AS $$
BEGIN
    -- времнная таблица
    CREATE TEMP TABLE temp_table AS
    SELECT * FROM target_table;

    -- "плохие" данные бай бай
    DELETE FROM temp_table
    WHERE Report_Date IS NULL OR
    OR COALESCE("userID", "Track", artist, genre, "City", CAST(time AS text), "Weekday") IS NULL;

    -- "Хорошие" данные шалом шабат
    INSERT INTO target_table
    SELECT *
    FROM raw_table
    WHERE "Report_date" BETWEEN start_date AND end_date
    AND "Report_date" BETWEEN '2023-01-01' AND '2023-12-31';

    -- пока временная таблица
    DROP TABLE temp_table;
END;
$$ LANGUAGE plpgsql;

