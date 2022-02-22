defmodule Blitz do
  @moduledoc """
  Documentation for `Blitz`.
  """
  alias Blitz.Roit.Api

  @default_region "NA1"
  def get_summoners(summoner_name, region \\ @default_region) do
    with {:ok, account} <- Api.get_account_by_name(summoner_name),
         {:ok, matches} <- Api.get_recent_matches(account["puuid"], region) do
      players =
        matches
        |> Enum.reduce(MapSet.new(), fn m, acc ->
          MapSet.union(acc, get_match_players(m))
        end)
        |> MapSet.to_list()

      # monitor all players
      monitor(players)

      # return players, exclude myself
      players -- [summoner_name]
    else
      _ -> []
    end
  end

  defp get_match_players(match_id) do
    with {:ok, res} <- Api.get_match_by_id(match_id) do
      players = res["info"]["participants"]

      Enum.reduce(players, MapSet.new(), fn player, acc ->
        MapSet.put(acc, player["summonerName"])
      end)
    else
      _ -> MapSet.new()
    end
  end

  def monitor(summoners) do
    ## TODO, maybe using redis, will TTL 1hr from now
  end

  @doc """
  When a summoner finishs a matched, call this function to log information.
  Note only these inside the monitored list is pl
  """
  def log_match_played(summoner_name, match_id) do
    Logger.info("Summoner #{summoner_name} completed match #{match_id}.")
  end

  def get() do
    Application.get_env(:hello, :riot_api_key)
  end
end
