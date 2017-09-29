defmodule Pruebas.Foo do
  @moduledoc """
  Prueba de concepto de comunicación de procesos
  """
  @doc """
      iex> "Pablo" |> Pruebas.Foo.saludo
      "Hola Pablo"
  """
  def saludo(nombre) do
    "Hola #{nombre}"
  end

  @doc """
      iex> Pruebas.Foo.suma(1,2)
      3
  """
  def suma(a, b) do
    a + b
  end
end
