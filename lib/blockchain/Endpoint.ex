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

  #END POINTS

  #mine
  get "/mine" do
    send_resp(conn, 200, "We'll mine a new block")
  end

  #new transcation 
  post "/transactions/new" do
    params = conn.body_params
    
    %Chain{chain: chain} = Server.value
                          |> Transaction.new_transaction(params["sender"], 
                                                         params["recipient"], 
                                                         params["amount"])
                          |> Server.set

    %Block{index: index} = hd(chain)
    send_resp(conn, 200, "Transaction added to block #{index}")
  end

  get "/chain" do
    chain_response = Server.value |>  get_chain_response
    send_resp(conn, 200, chain_response)
  end


  defp get_chain_response(%Chain{chain: this_chain} = chain) do
    %{"chain" => chain, "length" => length(this_chain)}
    |> Poison.encode!
  end


end

