Import-Module .\Get-RandomGame.psm1 -Force

if (test-path -Path '.\config.psd1') {
    $Config = Import-PowerShellDataFile '.\config.psd1'
} else {
    $Config = @{
        MastodonInstance = ""
        AccessToken = ""
    }
}

$rankingURL = "https://raw.githubusercontent.com/vNakamura/8bitnintendo-science/refs/heads/main/_data/list.csv"
Receive-GamesCSV -ListURL $rankingURL

$game = Get-RandomGame
$message = Format-Message -SelectedGame $game

$url = $Config.MastodonInstance
$token = $Config.AccessToken

$headers = @{
    "Authorization" = "Bearer $($token)"
}

$body = @{
    status = $message
}

try {
    Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body
}
catch {
    "Unable to post message"
}
