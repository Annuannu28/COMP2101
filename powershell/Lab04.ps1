"1. System Hardware Description "

get-wmiobject -class win32_ComputerSystem |
foreach {
 new-object -TypeName psobject -Property @{
 ComputerName = $_.name
 Description = $_.description
 Manufacturer = $_.manufacturer
 ModelNumber = $_.model
 Processors = $_.numberofprocessors
 }
} |
ft -auto ComputerName, Description, Manufacturer, ModelNumber, Processors

"2. Operating System Name and Version "

get-wmiobject -class win32_operatingsystem |
foreach {
 new-object -TypeName psobject -Property @{
 OperatingSystemName = $_.name
 OSVersion = $_.version
 }
} |
ft -auto OperatingSystemName, OSVersion


"3. Processor "

get-wmiobject -class win32_processor |
foreach {
 new-object -TypeName psobject -Property @{
 Description = $_.description
 TotalCores = $_.numberofcores
 L1CacheSize = $_.l1cachesize + "DataNotAvailable"
 L2CacheSize = $_.l2cachesize
 L3CacheSize = $_.l3cachesize
 }
} |
ft -auto Description, TotalCores, L1CacheSize, L2CacheSize, L3CacheSize

"4. Physical Memory "

$totalcapacity = 0
get-wmiobject -class win32_physicalmemory |
foreach {
 new-object -TypeName psobject -Property @{
 Description = $_.description
 Manufacturer = $_.manufacturer
 "Speed(MHz)" = $_.speed
 "Size(MB)" = $_.capacity/1mb
 Bank = $_.banklabel
 Slot = $_.devicelocator
 }
 $totalcapacity += $_.capacity/1mb
} |
ft -auto Description, Manufacturer, "Size(MB)", "Speed(MHz)", Bank, Slot
"Total RAM: ${totalcapacity}MB "

"5. physical disk drives "

$diskdrives = Get-CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
           }
      }
  }

get-wmiobject -class win32_diskpartition |
foreach {
 new-object -TypeName psobject -Property @{
 Description = $_.description
 ModelName = $_.model
 Size = $_.size
 FreeSpace = $_.freespace + "DataNotAvailable"
 PercentageFree = $_.percentageoffreespace + "DataNotAvailable"
 }
} |
ft -auto Description, ModelName, Size, FreeSpace, PercentageFree


get-wmiobject -class win32_logicaldisk |
foreach {
 new-object -TypeName psobject -Property @{
 Description = $_.description
 ModelName = $_.model + "DataNotAvailable"
 Size = $_.size
 FreeSpace = $_.freespace 
 PercentageFree = $_.percentageoffreespace + "DataNotAvailable"
 }
} |
ft -auto Description, ModelName, Size, FreeSpace, PercentageFree

"6. Network Adapter Configuration "

get-wmiobject -class win32_networkadapterconfiguration |
foreach {
 new-object -TypeName psobject -Property @{
 Description = $_.description
 Index = $_.index
 IPAddress = $_.ipaddress
 SubnetMask = $_.subnetmask + "DataNotAvailable"
 DNSDomainName = $_.dnsdomain + "DataNotAvailable"
 DNSServer = $_.dnsserver + "DataNotAvailable"
 }
} |
ft -auto Description, Index, IPAddress, SubnetMask, DNSDomian, DNSServer


"7. Vedio Controller "

get-wmiobject -class win32_videocontroller |
foreach {
 new-object -TypeName psobject -Property @{
 Vendor = $_.vendor + "DataNotAvailable"
 Description = $_.description
 CurrentScreenResolution = $_.currenthorizontalresolution ,'X', $_.currentverticalresolution
 }
} |
ft -auto Vendor, Description, CurrentScreenResolution







