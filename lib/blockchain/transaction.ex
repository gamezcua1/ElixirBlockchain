defmodule Blockchain.Transaction do
  alias Blockchain.Transaction, as: Transaction
  alias Blockchain.Chain, as: Chain

  defstruct sender: nil, recipient: nil, amount: nil

  def new_transaction(chain, sender, recipient, amount) do
    chain
    |> Chain.add_transaction(%Transaction{sender: sender, recipient: recipient, amount: amount})
  end
end
