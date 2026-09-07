-- Prisma's own migration-tracking table was excluded from the previous RLS
-- migration, but Supabase's linter flags it the same as any other public
-- table exposed to PostgREST. Only `prisma migrate` (running as the
-- table-owning DB role) ever touches this table, so enabling RLS with no
-- policies has no effect on the app and closes the same PostgREST exposure
-- gap as the other tables.
ALTER TABLE public._prisma_migrations ENABLE ROW LEVEL SECURITY;
