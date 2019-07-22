defmodule Blockchain.Endpoint do
  use Plug.Router

  alias Blockchain.Chain, as: Chain
  alias Blockchain.Block, as: Block
  alias Blockchain.Transaction, as: Transaction
  alias Blockchain.Server, as: Server

  # plug configuration
  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  # END POINTS

  # mine
  get "/mine" do
    last_block = Server.value() |> Chain.get_last_block()
    proof = last_block |> Chain.get_proof_of_work()

    Server.value()
    |> Transaction.new_transaction("0", "blockchain", 1)
    |> Server.set()

    previous_hash = Block.hash(last_block)

    {_chain,
     %Block{index: index, transactions: transactions, proof: proof, previous_hash: previous_hash} =
       block} = Server.value() |> Block.new_block(proof, previous_hash)

    IO.inspect(block)

    res =
      %{
        message: "New Block Forged",
        index: index,
        transactions: transactions,
        proof: proof,
        previous_hash: previous_hash
      }
      |> Poison.encode!()

    send_resp(conn, 200, res)
  end

  # new transcation 
  post "/transactions/new" do
    params = conn.body_params

    %Chain{chain: chain} =
      Server.value()
      |> Transaction.new_transaction(
        params["sender"],
        params["recipient"],
        params["amount"]
      )
      |> Server.set

    %Block{index: index} = hd(chain)
    send_resp(conn, 200, "Transaction added to block #{index}")
  end

  get "/chain" do
    chain_response = Server.value() |> get_chain_response
    send_resp(conn, 200, chain_response)
  end

  defp get_chain_response(%Chain{chain: this_chain} = chain) do
    %{"chain" => chain, "length" => length(this_chain)}
    |> Poison.encode!()
  end
end
