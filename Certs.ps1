$objUser = New-Object System.Security.Principal.NTAccount($env:USERNAME)
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
$strSID.Value

cpi Êëþ÷è-ÑÁÈÑ.reg key.reg

ls -recurse -Include key.reg | % {sp $_ isreadonly $false; (Get-Content $_) -replace "S-1-5-21-2534484743-1877657226-3327744508-1005","$strSID" | Set-Content -Path $_}

reg import .\key.reg
del key.reg

& 'C:\Program Files (x86)\Crypto Pro\CSP\csptest.exe' -absorb -certs

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');