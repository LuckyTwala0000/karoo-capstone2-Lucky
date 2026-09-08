# karoo-capstone2-Lucky

# Karoo Capstone Phase 2 — Supplier Risk & Compliance Auditor

This project automates supplier risk monitoring for Karoo Organics.

## Deliverables
- **auditor_views.sql**: Defines `v_supplier_health` with certification status, order volume, and yield metrics.
- **Risk query**: Flags suppliers with expiring/expired certifications, no orders in 90 days, or yield decline.
- **audit_suppliers.py**: Python script that updates supplier status to 'Review' and prints a summary.
- **test_data.sql**: Sample data to demonstrate functionality.

## Risk Logic
- **Certification expiry**: Suppliers with certificates expiring in ≤30 days or already expired are flagged.
- **Order inactivity**: Suppliers with zero orders in the last 90 days are flagged.
- **Yield decline**: Suppliers whose latest harvest yield is <80% of their rolling 3-harvest average are flagged.

## Compliance Considerations
- Ensures proactive monitoring to avoid reputational and regulatory risk.
- Supports operational teams with clear audit outputs.
