Import-Module .\Get-RandomGame.psm1

$game = Get-RandomGame
Format-Message -SelectedGame $game
$url = Format-Url -ytid $game.ytid -seconds $game.seconds
Start-Process $url