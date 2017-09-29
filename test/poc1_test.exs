defmodule Poc1Test do
  use ExUnit.Case
  doctest Poc1

  test "pregunta ping devuelve pong" do
    {_pid, respuesta, n} = Poc1.contesta(self(), "ping", 1)
    assert n === 2
    assert respuesta === "pong"
  end

  test "pregunta pong devuelve ping" do
    {_pid, respuesta, n} = Poc1.contesta(self(), "pong", 1)
    assert n === 2
    assert respuesta === "ping"
  end
end
