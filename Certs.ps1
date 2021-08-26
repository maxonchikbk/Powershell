$objUser = New-Object System.Security.Principal.NTAccount($env:USERNAME)
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
$strSID.Value

cpi original.reg key.reg

ls -recurse -Include key.reg | % {sp $_ isreadonly $false; (Get-Content $_) -replace "%BASE-SID%","$strSID" | Set-Content -Path $_}

reg import .\key.reg
del key.reg

& '%ProgramFiles(x86)%\Crypto Pro\CSP\csptest.exe' -absorb -certs

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
