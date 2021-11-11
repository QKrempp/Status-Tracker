Status-Tracker
===
Petit outil en ligne de commande pour suivre visuellement l'avancement de mes projets par des dossiers colorés (ne fonctionne probablement qu'avec KDE et le set d'icônes Papirus)

La commande ```setstatus``` prend en paramètre le statut du projet (```done```, ```wip``` ou ```broken```), et l'enregistre dans un fichier ```.status``` dans le répertoire local. une fois les statuts des différents projets misà jour, on exécute la commande ```updatestatus``` qui va venir récursivement depuis le répertoire local (sans sortir de ```~/Projets```) créer les fichiers ```.directory``` correspondants pour colorer les dossier en fonction de l'état du projet.

## TODO

Il reste à actualiser le statut d'un sur-projet lorsque celui-ci est marqué comme ```wip```, et à faire une commande ```showstatus``` qui permettrait de visualiser en console, avec de la couleur, l'arborescence des projets.
