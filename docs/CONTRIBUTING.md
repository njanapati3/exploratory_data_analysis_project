# Contributing to SQL Sales Analysis

First off, thank you for considering contributing to this project! 🎉

## How Can I Contribute?

### Reporting Bugs

If you find a bug, please create an issue with:
- A clear, descriptive title
- Steps to reproduce the issue
- Expected vs actual behavior
- SQL Server version and environment details
- Sample data (if applicable and non-sensitive)

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:
- Clear use case description
- Proposed solution or approach
- Any alternative solutions considered

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-new-query
   ```
3. **Make your changes**
   - Follow existing code style and formatting
   - Add comments explaining complex queries
   - Include examples in documentation
4. **Test your changes**
   - Verify queries run successfully
   - Check for SQL injection vulnerabilities
   - Ensure performance is acceptable
5. **Commit your changes**
   ```bash
   git commit -m "Add amazing new analytical query"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/amazing-new-query
   ```
7. **Create a Pull Request**

## SQL Code Style Guidelines

### Formatting
- Use uppercase for SQL keywords (`SELECT`, `FROM`, `WHERE`)
- Use lowercase for table/column names or follow existing schema conventions
- Indent subqueries and nested statements
- One column per line in SELECT statements (for complex queries)

### Example
```sql
SELECT 
    category,
    subcategory,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT order_id) AS order_count
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp ON fs.product_key = dp.product_key
WHERE order_date >= '2024-01-01'
GROUP BY category, subcategory
ORDER BY total_sales DESC;
```

### Comments
- Add header comments to explain query purpose
- Use inline comments for complex logic
- Document any assumptions or business rules

```sql
/*
Purpose: Calculate monthly revenue trends
Business Rule: Excludes refunded orders
*/
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(sales_amount) AS monthly_revenue
FROM gold.fact_sales
WHERE status != 'REFUNDED'  -- Exclude refunds
GROUP BY YEAR(order_date), MONTH(order_date);
```

## Adding New Queries

When adding new analytical queries:

1. **Place in appropriate script file** or create a new one
2. **Follow naming conventions**: `##_descriptive_name.sql`
3. **Add documentation header**
4. **Update README.md** with new query description
5. **Test thoroughly** with sample data

## Documentation

- Keep README.md up to date
- Update `docs/analysis_patterns.md` for new patterns
- Use clear, concise language
- Include code examples

## Questions?

Feel free to open an issue for any questions or discussions!

---

Thank you for your contributions! 🙏
