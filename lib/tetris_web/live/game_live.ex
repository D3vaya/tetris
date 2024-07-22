defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.Tetromino

  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)

    {:ok,
     socket
     |> new_tetromino()
     |> print()}
  end

  def render(assigns) do
    ~H"""
    <% [{x, y}] = @points %>
    <div class="bg-white text-white rounded-lg p-4">
      <h1 class="text-2xl text-black">Game Live TETRIS</h1>
      <%= render_board(assigns) %>
      <pre>

      {<%=  x  %>, <%=  y  %>}
      </pre>
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

  defp render_points(%{points: [{x, y}]} = assigns) do
    ~H"""
    <%!-- IO.puts() --%>
    <rect width="20" height="20" x={(x - 1) * 20} y={(y - 1) * 20} style="fill:rgb(255,0,0);" />
    """
  end

  defp new_tetromino(socket) do
    assign(socket, :tetromino, Tetromino.new_random())
  end

  defp print(socket) do
    assign(socket, points: Tetromino.points(socket.assigns.tetromino))
  end

  def down(%{assigns: %{tetromino: %{location: {_, 20}}}} = socket) do
    socket
    |> new_tetromino()
    |> print()
  end

  def down(%{assigns: %{tetromino: tetromino}} = socket) do
    socket
    |> assign(tetromino: Tetromino.down(tetromino))
    |> print()
  end

  def handle_info(:tick, socket) do
    {:noreply, down(socket)}
  end
end
