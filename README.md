
# Qodex

Ce projet a pour objectif la conception et la mise en place d'une base de données robuste destinée à la plateforme web Qodex. Il englobe la modélisation des données, la création du schéma via SQL et un diagramme entité-relation (ERD), ainsi que la définition d'une stratégie pour assurer la pérennité et l'évolution de la plateforme.


## Schéma de la Base de Données :

Utilisateurs
    id_utilisateur
    nom
    email
    motdepasse
    role (enseignant ou etudiant)

Categories
    id_categorie
    nom_categorie (Mathématiques, Histoire, Informatique, etc.)

Quiz
    id_quiz (PK)
    titre_quiz
    description
    id_categorie
    id_enseignant
    duree_minutes

Questions
    id_question
    texte_question
    reponse_correcte
    points
    id_quiz
    
Resultats
    id_resultat
    score
    date_passage
    id_etudiant
    id_quiz