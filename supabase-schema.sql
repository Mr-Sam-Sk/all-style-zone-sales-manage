-- Run this in Supabase Dashboard > SQL Editor for your project.
-- One row per business record. Row Level Security makes each signed-in account
-- able to read/write only its own rows. Never use the service-role key in the site.
create table if not exists public.asz_records (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  kind text not null check (kind in ('products','customers','orders','followups')),
  data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists asz_records_user_kind_idx on public.asz_records (user_id, kind, created_at desc);
alter table public.asz_records enable row level security;
drop policy if exists "Owners can view their records" on public.asz_records;
drop policy if exists "Owners can insert their records" on public.asz_records;
drop policy if exists "Owners can update their records" on public.asz_records;
drop policy if exists "Owners can delete their records" on public.asz_records;
create policy "Owners can view their records" on public.asz_records for select to authenticated using ((select auth.uid()) = user_id);
create policy "Owners can insert their records" on public.asz_records for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Owners can update their records" on public.asz_records for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Owners can delete their records" on public.asz_records for delete to authenticated using ((select auth.uid()) = user_id);
grant select, insert, update, delete on public.asz_records to authenticated;
