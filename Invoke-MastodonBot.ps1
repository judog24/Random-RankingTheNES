Import-Module .\Get-RandomGame.psm1 -Force

if (test-path -Path '.\config.psd1') {
    $Config = Import-PowerShellDataFile '.\config.psd1'
    $Env:MastodonInstance = $Config.MastodonInstance
    $Env:AccessToken = $Config.AccessToken
}

$rankingURL = "https://raw.githubusercontent.com/vNakamura/8bitnintendo-science/refs/heads/main/_data/list.csv"
Receive-GamesCSV -ListURL $rankingURL

$game = Get-RandomGame
$message = Format-Message -SelectedGame $game

$headers = @{
    "Authorization" = "Bearer $($Env:AccessToken)"
}

$body = @{
    status = $message
}

try {
    Invoke-RestMethod -Uri $Env:MastodonInstance -Method Post -Headers $headers -Body $body
}
catch {
    "Unable to post message"
}
