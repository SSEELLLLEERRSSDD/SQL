INSERT INTO target_table
SELECT * FROM temp_table
WHERE Report_Date >= '2023-01-01' AND Report_Date <= '2023-01-31';