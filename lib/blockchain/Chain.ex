defmodule Blockchain.Chain do
  alias Blockchain.Chain, as: Chain
  alias Blockchain.Block, as: Block

  defstruct chain: [],
            current_transactions: [],
            last_block: nil
  

  def reset_current_transactions(chain) do
    %Chain{}
  end
  
end