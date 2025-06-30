# 🧹 CleanADGroups - Script PowerShell de nettoyage des groupes AD pour comptes désactivés

**CleanADGroups** est un script PowerShell destiné à automatiser le nettoyage des appartenances aux groupes Active Directory pour les utilisateurs déplacés dans une OU spécifique (typiquement une OU "Comptes désactivés"). Il conserve uniquement les groupes essentiels définis par l'administrateur.

---

## 📋 Fonctionnalités

- Identifie tous les utilisateurs d'une OU donnée.
- Liste leurs groupes via le champ `MemberOf`.
- Supprime l'appartenance à tous les groupes sauf ceux explicitement autorisés.
- Génère un journal des modifications sur le bureau de l'utilisateur exécutant le script.

---

## ⚙️ Prérequis

Avant d’utiliser le script :

- Lancer PowerShell en **tant qu’administrateur**.
- Installer le module `ActiveDirectory` via RSAT.
- Être connecté à un **contrôleur de domaine** avec les **droits d'administration** suffisants.
- Adapter la variable `$ouPath` avec le nom de domaine correct (`DC=...`).

---

## 🧑‍💻 Utilisation

1. **Configurer le script** :
   - Remplacer la valeur de `$ouPath` avec le chemin LDAP de votre OU contenant les comptes désactivés.
   - Modifier `$groupesAConserver` si nécessaire (tableau de noms de groupes à conserver).

2. **Exécuter le script** :
   - Ouvrir PowerShell en tant qu’administrateur.
   - Lancer le script.

3. **Consulter le fichier de log** :
   - Un fichier nommé `Groupes_supprimés_OU_désactivé.txt` sera créé sur le **bureau** avec un historique des suppressions.

---

## ⚠️ Disclaimer
ATTENTION : ce script modifie la configuration Active Directory.
Il est vivement recommandé de tester le script dans un environnement de développement avant tout déploiement en production.
Vérifiez les appartenances aux groupes avant suppression.

L’auteur du script décline toute responsabilité en cas de perte de données, suppression accidentelle ou dysfonctionnement lié à l’usage du script.

---

## 📁 Exemple de sortie

```text
30/06/2025 10:23 - L'utilisateur jdoe a été retiré du groupe Marketing.
30/06/2025 10:23 - L'utilisateur jdoe a été retiré du groupe VPN-Access.

