defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  use GenServer

  # === Client API ===

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    GenServer.start_link(__MODULE__, capacity)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    GenServer.call(buffer, :read)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
    GenServer.call(buffer, {:write, item})
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
    GenServer.cast(buffer, {:overwrite, item})
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    GenServer.cast(buffer, :clear)
  end

  # === Server callbacks ===

  @impl true
  def init(capacity) do
    state = {[], capacity}
    {:ok, state}
  end

  @impl true
  def handle_call(:read, _, {[], _} = state) do
    {:reply, {:error, :empty}, state}
  end

  @impl true
  def handle_call(:read, _, {[oldest | rest], capacity}) do
    state = {rest, capacity}
    {:reply, {:ok, oldest}, state}
  end

  @impl true
  def handle_call({:write, _item}, _, {items, capacity} = state) when length(items) == capacity do
    {:reply, {:error, :full}, state}
  end

  @impl true
  def handle_call({:write, item}, _, {items, capacity}) do
    state = {items ++ [item], capacity}
    {:reply, :ok, state}
  end

  @impl true
  def handle_cast({:overwrite, item}, {items, capacity}) when length(items) == capacity do
    [_oldest | rest] = items
    state = {rest ++ [item], capacity}
    {:noreply, state}
  end

  @impl true
  def handle_cast({:overwrite, item}, {items, capacity}) do
    state = {items ++ [item], capacity}
    {:noreply, state}
  end

  @impl true
  def handle_cast(:clear, {_items, capacity}) do
    state = {[], capacity}
    {:noreply, state}
  end
end
