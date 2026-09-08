import psycopg2, os

def run_audit():
    try:
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST'),
            database=os.getenv('DB_NAME'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASS')
        )
        cur = conn.cursor()

        # Risk query
        risk_query = """
        SELECT supplier_id 
        FROM v_supplier_health
        WHERE cert_status IN ('Expired','Expiring Soon')
           OR orders_90d = 0
           OR latest_yield < (0.8 * rolling_avg_yield);
        """
        cur.execute(risk_query)
        at_risk_ids = [row[0] for row in cur.fetchall()]

        if at_risk_ids:
            cur.executemany("""
                UPDATE Suppliers 
                SET status = %s, last_audit = CURRENT_DATE 
                WHERE supplier_id = %s
            """, [('Review', sid) for sid in at_risk_ids])
            conn.commit()
            print(f"{len(at_risk_ids)} suppliers require review.")
        else:
            print("No suppliers flagged for review.")

    except Exception as e:
        print("Audit failed:", e)
        if conn:
            conn.rollback()
    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    run_audit()
