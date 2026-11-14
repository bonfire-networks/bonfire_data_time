defmodule Bonfire.Data.Time.Repo.Migrations.AddTimeSpanTimezone do
  @moduledoc false
  # the IANA time zone something happens in; `if not exists` as a fresh install's table already has it
  use Ecto.Migration

  def change do
    alter table("bonfire_data_time_span") do
      add_if_not_exists(:timezone, :text)
    end
  end
end
