get-ciminstance win32_networkadapterconfiguration | where-object ipenabled | Format-Table -Property Description, Index, IPAddress, DnsDomain, DnsServer, SubnetMask