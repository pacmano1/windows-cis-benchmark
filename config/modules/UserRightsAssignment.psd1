@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Section 2.2 — User Rights Assignment
    # Mechanism: secedit /export (audit) / GptTmpl.inf (apply)
    # ─────────────────────────────────────────────────────────────────────────────

    ModuleName  = 'UserRightsAssignment'
    CISSection  = '2.2'
    Mechanism   = 'Secedit'

    Controls = @(
        @{
            Id            = '2.2.1'
            Title         = 'Access Credential Manager as a trusted caller'
            SeceditKey    = 'SeTrustedCredManAccessPrivilege'
            ExpectedValue = ''
            Description   = 'No One'
        }
        @{
            Id            = '2.2.2'
            Title         = 'Access this computer from the network'
            SeceditKey    = 'SeNetworkLogonRight'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-11'
            Description   = 'Administrators, Authenticated Users'
        }
        @{
            Id            = '2.2.3'
            Title         = 'Act as part of the operating system'
            SeceditKey    = 'SeTcbPrivilege'
            ExpectedValue = ''
            Description   = 'No One'
        }
        @{
            Id            = '2.2.5'
            Title         = 'Adjust memory quotas for a process'
            SeceditKey    = 'SeIncreaseQuotaPrivilege'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-19,*S-1-5-20'
            Description   = 'Administrators, LOCAL SERVICE, NETWORK SERVICE'
        }
        @{
            Id            = '2.2.6'
            Title         = 'Allow log on locally'
            SeceditKey    = 'SeInteractiveLogonRight'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.7'
            Title         = 'Allow log on through Remote Desktop Services'
            SeceditKey    = 'SeRemoteInteractiveLogonRight'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.8'
            Title         = 'Back up files and directories'
            SeceditKey    = 'SeBackupPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.9'
            Title         = 'Change the system time'
            SeceditKey    = 'SeSystemtimePrivilege'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-19'
            Description   = 'Administrators, LOCAL SERVICE'
        }
        @{
            Id            = '2.2.10'
            Title         = 'Change the time zone'
            SeceditKey    = 'SeTimeZonePrivilege'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-19'
            Description   = 'Administrators, LOCAL SERVICE'
        }
        @{
            Id            = '2.2.11'
            Title         = 'Create a pagefile'
            SeceditKey    = 'SeCreatePagefilePrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.12'
            Title         = 'Create a token object'
            SeceditKey    = 'SeCreateTokenPrivilege'
            ExpectedValue = ''
            Description   = 'No One'
        }
        @{
            Id            = '2.2.13'
            Title         = 'Create global objects'
            SeceditKey    = 'SeCreateGlobalPrivilege'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-19,*S-1-5-20,*S-1-5-6'
            Description   = 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'
        }
        @{
            Id            = '2.2.14'
            Title         = 'Create permanent shared objects'
            SeceditKey    = 'SeCreatePermanentPrivilege'
            ExpectedValue = ''
            Description   = 'No One'
        }
        @{
            Id            = '2.2.15'
            Title         = 'Create symbolic links'
            SeceditKey    = 'SeCreateSymbolicLinkPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.16'
            Title         = 'Debug programs'
            SeceditKey    = 'SeDebugPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.17'
            Title         = 'Deny access to this computer from the network'
            SeceditKey    = 'SeDenyNetworkLogonRight'
            ExpectedValue = '*S-1-5-32-546'
            Description   = 'Guests'
        }
        @{
            Id            = '2.2.18'
            Title         = 'Deny log on as a batch job'
            SeceditKey    = 'SeDenyBatchLogonRight'
            ExpectedValue = '*S-1-5-32-546'
            Description   = 'Guests'
        }
        @{
            Id            = '2.2.19'
            Title         = 'Deny log on as a service'
            SeceditKey    = 'SeDenyServiceLogonRight'
            ExpectedValue = '*S-1-5-32-546'
            Description   = 'Guests'
        }
        @{
            Id            = '2.2.20'
            Title         = 'Deny log on locally'
            SeceditKey    = 'SeDenyInteractiveLogonRight'
            ExpectedValue = '*S-1-5-32-546'
            Description   = 'Guests'
        }
        @{
            Id            = '2.2.21'
            Title         = 'Deny log on through Remote Desktop Services'
            SeceditKey    = 'SeDenyRemoteInteractiveLogonRight'
            ExpectedValue = '*S-1-5-32-546'
            Description   = 'Guests'
        }
        @{
            Id            = '2.2.23'
            Title         = 'Force shutdown from a remote system'
            SeceditKey    = 'SeRemoteShutdownPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.24'
            Title         = 'Generate security audits'
            SeceditKey    = 'SeAuditPrivilege'
            ExpectedValue = '*S-1-5-19,*S-1-5-20'
            Description   = 'LOCAL SERVICE, NETWORK SERVICE'
        }
        @{
            Id            = '2.2.25'
            Title         = 'Impersonate a client after authentication'
            SeceditKey    = 'SeImpersonatePrivilege'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-19,*S-1-5-20,*S-1-5-6'
            Description   = 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'
        }
        @{
            Id            = '2.2.26'
            Title         = 'Increase scheduling priority'
            SeceditKey    = 'SeIncreaseBasePriorityPrivilege'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-90-0'
            Description   = 'Administrators, Window Manager\Window Manager Group'
        }
        @{
            Id            = '2.2.27'
            Title         = 'Load and unload device drivers'
            SeceditKey    = 'SeLoadDriverPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.28'
            Title         = 'Lock pages in memory'
            SeceditKey    = 'SeLockMemoryPrivilege'
            ExpectedValue = ''
            Description   = 'No One'
        }
        @{
            Id            = '2.2.30'
            Title         = 'Log on as a batch job'
            SeceditKey    = 'SeBatchLogonRight'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.32'
            Title         = 'Manage auditing and security log'
            SeceditKey    = 'SeSecurityPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.33'
            Title         = 'Modify an object label'
            SeceditKey    = 'SeRelabelPrivilege'
            ExpectedValue = ''
            Description   = 'No One'
        }
        @{
            Id            = '2.2.34'
            Title         = 'Modify firmware environment values'
            SeceditKey    = 'SeSystemEnvironmentPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.35'
            Title         = 'Perform volume maintenance tasks'
            SeceditKey    = 'SeManageVolumePrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.36'
            Title         = 'Profile single process'
            SeceditKey    = 'SeProfileSingleProcessPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.37'
            Title         = 'Profile system performance'
            SeceditKey    = 'SeSystemProfilePrivilege'
            ExpectedValue = '*S-1-5-32-544,*S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420'
            Description   = 'Administrators, NT SERVICE\WdiServiceHost'
        }
        @{
            Id            = '2.2.38'
            Title         = 'Replace a process level token'
            SeceditKey    = 'SeAssignPrimaryTokenPrivilege'
            ExpectedValue = '*S-1-5-19,*S-1-5-20'
            Description   = 'LOCAL SERVICE, NETWORK SERVICE'
        }
        @{
            Id            = '2.2.39'
            Title         = 'Restore files and directories'
            SeceditKey    = 'SeRestorePrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.40'
            Title         = 'Shut down the system'
            SeceditKey    = 'SeShutdownPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
        @{
            Id            = '2.2.42'
            Title         = 'Take ownership of files or other objects'
            SeceditKey    = 'SeTakeOwnershipPrivilege'
            ExpectedValue = '*S-1-5-32-544'
            Description   = 'Administrators'
        }
    )
}
