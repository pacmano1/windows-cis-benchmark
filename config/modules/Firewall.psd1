@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Section 9 — Windows Defender Firewall with Advanced Security
    # Mechanism: Registry-based
    # ─────────────────────────────────────────────────────────────────────────────

    ModuleName  = 'Firewall'
    CISSection  = '9'
    Mechanism   = 'Registry'

    Controls = @(
        # ── 9.1 Domain Profile ──
        @{
            Id       = '9.1.1'
            Title    = 'Windows Firewall: Domain: Firewall state'
            Description = 'On (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile'
                Name  = 'EnableFirewall'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.1.2'
            Title    = 'Windows Firewall: Domain: Inbound connections'
            Description = 'Block (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile'
                Name  = 'DefaultInboundAction'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.1.3'
            Title    = 'Windows Firewall: Domain: Outbound connections'
            Description = 'Allow (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile'
                Name  = 'DefaultOutboundAction'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '9.1.4'
            Title    = 'Windows Firewall: Domain: Settings: Display a notification'
            Description = 'Yes (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile'
                Name  = 'DisableNotifications'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.1.5'
            Title    = 'Windows Firewall: Domain: Logging: Name'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging'
                Name  = 'LogFilePath'
                Type  = 'String'
                Value = '%SystemRoot%\System32\logfiles\firewall\domainfw.log'
            }
        }
        @{
            Id       = '9.1.6'
            Title    = 'Windows Firewall: Domain: Logging: Size limit (KB)'
            Description = '16384 or greater'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging'
                Name     = 'LogFileSize'
                Type     = 'DWord'
                Value    = 16384
                Operator = 'GreaterOrEqual'
            }
        }
        @{
            Id       = '9.1.7'
            Title    = 'Windows Firewall: Domain: Logging: Log dropped packets'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging'
                Name  = 'LogDroppedPackets'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.1.8'
            Title    = 'Windows Firewall: Domain: Logging: Log successful connections'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging'
                Name  = 'LogSuccessfulConnections'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 9.2 Private Profile ──
        @{
            Id       = '9.2.1'
            Title    = 'Windows Firewall: Private: Firewall state'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile'
                Name  = 'EnableFirewall'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.2.2'
            Title    = 'Windows Firewall: Private: Inbound connections'
            Description = 'Block (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile'
                Name  = 'DefaultInboundAction'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.2.3'
            Title    = 'Windows Firewall: Private: Outbound connections'
            Description = 'Allow (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile'
                Name  = 'DefaultOutboundAction'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '9.2.4'
            Title    = 'Windows Firewall: Private: Settings: Display a notification'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile'
                Name  = 'DisableNotifications'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.2.5'
            Title    = 'Windows Firewall: Private: Logging: Name'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging'
                Name  = 'LogFilePath'
                Type  = 'String'
                Value = '%SystemRoot%\System32\logfiles\firewall\privatefw.log'
            }
        }
        @{
            Id       = '9.2.6'
            Title    = 'Windows Firewall: Private: Logging: Size limit (KB)'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging'
                Name     = 'LogFileSize'
                Type     = 'DWord'
                Value    = 16384
                Operator = 'GreaterOrEqual'
            }
        }
        @{
            Id       = '9.2.7'
            Title    = 'Windows Firewall: Private: Logging: Log dropped packets'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging'
                Name  = 'LogDroppedPackets'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.2.8'
            Title    = 'Windows Firewall: Private: Logging: Log successful connections'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging'
                Name  = 'LogSuccessfulConnections'
                Type  = 'DWord'
                Value = 1
            }
        }

        # ── 9.3 Public Profile ──
        @{
            Id       = '9.3.1'
            Title    = 'Windows Firewall: Public: Firewall state'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile'
                Name  = 'EnableFirewall'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.3.2'
            Title    = 'Windows Firewall: Public: Inbound connections'
            Description = 'Block (1)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile'
                Name  = 'DefaultInboundAction'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.3.3'
            Title    = 'Windows Firewall: Public: Outbound connections'
            Description = 'Allow (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile'
                Name  = 'DefaultOutboundAction'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '9.3.4'
            Title    = 'Windows Firewall: Public: Settings: Display a notification'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile'
                Name  = 'DisableNotifications'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.3.5'
            Title    = 'Windows Firewall: Public: Settings: Apply local firewall rules'
            Description = 'No (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile'
                Name  = 'AllowLocalPolicyMerge'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '9.3.6'
            Title    = 'Windows Firewall: Public: Settings: Apply local connection security rules'
            Description = 'No (0)'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile'
                Name  = 'AllowLocalIPsecPolicyMerge'
                Type  = 'DWord'
                Value = 0
            }
        }
        @{
            Id       = '9.3.7'
            Title    = 'Windows Firewall: Public: Logging: Name'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging'
                Name  = 'LogFilePath'
                Type  = 'String'
                Value = '%SystemRoot%\System32\logfiles\firewall\publicfw.log'
            }
        }
        @{
            Id       = '9.3.8'
            Title    = 'Windows Firewall: Public: Logging: Size limit (KB)'
            Registry = @{
                Path     = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging'
                Name     = 'LogFileSize'
                Type     = 'DWord'
                Value    = 16384
                Operator = 'GreaterOrEqual'
            }
        }
        @{
            Id       = '9.3.9'
            Title    = 'Windows Firewall: Public: Logging: Log dropped packets'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging'
                Name  = 'LogDroppedPackets'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '9.3.10'
            Title    = 'Windows Firewall: Public: Logging: Log successful connections'
            Registry = @{
                Path  = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging'
                Name  = 'LogSuccessfulConnections'
                Type  = 'DWord'
                Value = 1
            }
        }
    )
}
