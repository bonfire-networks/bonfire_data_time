defmodule Bonfire.Data.Time.Repo.Migrations.ImportTimeSpan do
  @moduledoc false
  use Ecto.Migration
  require Bonfire.Data.Time.TimeSpan.Migration

  def up, do: Bonfire.Data.Time.TimeSpan.Migration.migrate_time_span(:up)
  def down, do: Bonfire.Data.Time.TimeSpan.Migration.migrate_time_span(:down)
end
