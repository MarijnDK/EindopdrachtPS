# Dit script wordt samen geleverd met het bestandje "test.csv"
# In dit bestand kan je de naam, voornaam en het wachtwoord van de gebruikers invullen.
# Als je daarna het script (op de DC van het gewenste domein) uitvoert worden de gebruikers automatisch aangemaakt en actief gezet.
# Voor de goede werking van het script is het nodig dat de 2 bestanden (import.ps1 en test.csv) in dezelfde directory staan.

# Importeren van het csv bestand voor gebruik in het script. Onafhankelijk van gebruikte directory
$Gebruikers = Import-Csv $psscriptroot\test.csv  -Delimiter ","
# Lus die elke gebruiker in het csv bestand afgaat en van deze input de benodigde variabelen genereert voor het
# aanmaken van een nieuwe gebruiker.
ForEach ($Gebruiker in $Gebruikers) {
$UserName = $Gebruiker.Voornaam.substring(0,1) + $Gebruiker.Naam -replace '\s',''
$password = ConvertTo-SecureString $Gebruiker.Wachtwoord -AsPlainText -Force
$Name = $Gebruiker.Voornaam + $Gebruiker.Naam
$Firstname = $Gebruiker.Voornaam
$Lastname = $Gebruiker.Naam
New-ADUser -Name $Name -SamAccountName $username -GivenName $Firstname -Surname $Lastname -UserPrincipalName $UserName -AccountPassword $password -enabled 1
}