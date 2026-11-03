# OfficeFlow — Office Management System

A responsive Office Management System starter for a small business (5–30 employees).

## Included in this build

- Responsive dashboard with financial and workforce charts
- Employee records: add, edit, delete, search and CSV export
- Departments: add and remove departments
- Attendance register: mark attendance and filter by date
- Leave requests: submit, approve, reject and delete
- Payroll preview based on employee monthly salaries
- Tasks: create, update, delete and search
- Expenses and income: CRUD, summaries and CSV export
- Assets, customers and visitor registers
- Meetings and announcements
- Activity log and company settings
- Local demo data saved in browser `localStorage`
- Express server and starter Supabase SQL schema

## Requirements

- Node.js 18 or newer
- npm

## Run locally

1. Extract the ZIP.
2. Open the project folder in VS Code.
3. Open a terminal in that folder.
4. Install dependencies:

   ```bash
   npm install
   ```

5. Start the app:

   ```bash
   npm run dev
   ```

6. Open `http://localhost:3000`.

No login is required in this demo build. The app starts with sample records. Data is saved in the browser where you use it. Use **Settings** to change the company name.

## Supabase setup

1. Create a Supabase project.
2. Open **SQL Editor** in Supabase.
3. Copy and run `database/schema.sql`.
4. Copy `.env.example` to `.env`.
5. Add your Supabase project URL and anon key to `.env`.

**Important:** This starter currently runs in local demo mode and does not yet send application records to Supabase. The SQL file provides a core database foundation for the next integration phase. Do not put the Supabase service-role key in frontend code. Before using real employee or financial data, implement Supabase Auth, server-side authorization, tenant/role-specific RLS policies, and persistent API integration.

## Current scope and production checklist

This is a working starter/MVP, not a fully production-ready HR/payroll platform. The browser demo supports the core workflows listed above. The following need implementation and testing before real-world use:

- Supabase Auth, password reset, user invitations and role-based permissions
- Supabase-backed CRUD and secure private Storage uploads
- Full payroll runs, attendance-based salary calculations, payslips and payment reconciliation
- Leave balances, accrual rules and approval history
- Project collaboration, comments and attachments
- Inventory stock transactions, asset maintenance and assignment history
- Customer history, visitor check-out and meeting participants
- PDF/Excel reports, notification delivery and automated reminders
- Granular RLS policies, audit hardening, backups and deployment configuration

## Project structure

```text
office-management-system/
├── database/
│   └── schema.sql
├── public/
│   ├── css/styles.css
│   ├── js/app.js
│   └── index.html
├── src/
│   └── server.js
├── .env.example
├── .gitignore
├── package.json
└── README.md
```

## Notes

- Currency display is PKR.
- Sample records are for demonstration only.
- Clearing browser site data will remove local demo records.
- For deployment, use a Node-compatible host for this Express server; static-only hosting will not run `src/server.js`.
