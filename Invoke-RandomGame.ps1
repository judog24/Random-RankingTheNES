Import-Module .\Get-RandomGame.psm1 -Force

$rankingURL = "https://raw.githubusercontent.com/vNakamura/8bitnintendo-science/refs/heads/main/_data/list.csv"
Receive-GamesCSV -ListURL $rankingURL

$game = Get-RandomGame
Format-Message -SelectedGame $game
$url = Format-Url -ytid $game.ytid -seconds $game.seconds
Start-Process $url
