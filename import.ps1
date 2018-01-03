$Gebruikers = Import-Csv $psscriptroot\test.csv  -Delimiter ","
ForEach ($Gebruiker in $Gebruikers) {
$UserName = $Gebruiker.Voornaam.substring(0,1) + $Gebruiker.Naam -replace '\s',''
$password = ConvertTo-SecureString $Gebruiker.Wachtwoord -AsPlainText -Force
$Name = $Gebruiker.Voornaam + $Gebruiker.Naam
$Firstname = $Gebruiker.Voornaam
$Lastname = $Gebruiker.Naam

New-ADUser -Name $Name -SamAccountName $username -GivenName $Firstname -Surname $Lastname -UserPrincipalName $UserName -AccountPassword $password -passwordneverexpires 1 -enabled 1
}
pause