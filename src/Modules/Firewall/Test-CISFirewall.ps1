function Test-CISFirewall {
    <#
    .SYNOPSIS
        Audits CIS Section 9 — Windows Defender Firewall controls.
    #>
    [CmdletBinding()]
    param()

    $moduleName = 'Firewall'
    $controls   = $script:CISConfig.ModuleConfigs[$moduleName].Controls
    if (-not $controls) {
        Write-CISLog -Message 'No controls loaded for Firewall' -Level Warning -Module $moduleName
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
