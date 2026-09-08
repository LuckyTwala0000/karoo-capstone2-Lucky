-- Sample data for demonstration
INSERT INTO Certifications (supplier_id, cert_name, issue_date, cert_expiry_date)
VALUES
(1, 'Organic Cert', '2025-01-01', '2026-09-01'),
(2, 'FairTrade', '2025-03-01', '2026-12-01'),
(3, 'ISO9001', '2025-05-01', '2026-08-15');

INSERT INTO Harvest_Log (supplier_id, crop, harvest_date, quantity)
VALUES
(1, 'Maize', '2026-07-01', 1000),
(1, 'Maize', '2026-08-01', 800),
(1, 'Maize', '2026-09-01', 600),
(2, 'Wheat', '2026-07-15', 1200),
(3, 'Grapes', '2026-08-20', 400);

INSERT INTO Orders (order_id, supplier_id, order_date, total_price)
VALUES
(201, 1, '2026-07-10', 15000),
(202, 2, '2026-08-12', 18000);
