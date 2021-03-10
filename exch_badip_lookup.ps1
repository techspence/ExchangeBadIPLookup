#### Hunt for bad IPs associated with the exchange zero-days ####
<# 

    # Directions:

        1. Gather up all the IPs you have found during your hunting/investigation
            - Using https://github.com/PwnDefend/badExchangePews/blob/main/detection.ps1 might be helpful
        2. Place them in a single txt file, one IP per line
        3. Run this script 
        
    # Output
        IPs found in your logs match those of a community list of IPs known to be "bad" aka associated with the exchange zero-day campaigns

#>

Invoke-RestMethod -Uri https://raw.githubusercontent.com/PwnDefend/badExchangePews/main/iplist.txt | out-file bad_ip_list.txt

$badips = Compare-Object -ReferenceObject (get-content ip_list.txt) -DifferenceObject (get-content bad_ip_list.txt) -IncludeEqual -ExcludeDifferent | Select InputObject

Write-Host "The following `"bad ips`" were found from your logs.." -ForegroundColor Red

$badips
