defmodule Tetris.Tetromino do
  defstruct shape: :l, rotation: 0, location: {5, 1}
  alias Tetris.Point

  # @doc Crea un nuevo tetromino con las opciones proporcionadas
  def new(options) do
    __struct__(options)
  end

  # @doc Crea un nuevo tetromino con una forma aleatoria
  def new_random do
    new(shape: random_shape())
  end

  # @doc Mueve el tetromino una posición a la derecha
  def right(tetromino) do
    %{tetromino | location: Point.right(tetromino.location)}
  end

  # @doc Mueve el tetromino una posición a la izquierda
  def left(tetromino) do
    %{tetromino | location: Point.left(tetromino.location)}
  end

  # @doc Mueve el tetromino una posición hacia abajo
  def down(tetromino) do
    %{tetromino | location: Point.down(tetromino.location)}
  end

  # @doc Rotar el tetromino 90 grados
  def rotate(%{} = tetromino) do
    %{tetromino | rotation: rotate_degrees(tetromino.rotation)}
  end

  def points(tetromino) do
    [tetromino.location]
  end

  # @doc Devuelve la forma del tetromino
  defp random_shape do
    ~w[i t o l j z s]a
    |> Enum.random()
  end

  def rotate_degrees(270) do
    0
  end

  def rotate_degrees(n) do
    n + 90
  end
end
