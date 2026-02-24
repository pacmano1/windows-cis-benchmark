function Write-CISLog {
    <#
    .SYNOPSIS
        Writes structured log entries to console and file.
    .PARAMETER Message
        Log message text.
    .PARAMETER Level
        Severity: Debug, Info, Warning, Error.
    .PARAMETER Module
        CIS module name for context (e.g., SecurityOptions).
    .PARAMETER ControlId
        CIS control ID (e.g., 2.3.1.1).
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet('Debug','Info','Warning','Error')]
        [string]$Level = 'Info',

        [string]$Module = '',

        [string]$ControlId = ''
    )

    # Respect global log-level threshold
    $levelOrder = @{ 'Debug' = 0; 'Info' = 1; 'Warning' = 2; 'Error' = 3 }
    $threshold  = if ($script:CISConfig.LogLevel) { $script:CISConfig.LogLevel } else { 'Info' }
    if ($levelOrder[$Level] -lt $levelOrder[$threshold]) { return }

    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $prefix    = if ($ControlId) { "[$ControlId]" } elseif ($Module) { "[$Module]" } else { '' }
    $entry     = "$timestamp [$Level] $prefix $Message"

    # Console output with colour
    switch ($Level) {
        'Debug'   { Write-Verbose $entry }
        'Info'    { Write-Host $entry -ForegroundColor Cyan }
        'Warning' { Write-Warning $entry }
        'Error'   { Write-Host $entry -ForegroundColor Red }
    }

    # File output
    if ($script:LogFile) {
        $entry | Out-File -FilePath $script:LogFile -Append -Encoding utf8
    }
}
