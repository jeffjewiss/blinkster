defmodule BlinksterTest do
  use ExUnit.Case
  doctest Blinkster

  test "greets the world" do
    assert Blinkster.hello() == :world
  end
end
