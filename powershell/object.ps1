get-ciminstance win32_networkadapterconfiguration | where-object ipenabled | Format-Table -Property Description, Index, IPEnabled, IPAddress, DnsDomain, DnsServer, SubnetMask