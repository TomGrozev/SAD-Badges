defmodule Badges.Repo.Migrations.StudentNameSearch do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION pg_trgm")

    execute("""
    CREATE INDEX students_trgm_idx ON students USING GIN (to_tsvector('english',
    first_name || ' ' || coalesce(last_name, ' ')))
    """)
  end

  def down do
    execute("DROP INDEX users_trgm_idx")
    execute("DROP EXTENSION pg_trgm")
  end
end
