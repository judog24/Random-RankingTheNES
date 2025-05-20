function Format-Url {
    <#
        .SYNOPSIS
            Uses the ytid and seconds columns from csv to return a YouTube url.
    #>
    [OutputType([string])]
    param (
        [string]$ytid,
        [int]$seconds
    )
    begin {
        [string]$baseURL = "https://www.youtube.com/watch?v="
    }
    process {
        # Example url: https://www.youtube.com/watch?v=vMr8Tff5fn0&t=345s
        $videoURL = $baseURL + $ytid + "&t=" + [string]$seconds + "s"
        $videoURL
    }
}

function Format-Message {
    <#
    
    #>
    param (
        [object]$SelectedGame
    )
    begin {
        [object]$ComparedGame = Get-RandomGame
        [string]$videoURL = Format-Url -ytid $SelectedGame.ytid -seconds $SelectedGame.seconds
    }
    process {
        [string]$message = "Is $($SelectedGame.game) better than $($ComparedGame.game)? Let's find out! `n`n$videoURL"
        $message
    }
}

function Get-RandomGame {
    <#
    
    #>
    $csv = '.\data.csv'
    $games = Import-Csv $csv

    $randomGame = Get-Random -InputObject $Games
    $randomGame
}

$game = Get-RandomGame
Format-Message -SelectedGame $game
$url = Format-Url -ytid $game.ytid -seconds $game.seconds
Start-Process $url