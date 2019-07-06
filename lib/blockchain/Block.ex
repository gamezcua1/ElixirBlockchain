defmodule Blockchain.Block do
  alias Blockchain.Block, as: Block

  defstruct index: nil, timestamp: nil, transactions: [], 
            proof: nil, previous_hash: nil

  def new_block(chain, proof, previous_hash) do
    %Block{}
  end
end