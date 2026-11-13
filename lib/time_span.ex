defmodule Bonfire.Data.Time.TimeSpan do
  @moduledoc """
  When something begins and ends. Shared by any object that has a time: an event, or a ValueFlows intent, commitment or economic event.
  """

  use Needle.Mixin,
    otp_app: :bonfire_data_time,
    source: "bonfire_data_time_span"

  alias Bonfire.Data.Time.TimeSpan
  import Ecto.Changeset

  mixin_schema do
    field(:has_beginning, :utc_datetime_usec)
    field(:has_end, :utc_datetime_usec)
  end

  @cast [:has_beginning, :has_end]

  def changeset(span \\ %TimeSpan{}, params) do
    cast(span, params, @cast)
  end
end

defmodule Bonfire.Data.Time.TimeSpan.Migration do
  @moduledoc false
  use Ecto.Migration
  import Needle.Migration
  alias Bonfire.Data.Time.TimeSpan

  # create_time_span_table/{0,1}

  defp make_time_span_table(exprs) do
    quote do
      require Needle.Migration

      Needle.Migration.create_mixin_table Bonfire.Data.Time.TimeSpan do
        Ecto.Migration.add(:has_beginning, :timestamptz)
        Ecto.Migration.add(:has_end, :timestamptz)
        unquote_splicing(exprs)
      end
    end
  end

  defmacro create_time_span_table(), do: make_time_span_table([])
  defmacro create_time_span_table(do: {_, _, body}), do: make_time_span_table(body)

  # drop_time_span_table/0

  def drop_time_span_table(), do: drop_mixin_table(TimeSpan)

  # migrate_time_span/{0,1}

  defp mts(:up), do: make_time_span_table([])

  defp mts(:down) do
    quote do
      Bonfire.Data.Time.TimeSpan.Migration.drop_time_span_table()
    end
  end

  defmacro migrate_time_span() do
    quote do
      if Ecto.Migration.direction() == :up,
        do: unquote(mts(:up)),
        else: unquote(mts(:down))
    end
  end

  defmacro migrate_time_span(dir), do: mts(dir)
end
