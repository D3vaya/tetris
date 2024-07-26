defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.Tetromino

  @rotate_keys ["ArrowDown", " "]

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end

    {:ok, socket |> new_tetromino() |> print_shape()}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-white text-white rounded-lg p-4">
      <div phx-window-keydown="keystroke">
        <h1 class="text-2xl text-black">Game Live TETRIS</h1>
        <%= render_board(assigns) %>
        <pre class="bg-gray-200 p-4 text-black">

      <%= inspect(@tetromino, pretty: true) %>
      </pre>
      </div>
    </div>
    """
  end

  defp render_board(assigns) do
    ~H"""
    <svg width="200" height="400" xmlns="http://www.w3.org/2000/svg">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~H"""
    <%= for {x,y, shape} <- @points do %>
      <rect width="20" height="20" x={(x - 1) * 20} y={(y - 1) * 20} style={"fill: #{color(shape)};"} />
    <% end %>
    """
  end

  def color(:l), do: "red"
  def color(:j), do: "royalblue"
  def color(:s), do: "limegreen"
  def color(:z), do: "yellow"
  def color(:o), do: "magenta"
  def color(:i), do: "silver"
  def color(:t), do: "saddlebrown"
  def color(_), do: "red"

  defp new_tetromino(socket) do
    assign(socket, :tetromino, Tetromino.new_random())
  end

  defp print_shape(socket) do
    assign(socket, points: Tetromino.show(socket.assigns.tetromino))
  end

  def rotate(%{assigns: %{tetromino: tetromino}} = socket) do
    assign(socket, tetromino: Tetromino.rotate(tetromino))
  end

  def left(%{assigns: %{tetromino: tetromino}} = socket) do
    assign(socket, tetromino: Tetromino.left(tetromino))
  end

  def right(%{assigns: %{tetromino: tetromino}} = socket) do
    assign(socket, tetromino: Tetromino.right(tetromino))
  end

  def down(%{assigns: %{tetromino: %{location: {_, 20}}}} = socket) do
    socket
    |> new_tetromino()
  end

  def down(%{assigns: %{tetromino: tetromino}} = socket) do
    assign(socket, tetromino: Tetromino.down(tetromino))
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> down |> print_shape()}
  end

  def handle_event("keystroke", %{"key" => key}, socket) when key in @rotate_keys do
    {:noreply, socket |> rotate |> print_shape()}
  end

  def handle_event("keystroke", %{"key" => "ArrowRight"}, socket) do
    {:noreply, socket |> right |> print_shape()}
  end

  def handle_event("keystroke", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, socket |> left |> print_shape()}
  end
end
