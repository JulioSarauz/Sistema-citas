-- Cal.diy only ever accesses Postgres through Prisma using the table-owning
-- DB role, which bypasses Row Level Security by default. Enabling RLS with
-- no policies here does not change app behavior; it closes off direct access
-- to every "public" table for any other role (e.g. Supabase's anon/authenticated
-- roles used by PostgREST), which Supabase's Security Advisor flags as an error
-- ("RLS Disabled in Public") for every table in this schema.
DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN
    SELECT tablename
    FROM pg_tables
    WHERE schemaname = 'public'
      AND tablename <> '_prisma_migrations'
  LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', r.tablename);
  END LOOP;
END $$;

-- These views were created without security_invoker, so Postgres runs them
-- with the view owner's privileges instead of the querying role's. Supabase
-- flags this as "Security Definer View" because it would let a low-privilege
-- role read data through the view that RLS would otherwise block on the
-- underlying tables. security_invoker requires Postgres 15+.
ALTER VIEW public."BookingTimeStatus" SET (security_invoker = on);
ALTER VIEW public."BookingTimeStatusDenormalized" SET (security_invoker = on);
