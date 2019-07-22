defmodule Blockchain.Application do
  @moduledoc "OTP Application specification for WebhookProcessor"

  use Application

  def start() do
    # List all child processes to be supervised
    children = [
      # Use Plug.Cowboy.child_spec/3 to register our endpoint as a plug
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Blockchain.Endpoint,
        options: [port: 4001]
      )
    ]

    Blockchain.Server.start_link()

    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Blockchain.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
