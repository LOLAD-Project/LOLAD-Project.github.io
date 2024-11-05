<#
.SYNOPSIS
    A PowerShell script to request and display commands from the LOLAD project repository based on specified keywords or technique numbers.
.DESCRIPTION
    This script retrieves command data from the LOLAD project's HTML table and filters it according to the provided keyword or technique number.
    It displays the commands in a formatted table or outputs specific command details.
.PARAMETER Keyword
    This is optional . A string to filter commands by the technique name or command.

.PARAMETER Number
   This is optional. An integer to display a specific command based on its number.

.EXAMPLE
    .\search-lolad.ps1
    Displays all available PowerShell commands from the LOLAD project.

.EXAMPLE
    .\search-lolad.ps1 -Keyword dns
    Filters commands containing "DNS" in their technique name or command.

.EXAMPLE
    .\search-lolad.ps1 -Keyword dns -number 55
    Displays the command associated with technique number 55.
    Identify Computers with Unconstrained Delegation

.AUTHOR

    CDRC LBRS
    cdrc@lbrs.io
    
.LICENSE
    MIT License
#>

param (
    [string]$Keyword = "",
    [int]$Number = 0
)

$url = "https://lolad-project.github.io/"
$response = Invoke-WebRequest -Uri $url
$parsedHtml = $response.Content
$tableData = [regex]::Match($parsedHtml, '<tbody>(.*?)<\/tbody>', [System.Text.RegularExpressions.RegexOptions]::Singleline).Groups[1].Value
$powerShellCommands = @()
$rows = $tableData -split '<tr>'
$counter = 1

foreach ($row in $rows[1..$rows.Length]) {
    $columns = [regex]::Matches($row, '<td.*?>(.*?)<\/td>') | ForEach-Object { $_.Groups[1].Value.Trim() }
    if ($columns.Count -ge 3 -and $columns[2] -match 'PowerShell') {
        $commandDetail = [PSCustomObject]@{
            Number         = $counter
            Technique_Name = $columns[0]
            Command        = $columns[1] -replace '<code>|</code>', ''
            Type           = $columns[2]
            Reference      = [regex]::Match($columns[3], 'href="(.*?)"').Groups[1].Value
        }
        if ($Keyword -eq "" -or $commandDetail.Technique_Name -like "*$Keyword*" -or $commandDetail.Command -like "*$Keyword*") {
            $powerShellCommands += $commandDetail
        }
        $counter++
    }
}

if ($Number -gt 0) {
    $commandToDisplay = $powerShellCommands | Where-Object { $_.Number -eq $Number }
    if ($commandToDisplay) {
        Write-Output "Command for Technique Number ${Number}:"
        Write-Output "----------------------------------------"
        Write-Host "$($commandToDisplay.Technique_Name)" -ForegroundColor Magenta
        Write-Output "----------------------------------------"
        Write-Host "$($commandToDisplay.Command)" -ForegroundColor Yellow
        Write-Output "---"
        Write-Output ">> Reference: $($commandToDisplay.Reference)"
    } else {
        Write-Output "No command found for Technique Number ${Number}."
    }
} else {
    $powerShellCommands | Format-Table -AutoSize
}
