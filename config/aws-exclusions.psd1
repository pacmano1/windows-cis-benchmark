@{
    # ─────────────────────────────────────────────────────────────────────────────
    # AWS-Specific Exclusions for CIS Benchmark
    # Controls listed here are either skipped or modified to maintain
    # compatibility with AWS Managed Microsoft AD and EC2 management.
    # ─────────────────────────────────────────────────────────────────────────────

    # ── Skip entirely ──
    # These controls cannot or should not be applied in AWS Managed AD environments.
    Skip = @(
        # Section 1 — Domain password/lockout policy (AWS Managed AD owns these)
        '1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5', '1.1.6', '1.1.7'
        '1.2.1', '1.2.2', '1.2.3', '1.2.4'

        # Section 5 — Services that must remain enabled
        '5.20'   # Remote Desktop Configuration (SessionEnv) — must stay for RDP
        '5.21'   # Remote Desktop Services (TermService) — must stay for RDP
        '5.22'   # Remote Desktop Services UserMode Port Redirector (UmRdpService) — must stay for RDP
        '5.39'   # Windows Remote Management (WinRM) — must stay for SSM/management

        # Section 9 — Firewall
        '9.3.5'           # Public: AllowLocalPolicyMerge — disabling this ignores local allow rules (including RDP) on the Public profile

        # Section 18 — RDS session limits
        '18.9.35.3.10.2'  # Disconnected session timeout (1 min) — kills user sessions; disconnect is fine, logoff is not
    )

    # ── Modified values ──
    # These controls are applied but with AWS-safe modifications.
    Modify = @{
        # 2.2.17: Deny access to this computer from the network
        # CIS says: Guests, Local account and member of Administrators group
        # AWS mod: Do NOT include SYSTEM or NETWORK SERVICE (breaks SSM Agent)
        '2.2.17' = '*S-1-5-32-546'

        # 2.2.38: Replace a process level token (Log on as a service implicit)
        # Ensure SYSTEM retains this right for SSM Agent
        '2.2.38' = '*S-1-5-19,*S-1-5-20'
    }

    # ── Notes (informational — not parsed by code) ──
    Notes = @{
        RDP = 'RDP hardening controls (18.9.35.x) are applied — NLA, encryption, session timeouts — but RDP itself is never disabled.'
        WinRM = 'WinRM hardening controls (18.9.58.x) disable Basic auth and unencrypted traffic, but WinRM service and remote management remain enabled.'
        SSMAgent = 'Amazon SSM Agent runs as SYSTEM. Controls that deny SYSTEM network access or service logon are modified to preserve SSM functionality.'
        DomainPolicy = 'Section 1 (Account Policies) is entirely skipped. Use the AWS Directory Service console to manage password/lockout policy.'
    }
}
