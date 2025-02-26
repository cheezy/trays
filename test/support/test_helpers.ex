defmodule Trays.TestHelpers do
  use ExUnit.Case
  
  @moduledoc false

  def assert_validation_error_on(changeset, field, msg) do
    assert changeset.valid? == false
    assert Keyword.keys(changeset.errors) == [field]
    assert %{field => [msg]} == Trays.DataCase.errors_on(changeset)
  end

  def string_of_length(len) do
    Enum.reduce(1..len, "", fn _, acc -> "x" <> acc end)
  end

end
