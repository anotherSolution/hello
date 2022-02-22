# Setup 
- update `riot_api_key` in config/config.exs 
- `mix deps.get`
- `iex -S mix`

# Qucik Test 
  1. Fetch all summoners this summoner has played with in the last 5 matches by calling `Blitz.get_summoners/2`, eg: 
     
    iex> Blitz.get_summoners("sharkta", "NA1")

      ["katsuragishinji", "saintz08", "Your Wife69", "shaminmike","Itdontworkmang1", "EvolveTwisted", "PanasDalam", "lightningace1","squid fo sho", "The Cat of Time", "Stranger126", "Skyla272","CloakedOne02", "VonMarkus", "Null540", "Emma Fox","christopher3148", "TTm3anspi", "Tha Gymkage", "Phase360","VuittonLouis1854", "nguyenngocnhan", "Batcat63","NetflixBeast666", "McYeetxs", "TehNewDucky", "Grixvy","Jrxdgaming", "Jewlion1095", "Fraygoon", "moistly", "Dharmaraj56","milkBaby2x", "MonkeyDRocky95", "McYeetus2", "Dmitri Ronin","hatcher05", "DaddyDrique", "zkrillin", "Buttoxtoucher69"]


  2. When a match is complete, try to call 
    `Blitz.log_match_played("summoner_name", "match_id")`


