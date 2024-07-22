defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.Tetromino

  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)
    {:ok, socket |> new_tetromino()}
  end

  def new_tetromino(socket) do
    assign(socket, :tetromino, Tetromino.new_random())
  end

  def render(assigns) do
    ~H"""
    <h2>Game Live</h2>
    <div class="phx-hero">
      <pre><%= inspect @tetromino  %></pre>
    </div>
    """
  end

  def down(%{assigns: %{tetromino: tetromino}} = socket) do
    assign(socket, tetromino: Tetromino.down(tetromino))
  end

  def handle_info(:tick, socket) do
    {:noreply, down(socket)}
  end
end
