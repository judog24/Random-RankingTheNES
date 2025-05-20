function Import-Games {
    <#
    
    #>
    [CmdletBinding()]
    param (
        [string]$csv
    )
    begin {
        $gameData = Import-Csv $csv
    }
    process {
        $gameData
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

$csv = '.\data.csv'
$games = Import-Games -csv $csv
$games