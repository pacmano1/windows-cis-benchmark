<#
.SYNOPSIS
    RDP diagnostics — shows everything relevant to why RDP might be broken.
.DESCRIPTION
    Run this from an elevated console session to diagnose RDP connectivity
    issues after applying CIS hardening. Does not modify anything.
.NOTES
    Read-only — safe to run at any time.
#>
#Requires -RunAsAdministrator

$ErrorActionPreference = 'Continue'

Write-Host ''
Write-Host '  RDP Diagnostics' -ForegroundColor White
Write-Host '  ===============' -ForegroundColor DarkGray
Write-Host ''

# -- RDP Listener --
Write-Host '  RDP Listener (port 3389)' -ForegroundColor Cyan
Write-Host '  ------------------------' -ForegroundColor DarkGray
$listeners = netstat -an | Select-String ':3389'
if ($listeners) {
    foreach ($l in $listeners) {
        Write-Host "    $($l.Line.Trim())" -ForegroundColor Green
    }
} else {
    Write-Host '    !  Nothing listening on 3389' -ForegroundColor Red
}

# -- TermService --
Write-Host ''
Write-Host '  TermService' -ForegroundColor Cyan
Write-Host '  -----------' -ForegroundColor DarkGray
try {
    $svc = Get-Service TermService -ErrorAction Stop
    $color = if ($svc.Status -eq 'Running') { 'Green' } else { 'Red' }
    Write-Host "    Status:    $($svc.Status)" -ForegroundColor $color
    Write-Host "    StartType: $($svc.StartType)" -ForegroundColor DarkGray
} catch {
    Write-Host "    !  Cannot query TermService: $_" -ForegroundColor Red
}

# -- RDP Registry --
Write-Host ''
Write-Host '  RDP Registry Settings' -ForegroundColor Cyan
Write-Host '  ---------------------' -ForegroundColor DarkGray

$tsPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
$rdpTcpPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
$tsPolPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'

$fDeny = (Get-ItemProperty -Path $tsPath -Name 'fDenyTSConnections' -ErrorAction SilentlyContinue).fDenyTSConnections
$color = if ($fDeny -eq 0) { 'Green' } else { 'Red' }
Write-Host "    fDenyTSConnections:  $fDeny" -ForegroundColor $color

if (Test-Path $rdpTcpPath) {
    $rdpTcp = Get-ItemProperty -Path $rdpTcpPath -ErrorAction SilentlyContinue
    Write-Host "    Listener NLA:        $($rdpTcp.UserAuthentication)" -ForegroundColor $(if ($rdpTcp.UserAuthentication -eq 0) { 'Green' } else { 'Yellow' })
    Write-Host "    Listener Security:   $($rdpTcp.SecurityLayer)" -ForegroundColor $(if ($rdpTcp.SecurityLayer -eq 0) { 'Green' } else { 'Yellow' })
    Write-Host "    Listener Port:       $($rdpTcp.PortNumber)" -ForegroundColor DarkGray
}

# -- Terminal Services Policy Overrides --
Write-Host ''
Write-Host '  Terminal Services Policy Overrides' -ForegroundColor Cyan
Write-Host '  ----------------------------------' -ForegroundColor DarkGray
if (Test-Path $tsPolPath) {
    $tsPol = Get-ItemProperty -Path $tsPolPath -ErrorAction SilentlyContinue
    $props = $tsPol.PSObject.Properties | Where-Object { $_.Name -notin @('PSPath','PSParentPath','PSChildName','PSProvider','PSDrive') }
    if ($props) {
        foreach ($p in $props) {
            Write-Host "    $($p.Name) = $($p.Value)" -ForegroundColor Yellow
        }
    } else {
        Write-Host '    (none)' -ForegroundColor Green
    }
} else {
    Write-Host '    (no policy key)' -ForegroundColor Green
}

# -- Network Profile --
Write-Host ''
Write-Host '  Network Profile' -ForegroundColor Cyan
Write-Host '  ---------------' -ForegroundColor DarkGray
try {
    $profiles = Get-NetConnectionProfile -ErrorAction Stop
    foreach ($p in $profiles) {
        Write-Host "    $($p.InterfaceAlias): $($p.NetworkCategory) ($($p.Name))" -ForegroundColor $(
            if ($p.NetworkCategory -eq 'Public') { 'Yellow' } else { 'Green' }
        )
    }
} catch {
    Write-Host "    !  Cannot query: $_" -ForegroundColor Red
}

# -- Firewall State (netsh) --
Write-Host ''
Write-Host '  Firewall State' -ForegroundColor Cyan
Write-Host '  --------------' -ForegroundColor DarkGray
$fwOutput = netsh advfirewall show allprofiles state 2>&1
foreach ($line in $fwOutput) {
    $trimmed = "$line".Trim()
    if ($trimmed -and $trimmed -ne '-------------------------------------------------------------------' -and $trimmed -ne 'Ok.') {
        Write-Host "    $trimmed" -ForegroundColor DarkGray
    }
}

