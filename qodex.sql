CREATE DATABASE IF NOT EXISTS qodex;
USE qodex;

SET FOREIGN_KEY_CHECKS = 0;

-- TABLE utilisateurs
CREATE TABLE utilisateurs (
  id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  motdepasse VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL
);

INSERT INTO utilisateurs (nom, email, motdepasse, role) VALUES
('Prof Ahmed', 'ahmed@school.com', 'pass123', 'enseignant'),
('Mme Sara', 'sara@school.com', 'pass123', 'enseignant'),
('Ali', 'ali@student.com', 'pass123', 'etudiant'),
('Yasmine', 'yasmine@student.com', 'pass123', 'etudiant'),
('Omar', 'omar@student.com', 'pass123', 'etudiant');

-- TABLE categories
CREATE TABLE categories (
  id_categorie INT AUTO_INCREMENT PRIMARY KEY,
  nom_categorie VARCHAR(255) NOT NULL
);

INSERT INTO categories (nom_categorie) VALUES
('Mathématiques'),
('Histoire'),
('Informatique'),
('Physique');

-- TABLE quiz
CREATE TABLE quiz (
  id_quiz INT AUTO_INCREMENT PRIMARY KEY,
  title_quiz VARCHAR(255),
  description VARCHAR(255),
  duree_minutes FLOAT,
  id_enseignant INT,
  id_categorie INT,
  FOREIGN KEY (id_enseignant) REFERENCES utilisateurs(id_utilisateur),
  FOREIGN KEY (id_categorie) REFERENCES categories(id_categorie)
);

INSERT INTO quiz (title_quiz, description, duree_minutes, id_enseignant, id_categorie) VALUES
('Quiz HTML', 'Questions sur les bases du HTML', 20, 3, 1),
('Quiz SQL', 'Questions sur les bases du SQL', 30, 1, 3),
('Quiz HTML', 'Questions sur le HTML', 25, 2, 3),
('Quiz Algèbre', 'Évaluation en mathématiques', 40, 1, 1),
('Quiz Histoire Moderne', 'Questions sur l’histoire', 35, 2, 2);

-- TABLE questions
CREATE TABLE questions (
  id_question INT AUTO_INCREMENT PRIMARY KEY,
  text_question VARCHAR(255),
  reponse_correcte VARCHAR(255),
  points INT,
  id_quiz INT,
  FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz)
);

INSERT INTO questions (text_question, reponse_correcte, points, id_quiz) VALUES
('Que signifie SQL ?', 'Structured Query Language', 10, 1),
('Quelle balise HTML permet de créer un lien ?', '<a>', 5, 2),
('Résoudre: 3x + 2 = 11', 'x = 3', 10, 3),
('En quelle année a commencé la Première Guerre Mondiale ?', '1914', 8, 4),
('Quelle commande SQL permet de sélectionner des données ?', 'SELECT', 5, 1),
('Quelle balise définit un paragraphe ?', '<p>', 5, 2);

-- TABLE resultats
CREATE TABLE resultats (
  id_resultat INT AUTO_INCREMENT PRIMARY KEY,
  score INT,
  date_passage DATE,
  id_etudiant INT,
  id_quiz INT,
  FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz),
  FOREIGN KEY (id_etudiant) REFERENCES utilisateurs(id_utilisateur)
);

INSERT INTO resultats (score, date_passage, id_etudiant, id_quiz) VALUES
(85, '2025-01-01', 3, 1),
(70, '2025-01-02', 4, 1),
(90, '2025-01-03', 5, 2),
(55, '2025-01-04', 3, 3),
(65, '2025-01-05', 4, 4),
(40, '2025-01-06', 5, 3);

SET FOREIGN_KEY_CHECKS = 1;



-- Requête 1 : Ajouter un nouveau quiz créé par un enseignant
INSERT INTO quiz (title_quiz, description, id_categorie, id_enseignant, duree_minutes)
VALUES ('Quiz SQL', 'Questions sur le SQL', 3, 1, 30);

-- Requête 2 : Modifier la durée d'un quiz existant
UPDATE quiz
SET duree_minutes = 45
WHERE id_quiz = 1;

-- Requête 3 : Afficher tous les utilisateurs
SELECT * FROM utilisateurs;

-- Requête 4 : Afficher uniquement les noms et emails
SELECT nom, email FROM utilisateurs;

-- Requête 5 : Afficher tous les quiz
SELECT * FROM quiz;

-- Requête 6 : Afficher uniquement les titres des quiz
SELECT title_quiz FROM quiz;

-- Requête 7 : Afficher toutes les catégories
SELECT * FROM categories;

-- Requête 8 : Afficher les utilisateurs qui sont enseignants
SELECT * FROM utilisateurs
WHERE role = 'enseignant';

-- Requête 9 : Afficher les utilisateurs qui sont étudiants
SELECT * FROM utilisateurs
WHERE role = 'etudiant';

-- Requête 10 : Quiz durée > 30 minutes
SELECT * FROM quiz
WHERE duree_minutes > 30;

-- Requête 11 : Quiz durée ≤ 45 minutes
SELECT * FROM Quiz
WHERE duree_minutes <= 45;

-- Requête 12 : Questions valant + de 5 points
SELECT * FROM questions
WHERE points > 5;

-- Requête 13 : Quiz durée entre 20 et 40 minutes
SELECT * FROM quiz
WHERE duree_minutes BETWEEN 20 AND 40;

-- Requête 14 : Résultats score ≥ 60
SELECT * FROM resultats
WHERE score >= 60;

-- Requête 15 : Résultats score < 50
SELECT * FROM resultats
WHERE score < 50;

-- Requête 16 : Questions entre 5 et 15 points
SELECT * FROM questions
WHERE points BETWEEN 5 AND 15;

-- Requête 17 : Quiz créés par enseignant id = 1
SELECT * FROM quiz
WHERE id_enseignant = 1;

-- Requête 18 : Tous les quiz triés par durée (ascendant)
SELECT * FROM quiz
ORDER BY duree_minutes ASC;

-- Requête 19 : Résultats triés par score (descendant)
SELECT * FROM resultats
ORDER BY score DESC;

-- Requête 20 : Les 5 meilleurs scores
SELECT * FROM resultats
ORDER BY score DESC
LIMIT 5;

-- Requête 21 : Questions triées par points (faible → fort)
SELECT * FROM questions
ORDER BY points ASC;

-- Requête 22 : Les 3 derniers résultats (date décroissante)
SELECT * FROM resultats
ORDER BY date_passage DESC
LIMIT 3;

-- Requête 23 : Nom de chaque quiz avec sa catégorie
SELECT q.title_quiz, c.nom_categorie
FROM quiz q
JOIN categories c ON q.id_categorie = c.id_categorie;