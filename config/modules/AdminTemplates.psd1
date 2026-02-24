@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Section 18 — Administrative Templates (Computer)
    # Mechanism: Registry-based (Set-GPRegistryValue)
    # This is the largest module. Controls are organized by subsection.
    # ─────────────────────────────────────────────────────────────────────────────

    ModuleName  = 'AdminTemplates'
    CISSection  = '18'
    Mechanism   = 'Registry'

    Controls = @(
        # ══════════════════════════════════════════════════════════════════════════
        # 18.1 Control Panel
        # ══════════════════════════════════════════════════════════════════════════
        @{
            Id       = '18.1.1.1'
            Title    = 'Personalization: Prevent enabling lock screen camera'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
                Name  = 'NoLockScreenCamera'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.1.1.2'
            Title    = 'Personalization: Prevent enabling lock screen slide show'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
                Name  = 'NoLockScreenSlideshow'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.1.2.2'
            Title    = 'Regional and Language Options: Allow users to enable online speech recognition services'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization'
                Name  = 'AllowInputPersonalization'
                Type  = 'DWord'
                Value = 0
            }
        }

        # ══════════════════════════════════════════════════════════════════════════
        # 18.3 MS Security Guide
        # ══════════════════════════════════════════════════════════════════════════
        @{
            Id       = '18.3.1'
            Title    = 'MS Security Guide: Apply UAC restrictions to local accounts on network logons'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
                Name  = 'LocalAccountTokenFilterPolicy'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.3.2'
            Title    = 'MS Security Guide: Configure SMB v1 client driver'
            Description = 'Disable driver (4)'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10'
                Name  = 'Start'
                Type  = 'DWord'
                Value = 4
            }
        }
        @{
            Id       = '18.3.3'
            Title    = 'MS Security Guide: Configure SMB v1 server'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
                Name  = 'SMB1'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.3.4'
            Title    = 'MS Security Guide: Enable Structured Exception Handling Overwrite Protection (SEHOP)'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel'
                Name  = 'DisableExceptionChainValidation'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.3.6'
            Title    = 'MS Security Guide: WDigest Authentication'
            Description = 'Disabled'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest'
                Name  = 'UseLogonCredential'
                Type  = 'DWord'
                Value = 0
            }
        }

        # ══════════════════════════════════════════════════════════════════════════
        # 18.4 MSS (Legacy)
        # ══════════════════════════════════════════════════════════════════════════
        @{
            Id       = '18.4.1'
            Title    = 'MSS: (AutoAdminLogon) Enable Automatic Logon'
            Description = 'Disabled'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
                Name  = 'AutoAdminLogon'
                Type  = 'String'
                Value = '0'
            }
        }
        @{
            Id       = '18.4.2'
            Title    = 'MSS: (DisableIPSourceRouting IPv6) IP source routing protection level'
            Description = 'Highest protection (2)'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters'
                Name  = 'DisableIPSourceRouting'
                Type  = 'DWord'
                Value = 2
            }
        }
        @{
            Id       = '18.4.3'
            Title    = 'MSS: (DisableIPSourceRouting) IP source routing protection level'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters'
                Name  = 'DisableIPSourceRouting'
                Type  = 'DWord'
                Value = 2
            }
        }
        @{
            Id       = '18.4.5'
            Title    = 'MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters'
                Name  = 'EnableICMPRedirect'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.4.7'
            Title    = 'MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters'
                Name  = 'NoNameReleaseOnDemand'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.4.9'
            Title    = 'MSS: (SafeDllSearchMode) Enable Safe DLL search mode'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'
                Name  = 'SafeDllSearchMode'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.4.10'
            Title    = 'MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
                Name  = 'ScreenSaverGracePeriod'
                Type  = 'String'
                Value = '5'
            }
        }
        @{
            Id       = '18.4.12'
            Title    = 'MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\Security'
                Name  = 'WarningLevel'
                Type  = 'DWord'
                Value = 90
            }
        }

        # ══════════════════════════════════════════════════════════════════════════
        # 18.5 Network
        # ══════════════════════════════════════════════════════════════════════════
        @{
            Id       = '18.5.4.1'
            Title    = 'DNS Client: Configure DNS over HTTPS (DoH) name resolution'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient'
                Name  = 'DoHPolicy'
                Type  = 'DWord'
                Value = 2
            }
        }
        @{
            Id       = '18.5.4.2'
            Title    = 'DNS Client: Turn off multicast name resolution (LLMNR)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient'
                Name  = 'EnableMulticast'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.5.8.1'
            Title    = 'Lanman Workstation: Enable insecure guest logons'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation'
                Name  = 'AllowInsecureGuestAuth'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.5.11.2'
            Title    = 'Network Connections: Prohibit installation and configuration of Network Bridge on your DNS domain network'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'
                Name  = 'NC_AllowNetBridge_NLA'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.5.11.3'
            Title    = 'Network Connections: Prohibit use of Internet Connection Sharing on your DNS domain network'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'
                Name  = 'NC_ShowSharedAccessUI'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.5.11.4'
            Title    = 'Network Connections: Require domain users to elevate when setting a networks location'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'
                Name  = 'NC_StdDomainUserSetLocation'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.5.14.1'
            Title    = 'Network Provider: Hardened UNC Paths'
            Description = 'Require Mutual Authentication and Integrity for \\*\SYSVOL and \\*\NETLOGON'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths'
                Name  = '\\*\NETLOGON'
                Type  = 'String'
                Value = 'RequireMutualAuthentication=1, RequireIntegrity=1'
            }
        }
        @{
            Id       = '18.5.14.1b'
            Title    = 'Network Provider: Hardened UNC Paths (SYSVOL)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths'
                Name  = '\\*\SYSVOL'
                Type  = 'String'
                Value = 'RequireMutualAuthentication=1, RequireIntegrity=1'
            }
        }
        @{
            Id       = '18.5.21.1'
            Title    = 'Windows Connect Now: Configuration of wireless settings using Windows Connect Now'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars'
                Name  = 'EnableRegistrars'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.5.21.2'
            Title    = 'Windows Connect Now: Prohibit access of the Windows Connect Now wizards'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WCN\UI'
                Name  = 'DisableWPDUI'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.5.23.2.1'
            Title    = 'WLAN: Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config'
                Name  = 'AutoConnectAllowedOEM'
                Type  = 'DWord'
                Value = 0
            }
        }

        # ══════════════════════════════════════════════════════════════════════════
        # 18.6 Printers (skip for servers typically)
        # ══════════════════════════════════════════════════════════════════════════
        @{
            Id       = '18.6.1'
            Title    = 'Printers: Configure Redirection Guard'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers'
                Name  = 'RedirectionguardPolicy'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.6.2'
            Title    = 'Printers: Configure RPC connection settings — RPC connection protocol to use for outgoing RPC connections'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC'
                Name  = 'RpcUseNamedPipeProtocol'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.6.3'
            Title    = 'Printers: Configure RPC connection settings — Use authentication for outgoing RPC connections'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC'
                Name  = 'RpcAuthentication'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.6.4'
            Title    = 'Printers: Configure RPC listener settings — Protocols to allow for incoming RPC connections'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC'
                Name  = 'RpcProtocols'
                Type  = 'DWord'
                Value = 5
            }
        }
        @{
            Id       = '18.6.5'
            Title    = 'Printers: Configure RPC listener settings — Authentication protocol to use for incoming RPC connections'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC'
                Name  = 'ForceKerberosForRpc'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.6.6'
            Title    = 'Printers: Configure RPC over TCP port'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC'
                Name  = 'RpcTcpPort'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.6.7'
            Title    = 'Printers: Limits print driver installation to Administrators'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint'
                Name  = 'RestrictDriverInstallationToAdministrators'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.6.8'
            Title    = 'Printers: Manage processing of Queue-specific files'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers'
                Name  = 'CopyFilesPolicy'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ══════════════════════════════════════════════════════════════════════════
        # 18.8 System
        # ══════════════════════════════════════════════════════════════════════════
        @{
            Id       = '18.8.3.1'
            Title    = 'Audit Process Creation: Include command line in process creation events'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit'
                Name  = 'ProcessCreationIncludeCmdLine_Enabled'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.4.1'
            Title    = 'Credentials Delegation: Encryption Oracle Remediation'
            Description = 'Force Updated Clients (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters'
                Name  = 'AllowEncryptionOracle'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.8.4.2'
            Title    = 'Credentials Delegation: Remote host allows delegation of non-exportable credentials'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation'
                Name  = 'AllowProtectedCreds'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.5.1'
            Title    = 'Device Guard: Turn On Virtualization Based Security'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard'
                Name  = 'EnableVirtualizationBasedSecurity'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.5.2'
            Title    = 'Device Guard: Turn On Virtualization Based Security — Select Platform Security Level'
            Description = 'Secure Boot and DMA Protection (3)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard'
                Name  = 'RequirePlatformSecurityFeatures'
                Type  = 'DWord'
                Value = 3
            }
        }
        @{
            Id       = '18.8.5.3'
            Title    = 'Device Guard: Turn On Virtualization Based Security — Virtualization Based Protection of Code Integrity'
            Description = 'Enabled with UEFI lock (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard'
                Name  = 'HypervisorEnforcedCodeIntegrity'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.5.4'
            Title    = 'Device Guard: Turn On Virtualization Based Security — Require UEFI Memory Attributes Table'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard'
                Name  = 'HVCIMATRequired'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.5.7'
            Title    = 'Device Guard: Turn On Virtualization Based Security — Secure Launch Configuration'
            Description = 'Enabled (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard'
                Name  = 'ConfigureSystemGuardLaunch'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.7.1.1'
            Title    = 'Device Installation: Prevent installation of devices that match any of these device IDs'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions'
                Name  = 'DenyDeviceIDs'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.14.1'
            Title    = 'Early Launch Antimalware: Boot-Start Driver Initialization Policy'
            Description = 'Good, unknown and bad but critical (3)'
            Registry = @{
                Path  = 'HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch'
                Name  = 'DriverLoadPolicy'
                Type  = 'DWord'
                Value = 3
            }
        }
        @{
            Id       = '18.8.22.1.1'
            Title    = 'Group Policy: Configure registry policy processing — Do not apply during periodic background processing'
            Description = 'Enabled: FALSE (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'
                Name  = 'NoBackgroundPolicy'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.8.22.1.2'
            Title    = 'Group Policy: Configure registry policy processing — Process even if the GPOs have not changed'
            Description = 'Enabled: TRUE (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'
                Name  = 'NoGPOListChanges'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.8.22.1.3'
            Title    = 'Group Policy: Continue experiences on this device'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'EnableCdp'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.8.22.1.4'
            Title    = 'Group Policy: Turn off background refresh of Group Policy'
            Description = 'Disabled (not set or 0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
                Name  = 'DisableBkGndGroupPolicy'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.8.28.1'
            Title    = 'Logon: Block user from showing account details on sign-in'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'BlockUserFromShowingAccountDetailsOnSignin'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.28.2'
            Title    = 'Logon: Do not display network selection UI'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'DontDisplayNetworkSelectionUI'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.28.3'
            Title    = 'Logon: Do not enumerate connected users on domain-joined computers'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'DontEnumerateConnectedUsers'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.28.4'
            Title    = 'Logon: Enumerate local users on domain-joined computers'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'EnumerateLocalUsers'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.8.28.5'
            Title    = 'Logon: Turn off app notifications on the lock screen'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'DisableLockScreenAppNotifications'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.28.6'
            Title    = 'Logon: Turn off picture password sign-in'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'BlockDomainPicturePassword'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.28.7'
            Title    = 'Logon: Turn on convenience PIN sign-in'
            Description = 'Disabled (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'AllowDomainPINLogon'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.8.36.1'
            Title    = 'Remote Procedure Call: Enable RPC Endpoint Mapper Client Authentication'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc'
                Name  = 'EnableAuthEpResolution'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.8.36.2'
            Title    = 'Remote Procedure Call: Restrict Unauthenticated RPC clients'
            Description = 'Authenticated (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc'
                Name  = 'RestrictRemoteClients'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ══════════════════════════════════════════════════════════════════════════
        # 18.9 Windows Components
        # ══════════════════════════════════════════════════════════════════════════

        # ── 18.9.4 App runtime ──
        @{
            Id       = '18.9.4.1'
            Title    = 'App runtime: Allow Microsoft accounts to be optional'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
                Name  = 'MSAOptional'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.5 App Package Deployment ──
        @{
            Id       = '18.9.5.1'
            Title    = 'App Package Deployment: Allow a Windows app to share application data between users'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppModel\StateManager'
                Name  = 'AllowSharedLocalAppData'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.5.2'
            Title    = 'App Package Deployment: Prevent non-admin users from installing packaged Windows apps'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Appx'
                Name  = 'BlockNonAdminUserInstall'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.6 AutoPlay ──
        @{
            Id       = '18.9.6.1'
            Title    = 'AutoPlay: Disallow Autoplay for non-volume devices'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
                Name  = 'NoAutoplayfornonVolume'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.6.2'
            Title    = 'AutoPlay: Set the default behavior for AutoRun'
            Description = 'Do not execute any autorun commands (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
                Name  = 'NoAutorun'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.6.3'
            Title    = 'AutoPlay: Turn off Autoplay'
            Description = 'All drives (255)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
                Name  = 'NoDriveTypeAutoRun'
                Type  = 'DWord'
                Value = 255
            }
        }

        # ── 18.9.7 BitLocker Drive Encryption ──
        @{
            Id       = '18.9.7.1.1'
            Title    = 'BitLocker: Fixed Data Drives — Allow access to BitLocker-protected fixed data drives from earlier versions of Windows'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\FVE'
                Name  = 'FDVDiscoveryVolumeType'
                Type  = 'String'
                Value = ''
            }
        }

        # ── 18.9.13 Cloud Content ──
        @{
            Id       = '18.9.13.1'
            Title    = 'Cloud Content: Turn off cloud consumer account state content'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
                Name  = 'DisableConsumerAccountStateContent'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.13.2'
            Title    = 'Cloud Content: Turn off cloud optimized content'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
                Name  = 'DisableCloudOptimizedContent'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.13.3'
            Title    = 'Cloud Content: Turn off Microsoft consumer experiences'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
                Name  = 'DisableWindowsConsumerFeatures'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.14 Connect ──
        @{
            Id       = '18.9.14.1'
            Title    = 'Connect: Require pin for pairing'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Connect'
                Name  = 'RequirePinForPairing'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.15 Credential User Interface ──
        @{
            Id       = '18.9.15.1'
            Title    = 'Credential UI: Do not display the password reveal button'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredUI'
                Name  = 'DisablePasswordReveal'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.15.2'
            Title    = 'Credential UI: Enumerate administrator accounts on elevation'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
                Name  = 'EnumerateAdministrators'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.15.3'
            Title    = 'Credential UI: Prevent the use of security questions for local accounts'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
                Name  = 'NoLocalPasswordResetQuestions'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.17 Data Collection and Preview Builds ──
        @{
            Id       = '18.9.17.1'
            Title    = 'Data Collection: Allow Diagnostic Data'
            Description = 'Send required diagnostic data (1) or off (0)'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
                Name     = 'AllowTelemetry'
                Type     = 'DWord'
                Value    = 1
                Operator = 'LessOrEqual'
            }
        }
        @{
            Id       = '18.9.17.2'
            Title    = 'Data Collection: Configure authenticated proxy usage for the Connected User Experience and Telemetry service'
            Description = 'Disable Authenticated Proxy usage (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
                Name  = 'DisableEnterpriseAuthProxy'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.17.3'
            Title    = 'Data Collection: Disable OneSettings Downloads'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
                Name  = 'DisableOneSettingsDownloads'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.17.4'
            Title    = 'Data Collection: Do not show feedback notifications'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
                Name  = 'DoNotShowFeedbackNotifications'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.17.5'
            Title    = 'Data Collection: Enable OneSettings Auditing'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
                Name  = 'EnableOneSettingsAuditing'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.17.6'
            Title    = 'Data Collection: Limit Diagnostic Log Collection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
                Name  = 'LimitDiagnosticLogCollection'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.17.7'
            Title    = 'Data Collection: Limit Dump Collection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
                Name  = 'LimitDumpCollection'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.17.8'
            Title    = 'Data Collection: Toggle user control over Insider builds'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds'
                Name  = 'AllowBuildPreview'
                Type  = 'DWord'
                Value = 0
            }
        }

        # ── 18.9.26 Event Log Service ──
        @{
            Id       = '18.9.26.1.1'
            Title    = 'Event Log Service: Application — Control Event Log behavior when the log file reaches its maximum size'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
                Name  = 'Retention'
                Type  = 'String'
                Value = '0'
            }
        }
        @{
            Id       = '18.9.26.1.2'
            Title    = 'Event Log Service: Application — Specify the maximum log file size (KB)'
            Description = '32768 or greater'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
                Name     = 'MaxSize'
                Type     = 'DWord'
                Value    = 32768
                Operator = 'GreaterOrEqual'
            }
        }
        @{
            Id       = '18.9.26.2.1'
            Title    = 'Event Log Service: Security — Control Event Log behavior when the log file reaches its maximum size'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security'
                Name  = 'Retention'
                Type  = 'String'
                Value = '0'
            }
        }
        @{
            Id       = '18.9.26.2.2'
            Title    = 'Event Log Service: Security — Specify the maximum log file size (KB)'
            Description = '196608 or greater'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security'
                Name     = 'MaxSize'
                Type     = 'DWord'
                Value    = 196608
                Operator = 'GreaterOrEqual'
            }
        }
        @{
            Id       = '18.9.26.3.1'
            Title    = 'Event Log Service: Setup — Control Event Log behavior when the log file reaches its maximum size'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup'
                Name  = 'Retention'
                Type  = 'String'
                Value = '0'
            }
        }
        @{
            Id       = '18.9.26.3.2'
            Title    = 'Event Log Service: Setup — Specify the maximum log file size (KB)'
            Description = '32768 or greater'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup'
                Name     = 'MaxSize'
                Type     = 'DWord'
                Value    = 32768
                Operator = 'GreaterOrEqual'
            }
        }
        @{
            Id       = '18.9.26.4.1'
            Title    = 'Event Log Service: System — Control Event Log behavior when the log file reaches its maximum size'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System'
                Name  = 'Retention'
                Type  = 'String'
                Value = '0'
            }
        }
        @{
            Id       = '18.9.26.4.2'
            Title    = 'Event Log Service: System — Specify the maximum log file size (KB)'
            Description = '32768 or greater'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System'
                Name     = 'MaxSize'
                Type     = 'DWord'
                Value    = 32768
                Operator = 'GreaterOrEqual'
            }
        }

        # ── 18.9.31 File Explorer ──
        @{
            Id       = '18.9.31.2'
            Title    = 'File Explorer: Turn off Data Execution Prevention for Explorer'
            Description = 'Disabled (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
                Name  = 'NoDataExecutionPrevention'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.31.3'
            Title    = 'File Explorer: Turn off heap termination on corruption'
            Description = 'Disabled (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
                Name  = 'NoHeapTerminationOnCorruption'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.31.4'
            Title    = 'File Explorer: Turn off shell protocol protected mode'
            Description = 'Disabled (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
                Name  = 'PreXPSP2ShellProtocolBehavior'
                Type  = 'DWord'
                Value = 0
            }
        }

        # ── 18.9.35 Remote Desktop Services ──
        @{
            Id       = '18.9.35.3.3.1'
            Title    = 'RDS: Do not allow COM port redirection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'fDisableCcm'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.35.3.3.2'
            Title    = 'RDS: Do not allow drive redirection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'fDisableCdm'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.35.3.3.3'
            Title    = 'RDS: Do not allow LPT port redirection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'fDisableLPT'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.35.3.3.4'
            Title    = 'RDS: Do not allow supported Plug and Play device redirection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'fDisablePNPRedir'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.35.3.9.1'
            Title    = 'RDS: Always prompt for password upon connection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'fPromptForPassword'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.35.3.9.2'
            Title    = 'RDS: Require secure RPC communication'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'fEncryptRPCTraffic'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.35.3.9.3'
            Title    = 'RDS: Require use of specific security layer for remote (RDP) connections'
            Description = 'SSL (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'SecurityLayer'
                Type  = 'DWord'
                Value = 2
            }
        }
        @{
            Id       = '18.9.35.3.9.4'
            Title    = 'RDS: Require user authentication for remote connections by using NLA'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'UserAuthentication'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.35.3.9.5'
            Title    = 'RDS: Set client connection encryption level'
            Description = 'High Level (3)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'MinEncryptionLevel'
                Type  = 'DWord'
                Value = 3
            }
        }
        @{
            Id       = '18.9.35.3.10.1'
            Title    = 'RDS: Set time limit for active but idle Remote Desktop Services sessions'
            Description = '15 minutes (900000 ms) or less'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name     = 'MaxIdleTime'
                Type     = 'DWord'
                Value    = 900000
                Operator = 'LessOrEqual'
                MinValue = 60000
            }
        }
        @{
            Id       = '18.9.35.3.10.2'
            Title    = 'RDS: Set time limit for disconnected sessions'
            Description = '1 minute (60000 ms)'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name     = 'MaxDisconnectionTime'
                Type     = 'DWord'
                Value    = 60000
                Operator = 'LessOrEqual'
                MinValue = 60000
            }
        }
        @{
            Id       = '18.9.35.3.11.1'
            Title    = 'RDS: Do not delete temp folders upon exit'
            Description = 'Disabled (1 means do not delete; CIS wants this disabled = 1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                Name  = 'DeleteTempDirsOnExit'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.46 RSS Feeds ──
        @{
            Id       = '18.9.46.1'
            Title    = 'RSS Feeds: Prevent downloading of enclosures'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds'
                Name  = 'DisableEnclosureDownload'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.47 Search ──
        @{
            Id       = '18.9.47.1'
            Title    = 'Search: Allow Cloud Search'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
                Name  = 'AllowCloudSearch'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.47.2'
            Title    = 'Search: Allow Cortana'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
                Name  = 'AllowCortana'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.47.3'
            Title    = 'Search: Allow Cortana above lock screen'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
                Name  = 'AllowCortanaAboveLock'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.47.4'
            Title    = 'Search: Allow indexing of encrypted files'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
                Name  = 'AllowIndexingEncryptedStoresOrItems'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.47.5'
            Title    = 'Search: Allow search and Cortana to use location'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
                Name  = 'AllowSearchToUseLocation'
                Type  = 'DWord'
                Value = 0
            }
        }

        # ── 18.9.58 Windows Remote Management (WinRM) ──
        @{
            Id       = '18.9.58.1'
            Title    = 'WinRM Client: Allow Basic authentication'
            Description = 'Disabled'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client'
                Name  = 'AllowBasic'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.58.2'
            Title    = 'WinRM Client: Allow unencrypted traffic'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client'
                Name  = 'AllowUnencryptedTraffic'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.58.3'
            Title    = 'WinRM Client: Disallow Digest authentication'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client'
                Name  = 'AllowDigest'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.58.5'
            Title    = 'WinRM Service: Allow Basic authentication'
            Description = 'Disabled'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
                Name  = 'AllowBasic'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.58.6'
            Title    = 'WinRM Service: Allow remote server management through WinRM'
            Description = 'Enabled (must stay enabled for AWS management)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
                Name  = 'AllowAutoConfig'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.58.7'
            Title    = 'WinRM Service: Allow unencrypted traffic'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
                Name  = 'AllowUnencryptedTraffic'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.58.8'
            Title    = 'WinRM Service: Disallow WinRM from storing RunAs credentials'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
                Name  = 'DisableRunAs'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.59 Windows Remote Shell ──
        @{
            Id       = '18.9.59.1'
            Title    = 'WinRS: Allow Remote Shell Access'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
                Name  = 'AllowRemoteShellAccess'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.65 Windows Defender / Antivirus ──
        @{
            Id       = '18.9.65.3.1.1'
            Title    = 'Defender: Configure Attack Surface Reduction rules'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR'
                Name  = 'ExploitGuard_ASR_Rules'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.65.3.11.1'
            Title    = 'Defender: Scan all downloaded files and attachments'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection'
                Name  = 'DisableIOAVProtection'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.65.3.11.2'
            Title    = 'Defender: Turn on behavior monitoring'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection'
                Name  = 'DisableBehaviorMonitoring'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.65.3.11.3'
            Title    = 'Defender: Turn on real-time protection'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection'
                Name  = 'DisableRealtimeMonitoring'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.65.3.11.4'
            Title    = 'Defender: Turn on script scanning'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection'
                Name  = 'DisableScriptScanning'
                Type  = 'DWord'
                Value = 0
            }
        }

        # ── 18.9.72 Windows PowerShell ──
        @{
            Id       = '18.9.72.1'
            Title    = 'PowerShell: Turn on Module Logging'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
                Name  = 'EnableModuleLogging'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.72.2'
            Title    = 'PowerShell: Turn on PowerShell Script Block Logging'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
                Name  = 'EnableScriptBlockLogging'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '18.9.72.3'
            Title    = 'PowerShell: Turn on PowerShell Transcription'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'
                Name  = 'EnableTranscripting'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 18.9.85 Windows Update ──
        @{
            Id       = '18.9.85.1.1'
            Title    = 'Windows Update: Configure Automatic Updates'
            Description = 'Enabled: 4 — Auto download and schedule the install'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
                Name  = 'NoAutoUpdate'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.85.1.2'
            Title    = 'Windows Update: Configure Automatic Updates — Scheduled install day'
            Description = '0 = Every day'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
                Name  = 'ScheduledInstallDay'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '18.9.85.2'
            Title    = 'Windows Update: Manage preview builds'
            Description = 'Disable preview builds (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'
                Name  = 'ManagePreviewBuildsPolicyValue'
                Type  = 'DWord'
                Value = 1
            }
        }
    )
}
