#Shut down the another server when APC executes shutdown script.

#Constants to be set
$logName = "LOGNAME"
$serverToShutdown = "SERVERNAME"

New-EventLog -ComputerName $serverToShutdown -LogName System -Source $logName -ErrorAction SilentlyContinue

try{
    #actual thing to do
    #Stop-Computer -ComputerName $serverToShutdown -Force

    Write-EventLog `
            -ComputerName $serverToShutdown `
            -LogName System `
            -Source $logName `
            -Message "Sending shut down command to: $serverToShutdown from: $env:COMPUTERNAME." `
            -EventId 600 `
            -EntryType Warning
} catch {
    Write-EventLog `
            -ComputerName $serverToShutdown `
            -LogName System `
            -Source $logName `
            -Message "Unable to shut down remote server: $serverToShutdown sent from: $env:COMPUTERNAME." `
            -EventId 601 `
            -EntryType Error
    exit 1
}
exit 0