Write-Host ''
Write-Host '  Firewall Default Policy' -ForegroundColor Cyan
Write-Host '  -----------------------' -ForegroundColor DarkGray
$fwPolicy = netsh advfirewall show allprofiles firewallpolicy 2>&1
foreach ($line in $fwPolicy) {
    $trimmed = "$line".Trim()
    if ($trimmed -and $trimmed -ne '-------------------------------------------------------------------' -and $trimmed -ne 'Ok.') {
        $color = if ($trimmed -match 'BlockInbound') { 'Yellow' } else { 'DarkGray' }
        Write-Host "    $trimmed" -ForegroundColor $color
    }
}

# -- Firewall Policy Registry --
Write-Host ''
Write-Host '  Firewall Policy Registry' -ForegroundColor Cyan
Write-Host '  ------------------------' -ForegroundColor DarkGray

$fwProfiles = @(
    @{ Name = 'Domain';  Path = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile' }
    @{ Name = 'Private'; Path = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' }
    @{ Name = 'Public';  Path = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile' }
)

foreach ($profile in $fwProfiles) {
    Write-Host "    --- $($profile.Name) ---" -ForegroundColor White
    if (Test-Path $profile.Path) {
        $regProps = Get-ItemProperty -Path $profile.Path -ErrorAction SilentlyContinue
        $items = $regProps.PSObject.Properties | Where-Object { $_.Name -notin @('PSPath','PSParentPath','PSChildName','PSProvider','PSDrive') }
        if ($items) {
            foreach ($item in $items) {
                $color = if ($item.Name -in @('DefaultInboundAction','AllowLocalPolicyMerge','EnableFirewall') -and $item.Value -ge 1) { 'Yellow' } else { 'DarkGray' }
                Write-Host "    $($item.Name) = $($item.Value)" -ForegroundColor $color
            }
        } else {
            Write-Host '    (empty)' -ForegroundColor Green
        }

        # Check Logging subkey
        $logPath = "$($profile.Path)\Logging"
        if (Test-Path $logPath) {
            $logProps = Get-ItemProperty -Path $logPath -ErrorAction SilentlyContinue
            $logItems = $logProps.PSObject.Properties | Where-Object { $_.Name -notin @('PSPath','PSParentPath','PSChildName','PSProvider','PSDrive') }
            foreach ($li in $logItems) {
                Write-Host "    Logging\$($li.Name) = $($li.Value)" -ForegroundColor DarkGray
            }
        }
    } else {
        Write-Host '    (no policy key)' -ForegroundColor Green
    }
}

# -- RDP Firewall Rules --
Write-Host ''
Write-Host '  RDP Firewall Rules' -ForegroundColor Cyan
Write-Host '  ------------------' -ForegroundColor DarkGray
try {
    $rdpRules = Get-NetFirewallRule -DisplayGroup 'Remote Desktop' -ErrorAction Stop
    foreach ($rule in $rdpRules) {
        $color = if ($rule.Enabled -eq 'True') { 'Green' } else { 'Red' }
        Write-Host "    $($rule.DisplayName)" -ForegroundColor $color
        Write-Host "      Enabled=$($rule.Enabled)  Direction=$($rule.Direction)  Profile=$($rule.Profile)  Action=$($rule.Action)" -ForegroundColor DarkGray
    }
} catch {
    Write-Host "    !  Cannot query: $_" -ForegroundColor Red
}

# -- Summary --
Write-Host ''
Write-Host '  Quick Assessment' -ForegroundColor White
Write-Host '  ----------------' -ForegroundColor DarkGray

$issues = @()
if ($fDeny -ne 0)                         { $issues += 'RDP is disabled (fDenyTSConnections != 0)' }
if (-not $listeners)                       { $issues += 'Nothing listening on port 3389' }
if ((Get-Service TermService).Status -ne 'Running') { $issues += 'TermService is not running' }

foreach ($profile in $fwProfiles) {
    if (Test-Path $profile.Path) {
        $inb = (Get-ItemProperty -Path $profile.Path -Name 'DefaultInboundAction' -ErrorAction SilentlyContinue).DefaultInboundAction
        $merge = (Get-ItemProperty -Path $profile.Path -Name 'AllowLocalPolicyMerge' -ErrorAction SilentlyContinue).AllowLocalPolicyMerge
        if ($inb -eq 1) { $issues += "$($profile.Name) firewall policy blocks inbound by default" }
        if ($merge -eq 0) { $issues += "$($profile.Name) firewall policy ignores local allow rules" }
    }
}

$tsPolExists = Test-Path $tsPolPath
if ($tsPolExists) {
    $nla = (Get-ItemProperty -Path $tsPolPath -Name 'UserAuthentication' -ErrorAction SilentlyContinue).UserAuthentication
    $sl  = (Get-ItemProperty -Path $tsPolPath -Name 'SecurityLayer' -ErrorAction SilentlyContinue).SecurityLayer
    if ($nla -eq 1) { $issues += 'NLA enforced via policy (requires domain)' }
    if ($sl -eq 2)  { $issues += 'TLS SecurityLayer enforced via policy (requires domain certs)' }
}

if ($issues.Count -eq 0) {
    Write-Host '    +  No obvious issues found' -ForegroundColor Green
    Write-Host '    ?  If RDP still fails, check Security Group / NACL / host firewall rules' -ForegroundColor Yellow
} else {
    Write-Host "    !  Found $($issues.Count) potential issue(s):" -ForegroundColor Red
    foreach ($issue in $issues) {
        Write-Host "    -  $issue" -ForegroundColor Red
    }
}

Write-Host ''
