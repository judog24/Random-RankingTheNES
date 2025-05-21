Import-Module .\Get-RandomGame.psm1

if (test-path -Path '.\config.psd1') {
    $Config = Import-PowerShellDataFile '.\config.psd1'
} else {
    $Config = @{
        MastodonInstance = ""
        AccessToken = ""
    }
}

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

Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body