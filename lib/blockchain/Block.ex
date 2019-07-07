defmodule Blockchain.Block do
  alias Blockchain.Block, as: Block
  alias Blockchain.Chain, as: Chain

  defstruct index: nil, timestamp: nil, transactions: [], 
            proof: nil, previous_hash: nil

  def new_block(%Chain{chain: current_chain} = chain, proof, previous_hash \\ nil) do
    previous_hash = if previous_hash == nil,
                    do: hash(to_str(hd(current_chain))),
                    else: previous_hash
    block = %Block{
      index: length(chain.chain),
      timestamp: "#{Time.utc_now}",
      transactions: chain.current_transactions,
      proof: proof,
      previous_hash:  previous_hash
    }

    chain |> Chain.reset_current_transactions |> Chain.add_block(block)
  end

  
  def hash(str_block) when is_binary(str_block) do
    :crypto.hash(:sha256, str_block) |> Base.encode16
  end
  
  def hash({:ok, str_block}) do
    :crypto.hash(:sha256, str_block) |> Base.encode16
  end

  def to_str(block) do
    transactions = Enum.map(block.transactions, fn val -> Map.from_struct(val) end)
    %{Map.from_struct(block) | transactions: transactions}
    |> Jason.encode
  end
end