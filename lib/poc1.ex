defmodule Poc1 do
  @moduledoc """
  Ejemplo básico de pattern matching y envío de mensajes
  entre procesos
  """

  @doc """
  Lanza en un proceso distinto la función escucha,
  tras lo cual le envía un mensaje
  y se pone a la escucha
  """
  def inicia_dialogo do
    #Inicia en un proceso la función
    #Poc1.escucha sin parámetros
    pid1 = spawn(Poc1, :escucha, [])

    #Envía al proceso 1 (pid1) una petición
    #con los parámetros adecuados
    send(pid1, {self(), "ping", 1})
    escucha() #se pone a la escucha
  end

  @doc """
  Función recursiva encargada de mantener el proceso
  a la escucha
  """
  def escucha do
    receive do
      {pid, pregunta, n} ->
        traza_recepcion_en_consola(pregunta, n)
        contesta(pid, pregunta, n)
        escucha()
      _ ->
        IO.puts("#{inspect self()} -> recibe fin")
    end
  end

  defp traza_recepcion_en_consola(pregunta, n) do
    IO.puts("#{inspect self()} recibe #{pregunta}, n = #{n}")
  end
  @doc """
  Se encarga de cerrar el diálogo cuando n > 10
      ##Ejemplo
      iex>{_pid, resp, _n} = Poc1.contesta(self(), "ping", 11)
      iex>resp
      "fin"
  """
  def contesta(pid, _pregunta, n) when n > 10 do
    send(pid, {"fin"})
    send(self(), {"fin"})
  end

  @doc """
  Responde ante una pregunta pong
      ##Ejemplo
      iex>{_pid, resp, n} = Poc1.contesta(self(), "pong", 10)
      iex>resp
      "ping"
      iex>n
      11
  """
  def contesta(pid, _pregunta = "pong", n) do
    send(pid, { self(), "ping", n+1})
  end

  @doc """
  Responde ante una pregunta ping
      ##Ejemplo
      iex>{_pid, resp, n} = Poc1.contesta(self(), "ping", 10)
      iex>resp
      "pong"
      iex>n
      11
  """
  def contesta(pid, _pregunta = "ping", n) do
    send(pid, {self(),"pong", n+1})
  end

end
