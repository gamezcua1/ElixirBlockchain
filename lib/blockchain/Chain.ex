defmodule Blockchain.Chain do
  alias Blockchain.Chain, as: Chain
  alias Blockchain.Block, as: Block

  defstruct chain: [],
            current_transactions: [],
            last_block: nil
  

  def reset_current_transactions(chain) do
    %Chain{chain | current_transactions: []}
  end

  def add_block(chain, block) do
    %Chain{chain | chain: [ block | chain.chain]}
  end
  
end