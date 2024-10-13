import pandas as pd
from sqlalchemy import create_engine

data = pd.read_excel('music.xlsx')
engine = create_engine('postgresql://postgres:12345@localhost:5432/sql_bd')
data.to_sql('target_table', engine, if_exists='replace', index=False)

