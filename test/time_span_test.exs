defmodule Bonfire.Data.Time.TimeSpanTest do
  @moduledoc "When something begins and ends, as a mixin any object can have."
  use Bonfire.DataCase, async: true
  @moduletag :backend

  alias Bonfire.Common.Repo
  alias Bonfire.Data.Time.TimeSpan
  alias Bonfire.Me.Fake

  test "an object's beginning and end are stored and read back" do
    # any pointable will do as the object the time belongs to
    object = Fake.fake_user!()
    beginning = ~U[2026-12-01 18:00:00.000000Z]
    ending = ~U[2026-12-01 21:30:00.000000Z]

    assert {:ok, _} =
             %TimeSpan{id: object.id}
             |> TimeSpan.changeset(%{has_beginning: beginning, has_end: ending})
             |> Repo.insert()

    assert %TimeSpan{has_beginning: ^beginning, has_end: ^ending} = Repo.get(TimeSpan, object.id)
  end

  test "an end with no beginning is allowed, as is a beginning with no end" do
    object = Fake.fake_user!()

    assert {:ok, %TimeSpan{has_end: nil}} =
             %TimeSpan{id: object.id}
             |> TimeSpan.changeset(%{has_beginning: ~U[2026-12-01 18:00:00.000000Z]})
             |> Repo.insert()
  end

  test "the time zone it happens in is stored, as an IANA name" do
    object = Fake.fake_user!()

    assert {:ok, _} =
             %TimeSpan{id: object.id}
             |> TimeSpan.changeset(%{
               has_beginning: ~U[2026-12-01 18:00:00.000000Z],
               timezone: "Europe/Paris"
             })
             |> Repo.insert()

    assert %TimeSpan{timezone: "Europe/Paris"} = Repo.get(TimeSpan, object.id)
  end

  test "a time zone that is not an IANA name is refused" do
    changeset = TimeSpan.changeset(%{timezone: "Mars/Olympus"})

    refute changeset.valid?
    assert Keyword.has_key?(changeset.errors, :timezone)
  end
end
