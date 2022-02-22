defmodule Blitz.HTTP.ClientTest do
  use ExUnit.Case
  doctest Blitz.HTTP.Client

  test "get_api_key" do
    assert Blitz.HTTP.Client.get_api_key() == "api_key_for_test"
  end
end
