defmodule Blockchain.Block do
  alias Blockchain.Block, as: Block
  alias Blockchain.Chain, as: Chain

  defstruct index: nil, timestamp: nil, transactions: [], proof: nil, previous_hash: nil

  def new_block(%Chain{chain: current_chain} = chain, proof, previous_hash \\ nil) do
    previous_hash =
      if previous_hash == nil,
        do: current_chain |> hd |> hash,
        else: previous_hash

    block = %Block{
      index: length(chain.chain),
      timestamp: "#{Time.utc_now()}",
      transactions: chain.current_transactions,
      proof: proof,
      previous_hash: previous_hash
    }

    chain |> Chain.reset_current_transactions() |> Chain.add_block(block)
  end

  def hash(block) do
    json = Poison.encode!(block)

    :crypto.hash(:sha256, json)
    |> Base.encode16()
  end
end
