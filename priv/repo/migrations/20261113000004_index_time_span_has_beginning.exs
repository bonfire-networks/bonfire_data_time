defmodule Bonfire.Data.Time.Repo.Migrations.IndexTimeSpanHasBeginning do
  @moduledoc false
  # listing things by when they begin (eg. intents, events) orders on this column
  use Ecto.Migration

  def change do
    create_if_not_exists(index("bonfire_data_time_span", [:has_beginning]))
  end
end
