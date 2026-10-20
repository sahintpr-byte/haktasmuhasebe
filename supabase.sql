create table if not exists site_content(id int primary key, data jsonb not null default '{}', updated_at timestamptz default now());
create table if not exists messages(id bigint generated always as identity primary key, name text, phone text, email text, message text, created_at timestamptz default now());
create index if not exists messages_created_at_idx on messages(created_at desc);

create or replace function public.is_admin()
returns boolean
language sql stable security definer set search_path = public
as $$ select coalesce((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin', false) $$;

alter table site_content enable row level security;
alter table messages enable row level security;
create policy "herkes okur" on site_content for select using (true);
create policy "admin ekler" on site_content for insert to authenticated with check (public.is_admin());
create policy "admin gunceller" on site_content for update to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "herkes mesaj gonderir" on messages for insert to anon, authenticated with check (char_length(message) between 1 and 3000);
create policy "admin mesaj okur" on messages for select to authenticated using (public.is_admin());
create policy "admin mesaj siler" on messages for delete to authenticated using (public.is_admin());
insert into storage.buckets(id,name,public) values('site','site',true) on conflict do nothing;
create policy "herkes gorsel okur" on storage.objects for select using (bucket_id='site');
create policy "admin gorsel yukler" on storage.objects for insert to authenticated with check (bucket_id='site' and public.is_admin());
create policy "admin gorsel gunceller" on storage.objects for update to authenticated using (bucket_id='site' and public.is_admin());
create policy "admin gorsel siler" on storage.objects for delete to authenticated using (bucket_id='site' and public.is_admin());
