defmodule Blitz.HTTP.Client do
  @moduledoc """
  http client wrapper.
  """

  @doc """
  API GET (url)
  ## Examples
      iex> Client.get(url)
      {:ok, response}
  """
  def get(url) do
    token = get_api_key()

    headers = [
      "X-Riot-Token": "#{token}",
      "Accept-Language": "en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7",
      "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
      Origin: "https://developer.riotgames.com"
      # Accept: "Application/json; Charset=utf-8"
    ]

    options = [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 3000]

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "404"}

      # TODO: retry here
      {:ok, %HTTPoison.Response{status_code: 429}} ->
        {:error, "429"}

      {:ok, %{status: status_code}} ->
        raise "Unhandled status code: #{inspect(status_code)}"

        # {:error, %HTTPoison.Error{reason: reason}} ->
        #   {:error, reason}
    end
  end

  def get_api_key(), do: Application.get_env(:hello, :riot_api_key)
end
