@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Benchmark L1 — Master Configuration
    # Windows Server 2025 / AWS Managed Microsoft AD
    # ─────────────────────────────────────────────────────────────────────────────

    # Benchmark metadata
    BenchmarkVersion = 'CIS Microsoft Windows Server 2025 Benchmark v1.0.0'
    Profile          = 'L1 - Member Server'

    # ─────── Targeting ────────
    # Delegated OU where GPOs will be linked (DN path)
    TargetOU = 'OU=Servers,OU=MyOrg,DC=corp,DC=example,DC=com'

    # Prefix for all GPOs created by this tool
    GpoPrefix = 'CIS-L1'

    # ─────── Safety ────────
    # DryRun = $true  → audit only, no changes (DEFAULT — safe)
    # DryRun = $false → create GPOs and apply settings
    DryRun = $true

    # Halt immediately if pre-flight connectivity check fails
    HaltOnConnectivityFailure = $true

    # Run post-flight connectivity check after applying changes
    PostFlightCheck = $true

    # ─────── Module Toggles ────────
    # Enable/disable each CIS section independently.
    # Disabled modules are skipped during both audit and apply.
    Modules = @{
        AccountPolicies      = $false   # Section 1 — disabled: AWS Managed AD owns domain pw policy
        UserRightsAssignment  = $true    # Section 2.2
        SecurityOptions       = $true    # Section 2.3
        AuditPolicy           = $true    # Section 17
        Services              = $true    # Section 5
        Firewall              = $true    # Section 9
        AdminTemplates        = $true    # Section 18
        AdminTemplatesUser    = $true    # Section 19
    }

    # ─────── Logging ────────
    LogLevel  = 'Info'          # Debug, Info, Warning, Error
    LogPath   = 'reports'       # Relative to project root; logs go here alongside reports

    # ─────── Report ────────
    ReportFormats = @('HTML', 'JSON')   # Which output formats to generate
}
