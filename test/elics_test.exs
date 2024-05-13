defmodule ElicsTest do
  use ExUnit.Case
  doctest Elics

  test "greets the world" do
    assert Elics.hello() == :world
  end
end
