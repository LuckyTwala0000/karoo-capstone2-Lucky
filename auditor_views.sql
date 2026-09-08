-- Monitoring View: Supplier Health
CREATE OR REPLACE VIEW v_supplier_health AS
SELECT 
    s.supplier_id,
    s.farm_name,
    s.region,
    c.cert_expiry_date,
    CASE 
        WHEN c.cert_expiry_date IS NULL THEN 'Unknown'
        WHEN c.cert_expiry_date < CURRENT_DATE THEN 'Expired'
        WHEN c.cert_expiry_date <= CURRENT_DATE + INTERVAL '30 days' THEN 'Expiring Soon'
        ELSE 'Valid'
    END AS cert_status,
    COUNT(o.order_id) FILTER (WHERE o.order_date >= CURRENT_DATE - INTERVAL '90 days') AS orders_90d,
    MAX(h.quantity) AS latest_yield,
    AVG(h.quantity) OVER (
        PARTITION BY h.supplier_id 
        ORDER BY h.harvest_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_yield
FROM Suppliers s
LEFT JOIN Certifications c ON s.supplier_id = c.supplier_id
LEFT JOIN Orders o ON s.supplier_id = o.supplier_id
LEFT JOIN Harvest_Log h ON s.supplier_id = h.supplier_id
GROUP BY s.supplier_id, s.farm_name, s.region, c.cert_expiry_date, h.supplier_id, h.harvest_date;
