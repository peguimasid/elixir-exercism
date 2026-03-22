# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn -> %{plots: [], count: 1} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn data -> data.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      new_plot = %Plot{plot_id: state.count, registered_to: register_to}
      new_state = %{count: state.count + 1, plots: [new_plot | state.plots]}
      {new_plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      filtered_plots = Enum.reject(state.plots, &(&1.plot_id == plot_id))
      %{state | plots: filtered_plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(state.plots, {:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
    end)
  end
end
