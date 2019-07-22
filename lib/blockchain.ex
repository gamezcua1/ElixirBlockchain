defmodule Blockchain do
  alias Blockchain.Chain, as: Chain
  alias Blockchain.Block, as: Block
  alias Blockchain.Transaction, as: Transaction

  def test() do
    chain = Chain.new_chain()

    chain =
      Transaction.new_transaction(
        chain,
        "Sender#{:rand.uniform(10)}",
        :rand.uniform(10000),
        :rand.uniform(99_999_999)
      )

    {chain, _} = Block.new_block(chain, "proof1")

    chain =
      Transaction.new_transaction(
        chain,
        "Sender#{:rand.uniform(10)}",
        :rand.uniform(10000),
        :rand.uniform(99_999_999)
      )

    chain =
      Transaction.new_transaction(
        chain,
        "Sender#{:rand.uniform(10)}",
        :rand.uniform(10000),
        :rand.uniform(99_999_999)
      )

    {chain, _} = Block.new_block(chain, "proof2")

    chain =
      Transaction.new_transaction(
        chain,
        "Sender#{:rand.uniform(10)}",
        :rand.uniform(10000),
        :rand.uniform(99_999_999)
      )

    chain =
      Transaction.new_transaction(
        chain,
        "Sender#{:rand.uniform(10)}",
        :rand.uniform(10000),
        :rand.uniform(99_999_999)
      )

    {chain, _} = Block.new_block(chain, "proof3")

    chain =
      Transaction.new_transaction(
        chain,
        "Sender#{:rand.uniform(10)}",
        :rand.uniform(10000),
        :rand.uniform(99_999_999)
      )
  end
end
