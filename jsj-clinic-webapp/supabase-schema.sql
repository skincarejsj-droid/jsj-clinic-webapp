-- Run this once in your Supabase project's SQL Editor (Database -> SQL Editor -> New query).
-- It creates a single key-value table that stores each section of clinic data as one
-- JSON document (mirroring how the app already organizes its data), sets up security
-- rules so only logged-in clinic staff can read/write it, and turns on live sync so a
-- change made on one computer appears on every other computer automatically.

create table if not exists app_storage (
  key text primary key,
  value jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Row Level Security: only authenticated (logged-in) users may read or write.
-- This means anyone you create a login for can see and edit all clinic data.
-- (Ask if you'd like this split further, e.g. front-desk vs. owner-only payroll access.)
alter table app_storage enable row level security;

create policy "Authenticated users can read app_storage"
  on app_storage for select
  to authenticated
  using (true);

create policy "Authenticated users can write app_storage"
  on app_storage for insert
  to authenticated
  with check (true);

create policy "Authenticated users can update app_storage"
  on app_storage for update
  to authenticated
  using (true);

-- Enable realtime so edits sync live across every open browser/computer.
alter publication supabase_realtime add table app_storage;
