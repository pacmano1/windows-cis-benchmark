@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Section 1 — Account Policies
    # NOTE: Disabled by default — AWS Managed AD owns domain password/lockout policy.
    # Audit function can still report on current state for visibility.
    # Mechanism: secedit /export (audit only)
    # ─────────────────────────────────────────────────────────────────────────────

    ModuleName  = 'AccountPolicies'
    CISSection  = '1'
    Mechanism   = 'Secedit'

    Controls = @(
        # ── 1.1 Password Policy ──
        @{
            Id            = '1.1.1'
            Title         = 'Enforce password history'
            SeceditKey    = 'PasswordHistorySize'
            ExpectedValue = '24'
            Operator      = 'GreaterOrEqual'
            Description   = '24 or more passwords remembered'
        }
        @{
            Id            = '1.1.2'
            Title         = 'Maximum password age'
            SeceditKey    = 'MaximumPasswordAge'
            ExpectedValue = '365'
            Operator      = 'LessOrEqual'
            Description   = '365 or fewer days, but not 0'
        }
        @{
            Id            = '1.1.3'
            Title         = 'Minimum password age'
            SeceditKey    = 'MinimumPasswordAge'
            ExpectedValue = '1'
            Operator      = 'GreaterOrEqual'
            Description   = '1 or more days'
        }
        @{
            Id            = '1.1.4'
            Title         = 'Minimum password length'
            SeceditKey    = 'MinimumPasswordLength'
            ExpectedValue = '14'
            Operator      = 'GreaterOrEqual'
            Description   = '14 or more characters'
        }
        @{
            Id            = '1.1.5'
            Title         = 'Password must meet complexity requirements'
            SeceditKey    = 'PasswordComplexity'
            ExpectedValue = '1'
            Description   = 'Enabled'
        }
        @{
            Id            = '1.1.6'
            Title         = 'Relax minimum password length limits'
            SeceditKey    = 'RelaxMinimumPasswordLengthLimits'
            ExpectedValue = '1'
            Description   = 'Enabled'
        }
        @{
            Id            = '1.1.7'
            Title         = 'Store passwords using reversible encryption'
            SeceditKey    = 'ClearTextPassword'
            ExpectedValue = '0'
            Description   = 'Disabled'
        }

        # ── 1.2 Account Lockout Policy ──
        @{
            Id            = '1.2.1'
            Title         = 'Account lockout duration'
            SeceditKey    = 'LockoutDuration'
            ExpectedValue = '15'
            Operator      = 'GreaterOrEqual'
            Description   = '15 or more minutes'
        }
        @{
            Id            = '1.2.2'
            Title         = 'Account lockout threshold'
            SeceditKey    = 'LockoutBadCount'
            ExpectedValue = '5'
            Operator      = 'LessOrEqual'
            Description   = '5 or fewer invalid logon attempts, but not 0'
        }
        @{
            Id            = '1.2.3'
            Title         = 'Allow Administrator account lockout'
            SeceditKey    = 'AllowAdministratorLockout'
            ExpectedValue = '1'
            Description   = 'Enabled'
        }
        @{
            Id            = '1.2.4'
            Title         = 'Reset account lockout counter after'
            SeceditKey    = 'ResetLockoutCount'
            ExpectedValue = '15'
            Operator      = 'GreaterOrEqual'
            Description   = '15 or more minutes'
        }
    )
}
