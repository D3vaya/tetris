defmodule Tetris.Tetromino do
  defstruct shape: :l, rotation: 0, location: {3, 0}
  alias Tetris.{Point, Points}

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

  def show(tetromino) do
    tetromino
    |> points()
    |> Points.rotate(tetromino.rotation)
    |> Points.move(tetromino.location)
    |> Points.add_shape(tetromino.shape)
  end

  def points(%{shape: :l}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{shape: :j}) do
    [
      {3, 1},
      {3, 2},
      {3, 3},
      {2, 3}
    ]
  end

  def points(%{shape: :s}) do
    [
      {2, 2},
      {3, 2},
      {1, 3},
      {2, 3}
    ]
  end

  def points(%{shape: :z}) do
    [
      {1, 2},
      {2, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{shape: :i}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {2, 4}
    ]
  end

  def points(%{shape: :o}) do
    [
      {2, 2},
      {3, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def points(%{shape: :t}) do
    [
      {1, 2},
      {2, 2},
      {3, 2},
      {2, 3}
    ]
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

  def maybe_move(_old, new, true = _valid), do: new
  def maybe_move(old, _new, false = _valid), do: old
end
