@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Section 19 — Administrative Templates (User Configuration)
    # Mechanism: Registry-based (User policy hive, HKCU)
    # Note: Applied via GPO User Configuration, registry path uses HKCU but
    #       Set-GPRegistryValue targets the GPO's User portion.
    # ─────────────────────────────────────────────────────────────────────────────

    ModuleName  = 'AdminTemplatesUser'
    CISSection  = '19'
    Mechanism   = 'Registry'

    Controls = @(
        @{
            Id       = '19.1.3.1'
            Title    = 'Enable screen saver'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop'
                Name  = 'ScreenSaveActive'
                Type  = 'String'
                Value = '1'
            }
        }
        @{
            Id       = '19.1.3.2'
            Title    = 'Password protect the screen saver'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop'
                Name  = 'ScreenSaverIsSecure'
                Type  = 'String'
                Value = '1'
            }
        }
        @{
            Id       = '19.1.3.3'
            Title    = 'Screen saver timeout'
            Description = '900 seconds or fewer, but not 0'
            Registry = @{
                Path     = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop'
                Name     = 'ScreenSaveTimeOut'
                Type     = 'String'
                Value    = '900'
                Operator = 'LessOrEqual'
                MinValue = 1
            }
        }
        @{
            Id       = '19.5.1.1'
            Title    = 'Notifications: Turn off toast notifications on the lock screen'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'
                Name  = 'NoToastApplicationNotificationOnLockScreen'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '19.6.6.1.1'
            Title    = 'Internet Communication Management: Turn off Help Experience Improvement Program'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0'
                Name  = 'NoImplicitFeedback'
                Type  = 'DWord'
                Value = 1
            }
        }
        @{
            Id       = '19.7.4.1'
            Title    = 'Attachment Manager: Do not preserve zone information in file attachments'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments'
                Name  = 'SaveZoneInformation'
                Type  = 'DWord'
                Value = 2
            }
        }
        @{
            Id       = '19.7.4.2'
            Title    = 'Attachment Manager: Notify antivirus programs when opening attachments'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments'
                Name  = 'ScanWithAntiVirus'
                Type  = 'DWord'
                Value = 3
            }
        }
        @{
            Id       = '19.7.8.1'
            Title    = 'Windows Cloud Content: Configure Windows spotlight on lock screen'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
                Name  = 'ConfigureWindowsSpotlight'
                Type  = 'DWord'
                Value = 2
            }
        }
        @{
            Id       = '19.7.8.2'
            Title    = 'Windows Cloud Content: Do not suggest third-party content in Windows spotlight'
            Registry = @{
                Path  = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
                Name  = 'DisableThirdPartySuggestions'
                Type  = 'DWord'
                Value = 1
            }
        }
    )
}
