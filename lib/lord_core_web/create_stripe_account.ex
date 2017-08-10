defmodule LordCoreWeb.CreateStripeAccount do
  require IEx

  def create_account do
    account_url = "https://api.stripe.com/v1/accounts"
    key = "sk_test_pw2gaooyvi3aPoTwdOs2XvX2"

    headers = [
      {"Authorization", "Bearer sk_test_pw2gaooyvi3aPoTwdOs2XvX2"},
      {"Content-type", "application/x-www-form-urlencoded"}
    ]
    body = {:form, [{"country", "US"}, {"type", "custom"}]}

    {status, response} = HTTPoison.post(account_url, body, headers)
    case status do
      :ok ->
        account_data = Poison.decode(response.body)
        IEx.pry
        #save account here
      _ ->
        #some error condition here
    end
  end
end
