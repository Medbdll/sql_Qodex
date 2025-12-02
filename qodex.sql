SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `qodex`
--
CREATE DATABASE `qodex`;
USE `qodex`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id_categorie` int NOT NULL AUTO_INCREMENT,
  `nom_categorie` varchar(255) NOT NULL,
  PRIMARY KEY (`id_categorie`)
) 

INSERT INTO `categories` (`nom_categorie`) VALUES
('Mathématiques'),
('Histoire'),
('Informatique'),
('Physique');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id_question` int NOT NULL AUTO_INCREMENT,
  `text_question` varchar(255),
  `reponse_correcte` varchar(255),
  `points` int,
  `id_quiz` int,
  PRIMARY KEY (`id_question`),
  FOREIGN KEY (`id_quiz`) REFERENCES quiz(id_quiz)
);


INSERT INTO `questions` (`text_question`, `reponse_correcte`, `points`, `id_quiz`) VALUES
('Que signifie SQL ?', 'Structured Query Language', 10, 1),
('Quelle balise HTML permet de créer un lien ?', '<a>', 5, 2),
('Résoudre: 3x + 2 = 11', 'x = 3', 10, 3),
('En quelle année a commencé la Première Guerre Mondiale ?', '1914', 8, 4),
('Quelle commande SQL permet de sélectionner des données ?', 'SELECT', 5, 1),
('Quelle balise définit un paragraphe ?', '<p>', 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `id_quiz` int NOT NULL AUTO_INCREMENT,
  `title_quiz` varchar(255),
  `description` varchar(255),
  `duree_minutes` float,
  `id_enseignant` int,
  `id_categorie` int,
  PRIMARY KEY (`id_quiz`),
  FOREIGN KEY (`id_enseignant`) REFERENCES utilisateurs(id_utilisateur),
  FOREIGN KEY (`id_categorie`) REFERENCES categories(id_categorie)

);

INSERT `quiz` (`title_quiz`, `description`, `duree_minutes`, `id_enseignant`, `id_categorie`) VALUES
('Quiz HTML', 'Questions sur les bases du HTML', 20, 3, 1),
('Quiz SQL', 'Questions sur les bases du SQL', 30, 1, 3),
('Quiz HTML', 'Questions sur le HTML', 25, 2, 3),
('Quiz Algèbre', 'Évaluation en mathématiques', 40, 1, 1),
('Quiz Histoire Moderne', 'Questions sur l’histoire', 35, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `resultats`
--

CREATE TABLE `resultats` (
  `id_resultat` int NOT NULL AUTO_INCREMENT,
  `score` int DEFAULT NULL,
  `date_passage` date DEFAULT NULL,
  `id_etudiant` int DEFAULT NULL,
  `id_quiz` int DEFAULT NULL,
  PRIMARY KEY (`id_resultat`),
  FOREIGN KEY (`id_quiz`) REFERENCES quiz(id_quiz),
  FOREIGN KEY (`id_etudiant`) REFERENCES utilisateurs(id_utilisateur)
);

INSERT INTO `resultats` (`score`, `date_passage`, `id_etudiant`, `id_quiz`) VALUES
(85, '2025-01-01', 3, 1),
(70, '2025-01-02', 4, 1),
(90, '2025-01-03', 5, 2),
(55, '2025-01-04', 3, 3),
(65, '2025-01-05', 4, 4),
(40, '2025-01-06', 5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `motdepasse` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id_utilisateur`)
);

INSERT INTO `utilisateurs` (`nom`, `email`, `motdepasse`, `role`) VALUES
('Prof Ahmed', 'ahmed@school.com', 'pass123', 'enseignant'),
('Mme Sara', 'sara@school.com', 'pass123', 'enseignant'),
('Ali', 'ali@student.com', 'pass123', 'etudiant'),
('Yasmine', 'yasmine@student.com', 'pass123', 'etudiant'),
('Omar', 'omar@student.com', 'pass123', 'etudiant');
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
