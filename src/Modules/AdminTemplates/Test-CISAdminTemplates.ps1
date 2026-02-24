function Test-CISAdminTemplates {
    <#
    .SYNOPSIS
        Audits CIS Section 18 — Administrative Templates (Computer) controls.
    .DESCRIPTION
        All controls are registry-based. Reads current values and compares
        against CIS-required values.
    #>
    [CmdletBinding()]
    param()

    $moduleName = 'AdminTemplates'
    $controls   = $script:CISConfig.ModuleConfigs[$moduleName].Controls
    if (-not $controls) {
        Write-CISLog -Message 'No controls loaded for AdminTemplates' -Level Warning -Module $moduleName
        return @()
    }

    $results = foreach ($ctl in $controls) {
        if ($ctl.Skipped) {
            [PSCustomObject]@{
                Id       = $ctl.Id
                Title    = $ctl.Title
                Module   = $moduleName
                Status   = 'Skipped'
                Expected = ''
                Actual   = ''
                Detail   = $ctl.SkipReason
            }
            continue
        }

        try {
            Test-RegistryControl -Control $ctl -ModuleName $moduleName
        } catch {
            [PSCustomObject]@{
                Id       = $ctl.Id
                Title    = $ctl.Title
                Module   = $moduleName
                Status   = 'Error'
                Expected = ''
                Actual   = ''
                Detail   = $_.Exception.Message
            }
        }
    }

    return $results
}
