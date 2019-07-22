defmodule Blockchain.Chain do
  alias Blockchain.Chain, as: Chain
  alias Blockchain.Block, as: Block

  defstruct chain: [],
            current_transactions: []

  def new_chain do
    {chain, _} = %Chain{} |> Block.new_block(100, 1)
    chain
  end

  def reset_current_transactions(chain) do
    %Chain{chain | current_transactions: []}
  end

  def add_transaction(chain, transaction) do
    %Chain{chain | current_transactions: [transaction | chain.current_transactions]}
    |> transaction_added
  end

  def add_block(chain, block) do
    {%Chain{chain | chain: [block | chain.chain]}, block}
  end

  def transaction_added(%Chain{chain: this_chain} = chain) do
    last = hd(this_chain)

    List.replace_at(this_chain, 0, %Block{last | index: last.index + 1})
    |> change_transactions(chain)
  end

  def change_transactions(new_chain, chain) do
    %Chain{chain | chain: new_chain}
  end

  def get_last_block(%Chain{chain: this_chain}) do
    hd(this_chain)
  end

  def get_proof_of_work(%Block{proof: last_proof} = last_block) do
    last_hash = last_block |> Block.hash()
    get_proof_of_work(last_proof, 0, last_hash)
  end

  def get_proof_of_work(last_proof, proof, last_hash) do
    if valid_proof(last_proof, proof, last_hash) do
      proof
    else
      get_proof_of_work(last_proof, proof + 1, last_hash)
    end
  end

  def valid_proof(last_proof, proof, last_hash) do
    guess = "#{last_proof}#{proof}#{last_hash}"

    :crypto.hash(:sha256, guess)
    |> Base.encode16()
    |> String.slice(-4..-1) == "0000"
  end
end
