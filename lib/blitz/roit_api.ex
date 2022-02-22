defmodule Blitz.Roit.Api do
  @moduledoc """
  All Roit apis wrapper functions
  """

  alias Blitz.HTTP.Client

  @default_region "NA1"

  def get_match_by_id(match_id, region \\ @default_region) do
    path = "/lol/match/v5/matches/#{match_id}"

    path
    |> api_url(region_to_area(region))
    |> Client.get()
  end

  def get_recent_matches(puuid, region \\ @default_region) do
    path = "/lol/match/v5/matches/by-puuid/#{puuid}/ids"

    path
    |> api_url(region_to_area(region))
    |> Client.get()
  end

  # The AMERICAS routing value serves NA, BR, LAN, LAS,and OCE.
  # The ASIA routing value serves KR and JP.
  # The EUROPE routing value serves EUNE, EUW, TR, and RU.
  defp region_to_area(region) do
    case region do
      "NA1" -> "americas"
      "NA" -> "americas"
      "BR" -> "americas"
      "LAN" -> "americas"
      "LAS" -> "americas"
      "KR" -> "asia"
      "JP" -> "asia"
      "EUNE" -> "europe"
      "EUW" -> "europe"
      "TR" -> "europe"
      "RU" -> "europe"
      _ -> "americas"
    end
  end

  @doc
  """
  get_account_by_name(name, region)

  ## Example
    iex> get_account_by_name("sharkta", "NA1")
        {:ok,
          {
            "id": "Vdd3bwSet35dkgG-spDJfpXVh_4knZgqRbFEyCUOOJWkk7TU",
            "accountId": "HvmIH31aiQwVAaoK9Ig7rBBon1uCAslScV8zwPZlRAiFiae94xTp7BWa",
            "puuid": "am0LFjAmEuEWk650innGAyFfCxxR-S69oCIL50GXrOCCyF8wMJoBC3wtuilgzpmL9IYKZTKump3ZuA",
            "name": "sharkta",
            "profileIconId": 3542,
            "revisionDate": 1608535767000,
            "summonerLevel": 23
          }
        }
  """
  def get_account_by_name(name, region \\ @default_region) do
    path = "/lol/summoner/v4/summoners/by-name/#{name}"
    path |> api_url(region) |> Client.get()
  end

  @api_root "https://api.riotgames.com"
  def api_url(path, region) do
    uri = URI.parse(@api_root)
    host = "#{String.downcase(region)}.#{uri.host}"

    uri
    |> Map.put(:host, host)
    |> Map.put(:path, "#{path}")
    |> URI.to_string()
  end
end
