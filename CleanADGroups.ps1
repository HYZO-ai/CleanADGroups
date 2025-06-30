# Importer le module Active Directory
Import-Module ActiveDirectory

# Spécifier le chemin complet de l'OU
$ouPath = "OU=Compte désactivé,OU=Users,OU=_Mobilis,DC=????????,DC=local"

# Nom des groupes à conserver dans le champ MemberOf
$groupesAConserver = "Utilisa. du domaine"

# Chemin du fichier sur le bureau local
$fichierResultats = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'Groupes_supprimés_OU_désactivé.txt')

# Récupérer la liste des utilisateurs dans l'OU spécifiée
$utilisateurs = Get-ADUser -Filter * -SearchBase $ouPath

foreach ($utilisateur in $utilisateurs) {
    # Récupérer la liste des groupes de l'utilisateur
    $groupesUtilisateur = Get-ADUser $utilisateur | Get-ADPrincipalGroupMembership | Select-Object -ExpandProperty Name

    # Vérifier si l'utilisateur est dans l'un des groupes à conserver
    $estDansGroupeAConserver = $groupesAConserver -contains ($groupesUtilisateur -join ',')

    if (-not $estDansGroupeAConserver) {
        # Supprimer tous les groupes du champ MemberOf, sauf les groupes à conserver
        $groupesASupprimer = $groupesUtilisateur | Where-Object { $_ -notin $groupesAConserver }
        
        foreach ($groupeASupprimer in $groupesASupprimer) {
            Remove-ADGroupMember -Identity $groupeASupprimer -Members $utilisateur -Confirm:$false
            $resultat = "$(Get-Date -Format 'dd/MM/yyyy HH:mm') - L'utilisateur $($utilisateur.SamAccountName) a été retiré du groupe $($groupeASupprimer)."
            Write-Host $resultat
            $resultat | Out-File -Append -FilePath $fichierResultats
        }
    }
}