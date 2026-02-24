@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Section 17 — Advanced Audit Policy Configuration
    # Mechanism: auditpol (audit) / audit.csv in GPO SYSVOL (apply)
    # ─────────────────────────────────────────────────────────────────────────────

    ModuleName  = 'AuditPolicy'
    CISSection  = '17'
    Mechanism   = 'AuditPol'

    Controls = @(
        # ── 17.1 Account Logon ──
        @{
            Id            = '17.1.1'
            Title         = 'Audit Credential Validation'
            Subcategory   = 'Credential Validation'
            CategoryGuid  = '{0CCE923F-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }

        # ── 17.2 Account Management ──
        @{
            Id            = '17.2.1'
            Title         = 'Audit Application Group Management'
            Subcategory   = 'Application Group Management'
            CategoryGuid  = '{0CCE9239-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.2.2'
            Title         = 'Audit Computer Account Management'
            Subcategory   = 'Computer Account Management'
            CategoryGuid  = '{0CCE9236-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.2.3'
            Title         = 'Audit Distribution Group Management'
            Subcategory   = 'Distribution Group Management'
            CategoryGuid  = '{0CCE9238-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.2.4'
            Title         = 'Audit Other Account Management Events'
            Subcategory   = 'Other Account Management Events'
            CategoryGuid  = '{0CCE923A-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.2.5'
            Title         = 'Audit Security Group Management'
            Subcategory   = 'Security Group Management'
            CategoryGuid  = '{0CCE9237-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.2.6'
            Title         = 'Audit User Account Management'
            Subcategory   = 'User Account Management'
            CategoryGuid  = '{0CCE9235-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }

        # ── 17.3 Detailed Tracking ──
        @{
            Id            = '17.3.1'
            Title         = 'Audit PNP Activity'
            Subcategory   = 'Plug and Play Events'
            CategoryGuid  = '{0CCE9248-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.3.2'
            Title         = 'Audit Process Creation'
            Subcategory   = 'Process Creation'
            CategoryGuid  = '{0CCE922B-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }

        # ── 17.5 Logon/Logoff ──
        @{
            Id            = '17.5.1'
            Title         = 'Audit Account Lockout'
            Subcategory   = 'Account Lockout'
            CategoryGuid  = '{0CCE9217-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Failure'
            InclusionSetting = 'Failure'
        }
        @{
            Id            = '17.5.2'
            Title         = 'Audit Group Membership'
            Subcategory   = 'Group Membership'
            CategoryGuid  = '{0CCE9249-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.5.3'
            Title         = 'Audit Logoff'
            Subcategory   = 'Logoff'
            CategoryGuid  = '{0CCE9216-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.5.4'
            Title         = 'Audit Logon'
            Subcategory   = 'Logon'
            CategoryGuid  = '{0CCE9215-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.5.5'
            Title         = 'Audit Other Logon/Logoff Events'
            Subcategory   = 'Other Logon/Logoff Events'
            CategoryGuid  = '{0CCE921C-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.5.6'
            Title         = 'Audit Special Logon'
            Subcategory   = 'Special Logon'
            CategoryGuid  = '{0CCE921B-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }

        # ── 17.6 Object Access ──
        @{
            Id            = '17.6.1'
            Title         = 'Audit Detailed File Share'
            Subcategory   = 'Detailed File Share'
            CategoryGuid  = '{0CCE9244-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Failure'
            InclusionSetting = 'Failure'
        }
        @{
            Id            = '17.6.2'
            Title         = 'Audit File Share'
            Subcategory   = 'File Share'
            CategoryGuid  = '{0CCE9224-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.6.3'
            Title         = 'Audit Other Object Access Events'
            Subcategory   = 'Other Object Access Events'
            CategoryGuid  = '{0CCE9227-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.6.4'
            Title         = 'Audit Removable Storage'
            Subcategory   = 'Removable Storage'
            CategoryGuid  = '{0CCE924B-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }

        # ── 17.7 Policy Change ──
        @{
            Id            = '17.7.1'
            Title         = 'Audit Audit Policy Change'
            Subcategory   = 'Audit Policy Change'
            CategoryGuid  = '{0CCE922F-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.7.2'
            Title         = 'Audit Authentication Policy Change'
            Subcategory   = 'Authentication Policy Change'
            CategoryGuid  = '{0CCE9230-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.7.3'
            Title         = 'Audit Authorization Policy Change'
            Subcategory   = 'Authorization Policy Change'
            CategoryGuid  = '{0CCE9231-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.7.4'
            Title         = 'Audit MPSSVC Rule-Level Policy Change'
            Subcategory   = 'MPSSVC Rule-Level Policy Change'
            CategoryGuid  = '{0CCE9232-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.7.5'
            Title         = 'Audit Other Policy Change Events'
            Subcategory   = 'Other Policy Change Events'
            CategoryGuid  = '{0CCE9234-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Failure'
            InclusionSetting = 'Failure'
        }

        # ── 17.8 Privilege Use ──
        @{
            Id            = '17.8.1'
            Title         = 'Audit Sensitive Privilege Use'
            Subcategory   = 'Sensitive Privilege Use'
            CategoryGuid  = '{0CCE9228-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }

        # ── 17.9 System ──
        @{
            Id            = '17.9.1'
            Title         = 'Audit IPsec Driver'
            Subcategory   = 'IPsec Driver'
            CategoryGuid  = '{0CCE9213-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.9.2'
            Title         = 'Audit Other System Events'
            Subcategory   = 'Other System Events'
            CategoryGuid  = '{0CCE9214-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
        @{
            Id            = '17.9.3'
            Title         = 'Audit Security State Change'
            Subcategory   = 'Security State Change'
            CategoryGuid  = '{0CCE9210-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.9.4'
            Title         = 'Audit Security System Extension'
            Subcategory   = 'Security System Extension'
            CategoryGuid  = '{0CCE9211-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Include Success'
            InclusionSetting = 'Success'
        }
        @{
            Id            = '17.9.5'
            Title         = 'Audit System Integrity'
            Subcategory   = 'System Integrity'
            CategoryGuid  = '{0CCE9212-69AE-11D9-BED3-505054503030}'
            ExpectedValue = 'Success and Failure'
            InclusionSetting = 'Success and Failure'
        }
    )
}
