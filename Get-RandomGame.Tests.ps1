BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Format-Url' {
    It "Should return a string with a valid YouTube URL" {
        Format-Url -ytid "vMr8Tff5fn0" -seconds 345 | Should -Be "https://www.youtube.com/watch?v=vMr8Tff5fn0&t=345s"
    }
}