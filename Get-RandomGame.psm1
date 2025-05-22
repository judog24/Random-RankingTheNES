function Receive-GamesCSV {
    <#
        .SYNOPSIS
            Downloads the latest game ranking data.
    #>
    [CmdletBinding()]
    param (
        [string]$ListURL
    )
    process {
        try {
            Invoke-WebRequest -Uri $ListURL -OutFile "data.csv" -UseBasicParsing
        }
        catch {
            "Unable to download CSV"
        }
    }
}

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
        .SYNOPSIS
            Constructs the message that will be displayed.
    #>
    [OutputType([string])]
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
        .SYNOPSIS
    #>
    [OutputType([object])]
    $csv = '.\data.csv'
    $games = Import-Csv $csv

    $randomGame = Get-Random -InputObject $Games
    $randomGame
}
