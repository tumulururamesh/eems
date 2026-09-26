
# database.py
import psycopg2
from psycopg2.extras import RealDictCursor
from config import DB_CONFIG


def get_connection():

    conn = psycopg2.connect(
        host=DB_CONFIG["host"],
        database=DB_CONFIG["database"],
        user=DB_CONFIG["user"],
        password=DB_CONFIG["password"],
        port=DB_CONFIG["port"],
        cursor_factory=RealDictCursor
    )

    # Set default schema
    cur = conn.cursor()
    cur.execute("SET search_path TO public;")
    cur.close()

    return conn



def get_academic_year_id(academic_year):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""

        SELECT academic_year_id

        FROM academic_year_master

        WHERE academic_year = %s

    """, (academic_year,))

    row = cur.fetchone()

    cur.close()
    conn.close()

    if row:
        return row["academic_year_id"]

    return None
