# CIS Benchmark L1 Automation — Windows Server 2025

Automated audit, enforcement, and rollback of **CIS Microsoft Windows Server 2025 Benchmark v1.0.0** (Level 1, Member Server profile). Supports both **domain-joined** machines (AWS Managed Microsoft AD) and **standalone** machines (local policy mode).

## What This Does

| Capability | Description |
|---|---|
| **Audit** | Scans a Windows Server 2025 machine against 339 CIS L1 controls and generates HTML + JSON compliance reports |
| **Apply (Domain)** | Creates one Group Policy Object per CIS section, links them to your delegated OU, and populates settings |
| **Apply (Standalone)** | Writes settings directly to local registry, secedit, and auditpol — no AD required |
| **Rollback** | Restores to pre-apply state (GPO restore on domain, local baseline restore on standalone) |

## Key Safety Features

- **Interactive prompts** — scripts ask for options (mode, modules, IIS, firewall) instead of requiring CLI flags
- **DryRun by default** — nothing changes until you explicitly opt in
- **Auto-detects environment** — domain-joined vs standalone, server vs workstation
- **Pre/post-flight connectivity checks** — validates WinRM, SSM Agent, and RDP before and after changes
- **AWS exclusions** — never disables RDP, WinRM, or SSM; never touches domain password policy
- **IIS-aware** — prompts to skip IIS service controls on web servers (`-SkipIIS`)
- **One GPO per module** — unlink a single GPO to disable an entire CIS category instantly
- **Full state backup** before every apply operation

## Quick Start

### Domain-Joined (AWS Managed AD)

```powershell
# 1. Install prerequisites (run as Administrator)
.\scripts\Install-Prerequisites.ps1

# 2. Edit config to match your environment
notepad .\config\master-config.psd1    # Set TargetOU, GpoPrefix, enable/disable modules

# 3. Audit current compliance (safe — read-only)
.\scripts\Invoke-CISAudit.ps1

# 4. Review the HTML report in reports/

# 5. Apply settings (prompts for mode, modules, IIS, firewall hardening)
.\scripts\Invoke-CISApply.ps1

# 6. If something goes wrong
.\scripts\Invoke-CISRollback.ps1
```

### Standalone (No Domain / Golden AMI)

```powershell
# 1. Install prerequisites
.\scripts\Install-Prerequisites.ps1

# 2. Audit current compliance
.\scripts\Invoke-CISAudit.ps1 -SkipPrereqCheck

# 3. Apply CIS hardening directly to local policy
.\scripts\Invoke-CISApply.ps1 -DryRun $false -SkipPrereqCheck

# 4. Verify compliance
.\scripts\Invoke-CISAudit.ps1 -SkipPrereqCheck
```

> **Tip:** All scripts accept `-Force` to skip interactive prompts and `-SkipIIS` to exclude IIS service controls on web servers.

## Control Coverage

| Module | CIS Section | Controls | Mechanism |
|---|---|---|---|
| AccountPolicies | 1 | 11 | secedit (audit-only) |
| UserRightsAssignment | 2.2 | 37 | secedit / GptTmpl.inf |
| SecurityOptions | 2.3 | 60 | Registry + secedit |
| Services | 5 | 38 | Service startup type |
| Firewall | 9 | 26 | Registry |
| AuditPolicy | 17 | 30 | auditpol / audit.csv |
| AdminTemplates | 18 | 128 | Registry |
| AdminTemplatesUser | 19 | 9 | Registry (HKCU) |
| **Total** | | **339** | |

## Requirements

### Domain Mode (GPO)
- Windows Server 2025 (EC2 instance)
- PowerShell 5.1+
- RSAT: Active Directory + Group Policy (installed via `Install-Prerequisites.ps1`)
- Domain-joined to AWS Managed Microsoft AD
- Delegated OU with GPO creation/link permissions

### Standalone / Local Policy Mode
- Windows Server 2025 (or Windows 10/11 workstation)
- PowerShell 5.1+
- Administrator privileges
- No AD or RSAT required

## Project Structure

```
security_benchmarks/
├── config/
│   ├── master-config.psd1          # Main settings (TargetOU, DryRun, modules)
│   ├── aws-exclusions.psd1         # Controls skipped/modified for AWS
│   └── modules/                    # Per-module control definitions (.psd1)
├── scripts/
│   ├── Install-Prerequisites.ps1   # RSAT and tool installer
│   ├── Invoke-CISAudit.ps1        # Audit entry point
│   ├── Invoke-CISApply.ps1        # Apply entry point
│   └── Invoke-CISRollback.ps1     # Rollback entry point
├── src/
│   ├── CISBenchmark.psm1          # Module manifest
│   ├── Core/                       # Shared functions (config, logging, backup)
│   └── Modules/                    # One folder per CIS module (Test-/Set- functions)
├── tests/                          # Pester tests
├── reports/                        # Generated audit reports (HTML, JSON)
└── backups/                        # State backups from apply runs
```

## Documentation

Full documentation is available in the [Wiki](../../wiki):

| Page | Description |
|---|---|
| [Architecture](../../wiki/Architecture) | Project structure, design decisions, data flow |
| [Configuration](../../wiki/Configuration) | Master config, module configs, AWS exclusions |
| [Modules](../../wiki/Modules) | Detailed breakdown of all 8 CIS modules and their controls |
| [Audit Guide](../../wiki/Usage-Audit) | Running audits, reading reports, scheduling |
| [Apply Guide](../../wiki/Usage-Apply) | Dry run, live apply, GPO management, Golden AMI workflow |
| [Rollback Guide](../../wiki/Usage-Rollback) | Restoring from backup, removing GPOs |
| [AWS Considerations](../../wiki/AWS-Considerations) | AWS Managed AD constraints, IIS exclusions, SSM safety |
| [Adding Controls](../../wiki/Adding-Controls) | How to add new CIS controls or create new modules |
| [Troubleshooting](../../wiki/Troubleshooting) | Common issues and solutions |
