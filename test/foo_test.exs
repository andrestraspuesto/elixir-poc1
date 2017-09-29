defmodule Pruebas.FooTest do
  use ExUnit.Case
  doctest Pruebas.Foo

  test "1 + 1 = 2" do
    assert Pruebas.Foo.suma(1,1) == 2
  end

end
