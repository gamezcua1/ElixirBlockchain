defmodule Blockchain.Server do
  use Agent

  alias Blockchain.Chain, as: Chain

  def start_link,
    do:
      Agent.start_link(fn -> Chain.new_chain() end,
        name: __MODULE__
      )

  def value, do: Agent.get(__MODULE__, & &1)

  def set(chain_updated) do
    Agent.update(__MODULE__, fn state -> chain_updated end)
    chain_updated
  end
end
