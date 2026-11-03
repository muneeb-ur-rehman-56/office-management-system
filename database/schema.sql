-- OfficeFlow starter schema for Supabase PostgreSQL.
-- Run in Supabase SQL Editor. This is a core operational schema, not every optional module table.
create extension if not exists pgcrypto;

create table if not exists public.departments (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  created_at timestamptz not null default now()
);

create table if not exists public.employees (
  id uuid primary key default gen_random_uuid(),
  employee_code text not null unique,
  full_name text not null,
  email text unique,
  phone text,
  department_id uuid references public.departments(id),
  designation text,
  monthly_salary numeric(12,2) not null default 0 check (monthly_salary >= 0),
  joining_date date,
  employment_status text not null default 'Active' check (employment_status in ('Active','Inactive','On leave')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.attendance (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid not null references public.employees(id) on delete cascade,
  attendance_date date not null,
  status text not null check (status in ('Present','Absent','Late','Half-day','Leave')),
  check_in time,
  check_out time,
  created_at timestamptz not null default now(),
  unique(employee_id, attendance_date)
);

create table if not exists public.leave_requests (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid not null references public.employees(id),
  leave_type text not null,
  start_date date not null,
  end_date date not null,
  reason text,
  status text not null default 'Pending' check (status in ('Pending','Approved','Rejected')),
  reviewer_comment text,
  created_at timestamptz not null default now(),
  check(end_date >= start_date)
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  assignee_id uuid references public.employees(id),
  priority text not null default 'Medium' check (priority in ('Low','Medium','High','Urgent')),
  status text not null default 'To Do' check (status in ('To Do','In Progress','Review','Completed')),
  due_date date,
  created_at timestamptz not null default now()
);

create table if not exists public.expenses (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null,
  amount numeric(12,2) not null check (amount >= 0),
  expense_date date not null default current_date,
  payment_method text,
  approval_status text not null default 'Pending' check (approval_status in ('Pending','Approved','Rejected')),
  created_at timestamptz not null default now()
);

create table if not exists public.income (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  source text,
  amount numeric(12,2) not null check (amount >= 0),
  received_date date not null default current_date,
  payment_method text,
  created_at timestamptz not null default now()
);

create table if not exists public.assets (
  id uuid primary key default gen_random_uuid(),
  asset_name text not null,
  category text,
  assigned_to uuid references public.employees(id),
  asset_condition text default 'Good',
  purchase_date date,
  created_at timestamptz not null default now()
);

create index if not exists idx_attendance_date on public.attendance(attendance_date);
create index if not exists idx_leave_status on public.leave_requests(status);
create index if not exists idx_tasks_status_due on public.tasks(status, due_date);
create index if not exists idx_expenses_date on public.expenses(expense_date);
create index if not exists idx_income_date on public.income(received_date);

-- Enable RLS. Add policies before connecting client-side Supabase access.
alter table public.departments enable row level security;
alter table public.employees enable row level security;
alter table public.attendance enable row level security;
alter table public.leave_requests enable row level security;
alter table public.tasks enable row level security;
alter table public.expenses enable row level security;
alter table public.income enable row level security;
alter table public.assets enable row level security;

-- Example authenticated policies for a trusted internal team. Tighten by role/tenant
-- before production use; never use the service-role key in browser code.
create policy "authenticated users can read departments" on public.departments
for select to authenticated using (true);
create policy "authenticated users can manage departments" on public.departments
for all to authenticated using (true) with check (true);
create policy "authenticated users can read employees" on public.employees
for select to authenticated using (true);
create policy "authenticated users can manage employees" on public.employees
for all to authenticated using (true) with check (true);
create policy "authenticated users can manage attendance" on public.attendance
for all to authenticated using (true) with check (true);
create policy "authenticated users can manage leave requests" on public.leave_requests
for all to authenticated using (true) with check (true);
create policy "authenticated users can manage tasks" on public.tasks
for all to authenticated using (true) with check (true);
create policy "authenticated users can manage expenses" on public.expenses
for all to authenticated using (true) with check (true);
create policy "authenticated users can manage income" on public.income
for all to authenticated using (true) with check (true);
create policy "authenticated users can manage assets" on public.assets
for all to authenticated using (true) with check (true);
