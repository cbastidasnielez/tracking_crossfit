-- ============================================================
-- Protocolo RX · esquema Supabase
-- Pega TODO esto en: Supabase → SQL Editor → New query → Run
-- ============================================================

create table if not exists entries (
  id          uuid primary key default gen_random_uuid(),
  type        text not null,          -- 'peso' | 'z2' | 'press' | 'fuerza' | 'wod' | 'checkin' | 'comida' | 'config'
  entry_date  date,
  payload     jsonb not null default '{}',
  created_at  timestamptz default now()
);

create index if not exists entries_type_date_idx on entries (type, entry_date);

-- Seguridad a nivel de fila
alter table entries enable row level security;

-- Política ABIERTA (simple): cualquiera con tu clave anon puede leer/escribir.
-- Suficiente para un registro personal de entrenos. Ver nota de seguridad abajo.
drop policy if exists "acceso abierto" on entries;
create policy "acceso abierto" on entries
  for all using (true) with check (true);

-- ============================================================
-- NOTA DE SEGURIDAD
-- La clave anon va dentro del index.html, así que es pública:
-- alguien que encuentre tu URL y mire el código podría leer/escribir.
-- Para logs de entreno suele ser un riesgo aceptable.
--
-- ¿Quieres que SOLO tú accedas? Se añade login (Supabase Auth) y se
-- cambia la política a: using (auth.uid() = user_id). Pídemelo y te
-- dejo esa versión.
-- ============================================================
