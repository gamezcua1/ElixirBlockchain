defmodule Blockchain.Block do
  alias Blockchain.Block, as: Block

  defstruct index: nil, timestamp: nil, transactions: [], 
            proof: nil, previous_hash: nil

  def new_block(chain, proof, previous_hash) do
    %{
      index: length(chain.chain),
      timestamp: Time.utc_now,
      transactions: chain.current_transactions,
      proof: proof,
      previous_hash: previous_hash
    }
  end

  def hash(block) do
    str = Enum.map_join(block, ", ", fn {key, val} -> "'#{key}': #{val}" end)
    :crypto.hash(:sha256, str) |> Base.encode16
  end
end