defmodule Blockchain.Chain do
  alias Blockchain.Chain, as: Chain
  alias Blockchain.Block, as: Block

  defstruct chain: [],
            current_transactions: []
  
  def new_chain do
    Block.new_block(%Chain{}, 100, 1)
  end

  def reset_current_transactions(chain) do
    %Chain{chain | current_transactions: []}
  end

  def add_transaction(chain, transaction) do
    %Chain{chain | current_transactions: [ transaction | chain.current_transactions]}
    |> transaction_added
  end

  def add_block(chain, block) do
    {%Chain{chain | chain: [ block | chain.chain]}, block}
  end

  def transaction_added(%Chain{chain: this_chain} = chain) do
    last = hd(this_chain)
    List.replace_at(this_chain, 0, %Block{last | index: last.index + 1})
    |> change_transactions(chain)
  end

  def change_transactions(new_chain, chain) do
    %Chain{chain | chain: new_chain}
  end

end