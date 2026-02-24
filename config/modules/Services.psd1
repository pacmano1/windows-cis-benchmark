@{
    # ─────────────────────────────────────────────────────────────────────────────
    # CIS Section 5 — System Services
    # Mechanism: Service startup type (audit via Get-Service, apply via registry)
    # ─────────────────────────────────────────────────────────────────────────────

    ModuleName  = 'Services'
    CISSection  = '5'
    Mechanism   = 'Service'

    Controls = @(
        @{
            Id          = '5.1'
            Title       = 'Bluetooth Audio Gateway Service (BTAGService)'
            ServiceName = 'BTAGService'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.2'
            Title       = 'Bluetooth Support Service (bthserv)'
            ServiceName = 'bthserv'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.3'
            Title       = 'Computer Browser (Browser)'
            ServiceName = 'Browser'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.4'
            Title       = 'Downloaded Maps Manager (MapsBroker)'
            ServiceName = 'MapsBroker'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.5'
            Title       = 'Geolocation Service (lfsvc)'
            ServiceName = 'lfsvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.6'
            Title       = 'IIS Admin Service (IISADMIN)'
            ServiceName = 'IISADMIN'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.7'
            Title       = 'Infrared Monitor Service (irmon)'
            ServiceName = 'irmon'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.8'
            Title       = 'Internet Connection Sharing (SharedAccess)'
            ServiceName = 'SharedAccess'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.9'
            Title       = 'Link-Layer Topology Discovery Mapper (lltdsvc)'
            ServiceName = 'lltdsvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.10'
            Title       = 'LxssManager (LxssManager)'
            ServiceName = 'LxssManager'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.11'
            Title       = 'Microsoft FTP Service (FTPSVC)'
            ServiceName = 'FTPSVC'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.12'
            Title       = 'Microsoft iSCSI Initiator Service (MSiSCSI)'
            ServiceName = 'MSiSCSI'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.13'
            Title       = 'OpenSSH SSH Server (sshd)'
            ServiceName = 'sshd'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.14'
            Title       = 'Peer Networking Grouping (p2psvc)'
            ServiceName = 'p2psvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.15'
            Title       = 'Peer Networking Identity Manager (p2pimsvc)'
            ServiceName = 'p2pimsvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.16'
            Title       = 'PNRP Machine Name Publication Service (PNRPAutoReg)'
            ServiceName = 'PNRPAutoReg'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.17'
            Title       = 'Print Spooler (Spooler)'
            ServiceName = 'Spooler'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.18'
            Title       = 'Problem Reports and Solutions Control Panel Support (wercplsupport)'
            ServiceName = 'wercplsupport'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.19'
            Title       = 'Remote Access Auto Connection Manager (RasAuto)'
            ServiceName = 'RasAuto'
            StartType   = 'Disabled'
        }
        # 5.20, 5.21, 5.22 — RDP services — AWS exclusion (must stay enabled)
        @{
            Id          = '5.23'
            Title       = 'Remote Procedure Call Locator (RpcLocator)'
            ServiceName = 'RpcLocator'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.24'
            Title       = 'Remote Registry (RemoteRegistry)'
            ServiceName = 'RemoteRegistry'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.25'
            Title       = 'Routing and Remote Access (RemoteAccess)'
            ServiceName = 'RemoteAccess'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.26'
            Title       = 'Server (LanmanServer)'
            Description = 'If not needed; many environments require SMB file sharing'
            ServiceName = 'LanmanServer'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.27'
            Title       = 'Simple TCP/IP Services (simptcp)'
            ServiceName = 'simptcp'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.28'
            Title       = 'SNMP Service (SNMP)'
            ServiceName = 'SNMP'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.29'
            Title       = 'SSDP Discovery (SSDPSRV)'
            ServiceName = 'SSDPSRV'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.30'
            Title       = 'UPnP Device Host (upnphost)'
            ServiceName = 'upnphost'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.31'
            Title       = 'Web Management Service (WMSvc)'
            ServiceName = 'WMSvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.32'
            Title       = 'Windows Error Reporting Service (WerSvc)'
            ServiceName = 'WerSvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.33'
            Title       = 'Windows Event Collector (Wecsvc)'
            ServiceName = 'Wecsvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.34'
            Title       = 'Windows Media Player Network Sharing Service (WMPNetworkSvc)'
            ServiceName = 'WMPNetworkSvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.35'
            Title       = 'Windows Mobile Hotspot Service (icssvc)'
            ServiceName = 'icssvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.36'
            Title       = 'Windows Push Notifications System Service (WpnService)'
            ServiceName = 'WpnService'
            StartType   = 'Disabled'
        }
        # 5.39 — WinRM — AWS exclusion (must stay enabled)
        @{
            Id          = '5.40'
            Title       = 'World Wide Web Publishing Service (W3SVC)'
            ServiceName = 'W3SVC'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.41'
            Title       = 'Xbox Accessory Management Service (XboxGipSvc)'
            ServiceName = 'XboxGipSvc'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.42'
            Title       = 'Xbox Live Auth Manager (XblAuthManager)'
            ServiceName = 'XblAuthManager'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.43'
            Title       = 'Xbox Live Game Save (XblGameSave)'
            ServiceName = 'XblGameSave'
            StartType   = 'Disabled'
        }
        @{
            Id          = '5.44'
            Title       = 'Xbox Live Networking Service (XboxNetApiSvc)'
            ServiceName = 'XboxNetApiSvc'
            StartType   = 'Disabled'
        }
    )
}
