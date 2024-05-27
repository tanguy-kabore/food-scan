# Food Scan

## Partie 1: Expression du besoin

### 1.1. Contexte et définition du projet

<p align="justify">
Dans un contexte où la prise de conscience autour de l'importance de la santé ne cesse de croître, la nécessité pour les consommateurs d'accéder facilement à des informations fiables et compréhensibles sur les produits qu'ils consomment est devenue primordiale. Ce projet vise à répondre à cette exigence en développant une solution numérique permettant de scanner les étiquettes des produits alimentaires, offrant ainsi une analyse instantanée de leur composition grâce à une intelligence artificielle. Ce projet a pour ambition de rendre l'information sur les produits transparente et accessible à tous, contribuant ainsi à améliorer la qualité de vie.
</p>

### 1.2. Objectif du projet

<p align="justify">
L'objectif principal de ce projet est de développer une application mobile qui facilite l'accès à des informations détaillées et fiables sur la composition des produits alimentaires, en vue d'améliorer la prise de décision des consommateurs concernant leur santé. Pour atteindre cet objectif global, le projet se concentre sur trois objectifs spécifiques :
</p>

- **Concevoir une interface utilisateur accessible et intuitive** :
  <p align="justify">
  L'objectif est de permettre une expérience utilisateur fluide et agréable, réduisant ainsi la courbe d'apprentissage et augmentant l'engagement des utilisateurs.
  </p>

- **Intégrer une fonction de recherche de produits** :
  <p align="justify">
  Développer une fonctionnalité permettant aux utilisateurs d’accéder instantanément à des informations détaillées sur un produit donné via un scan du code-barres.
  </p>

- **Fournir une analyse des ingrédients** :
  <p align="justify">
  Offrir aux utilisateurs des informations claires et précises sur les ingrédients. L'objectif est d'aider les consommateurs à comprendre l'impact de leurs choix alimentaires sur leur santé et à prendre des décisions éclairées concernant leur alimentation.
  </p>

### 1.3. Périmètre du projet

<p align="justify">
Le périmètre de ce projet englobe le développement d'une application mobile dédiée à la promotion d'une alimentation saine et informée pour les consommateurs.
</p>

### 1.4. Identité visuelle

<p align="center">
  <img src="readme_assets/logo/3.png" alt="Logo du projet" style="width:50%;">
</p>
<p align="center"><em>Image 1: Logo</em></p>

## Partie 2: Analyse et conception

### 2.1 Description fonctionnelle des besoins

<p align="justify">
La description fonctionnelle des besoins pour le développement de cette application mobile se détaille comme suit :
</p>

#### Fonctionnalités Principales

- **Interface Utilisateur Accessible et Intuitive**
  - **Besoin** : Création d'une interface utilisateur (UI) qui soit simple à naviguer. L'UI doit être conçue pour être esthétiquement plaisante et fonctionnelle sur divers appareils mobiles.
  - **Fonctionnalités UI** : Menus clairs, boutons larges, textes lisibles, navigation simplifiée, et adaptation à la taille de l'écran.

- **Recherche de Produit**
  - **Besoin** : Offrir une fonction de recherche permettant aux utilisateurs de trouver des produits par le code-barres.
  - **Fonctionnalités de Recherche** : Recherche de produit par code-barres.

- **Analyse des Ingrédients**
  - **Besoin** : Fournir des informations détaillées et fiables sur la composition des produits alimentaires, y compris les valeurs nutritionnelles, les ingrédients, et les allergènes grâce à une intelligence artificielle.
  - **Fonctionnalités d'Information** : Analyse de la composition du produit grâce à une intelligence artificielle.

#### Fonctionnalités Secondaires

- **Partage du Produit via les Réseaux Sociaux**
  - **Besoin** : Permettre aux utilisateurs de partager le produit avec leurs proches.
  - **Fonctionnalités de Partage** : Partage du produit via les réseaux sociaux.

- **Archivage du Produit**
  - **Besoin** : Permettre aux utilisateurs d'archiver le produit pour une utilisation hors ligne.
  - **Fonctionnalités d'Archivage** : Archivage du produit dans une base de données locale.

- **Création de Profil Utilisateur**
  - **Besoin** : Permettre aux utilisateurs de créer des profils.
  - **Fonctionnalités de Profil** : Enregistrement, connexion, gestion du compte.

### 2.2. Spécifications techniques

<p align="justify">
Pour garantir la réussite de ce projet, nous avons défini les spécifications techniques suivantes, qui orienteront le développement de l'application mobile. Ces spécifications ont été soigneusement choisies pour assurer la flexibilité, la performance et une excellente expérience utilisateur sur les différentes plateformes.
</p>

#### Architecture et Design Pattern

- **Architecture** : 
  <p align="justify">
  L'application sera conçue avec une architecture modulaire, ce qui signifie que les différentes fonctionnalités de l'application seront développées et gérées comme des modules indépendants. Cela permet une meilleure gestion du code, facilite la maintenance et permet des mises à jour et des ajouts de fonctionnalités sans affecter l'ensemble de l'application.
  </p>

- **Design Pattern** : 
  <p align="justify">
  Le projet suivra le design pattern Clean Architecture, qui sépare l'application en couches distinctes, chacune ayant ses propres responsabilités. Cela inclut les couches de présentation, de domaine, de données et d'infrastructure. Ce design pattern permet de rendre le code plus maintenable, testable et flexible.
  </p>

#### Backend

- **Open Food Facts API** : 
  <p align="justify">
  Utilisée pour la recherche de produits et l'authentification des utilisateurs. Open Food Facts fournit une base de données libre et collaborative sur les produits alimentaires, ce qui permet d'obtenir des informations détaillées et fiables sur une vaste gamme de produits.
  </p>
  
- **Gemini API** : 
  <p align="justify">
  Utilisée pour l'analyse des résultats des produits. Gemini API fournira des fonctionnalités avancées d'analyse et de traitement des données, permettant de fournir des informations précises et pertinentes aux utilisateurs concernant la composition des produits alimentaires.
  </p>

#### Front-end

- **Flutter** : 
  <p align="justify">
  Le développement front-end sera réalisé avec Flutter, un framework avancé permettant la création d'applications cross-platform pour iOS et Android. Flutter est choisi pour sa capacité à offrir une expérience utilisateur cohérente et performante sur les deux plateformes, grâce à son système de widgets personnalisables et son moteur de rendu performant. Cela permettra de garantir une interface utilisateur fluide, réactive et visuellement attrayante, tout en accélérant le cycle de développement grâce à la possibilité de réutiliser le code pour les deux plateformes.
  </p>

### 2.3. Diagramme de cas d'utilisation

<p align="justify">
L'acteur principal est l'utilisateur. Il peut créer un compte et se connecter. Ensuite, il peut scanner un produit puis, s'il le souhaite, analyser le produit ou le partager avec ses proches. Il peut également archiver le produit et le gérer hors ligne. Il peut aussi envoyer la localisation d'où il a scanné le produit. L'acteur secondaire est l'API d'Open Food Facts pour l'authentification et la recherche de produits, ainsi que l'API de Gemini pour l'analyse des produits.
</p>

<p align="center">
  <img src="readme_assets/diagrams/usecase.PNG" alt="Diagramme de cas d'utilisation" style="width:100%;">
</p>
<p align="center"><em>Image 2: Diagramme de cas d'utilisation</em></p>

### 2.4. Diagramme de classe

<p align="justify">
On a deux classes principales : une classe utilisateur et une classe produit. La classe utilisateur étend la classe utilisateur de l'API Open Food Facts et la classe produit étend la classe produit de l'API Open Food Facts.
</p>

<p align="center">
  <img src="readme_assets/diagrams/class.PNG" alt="Diagramme de classe" style="width:100%;">
</p>
<p align="center"><em>Image 3: Diagramme de classe</em></p>

### 2.5. Prototype

#### Onboarding

<p align="justify">
Le point d'entrée est le splash screen, puis le processus d'onboarding en passant par l'acceptation du contrat de licence, la phase d'inscription et de connexion, puis enfin, après connexion, on arrive sur la page d'accueil.
</p>

<p align="center">
  <img src="readme_assets/prototype/onboarding/1.jpg" alt="Screen 1" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/2.jpg" alt="Screen 2" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/3.jpg" alt="Screen 3" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/4.jpg" alt="Screen 4" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/5.jpg" alt="Screen 5" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/6.jpg" alt="Screen 6" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/7.jpg" alt="Screen 7" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/8.jpg" alt="Screen 8" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/onboarding/9.jpg" alt="Screen 9" style="width:30%; border: 1px solid black;">
</p>

#### Scan et recherche

<p align="justify">
La recherche d'un produit se fait par le scan du code-barres du produit, puis on obtient les photos du produit, les informations basiques du produit, les informations nutritionnelles, les informations sur les additifs et les allergènes, et enfin les informations additionnelles.
</p>

<p align="center">
  <img src="readme_assets/prototype/scan/10.jpg" alt="Screen 10" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/scan/11.jpg" alt="Screen 11" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/scan/12.jpg" alt="Screen 12" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/scan/13.jpg" alt="Screen 13" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/scan/14.jpg" alt="Screen 14" style="width:30%; border: 1px solid black;">
</p>

#### Analyse du produit

<p align="justify">
Il s'agit d'analyser le produit à l'aide de l'intelligence artificielle de Google nommée Gemini.
</p>

<p align="center">
  <img src="readme_assets/prototype/analyse/11.jpg" alt="Screen 11" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/analyse/17.jpg" alt="Screen 17" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/analyse/18.jpg" alt="Screen 18" style="width:30%; border: 1px solid black;">
</p>

#### Partage du produit

<p align="justify">
Il s'agit de partager le produit sur les réseaux sociaux de son choix.
</p>

<p align="center">
  <img src="readme_assets/prototype/share/11.jpg" alt="Screen 11" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/share/15.jpg" alt="Screen 15" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/share/16.jpg" alt="Screen 16" style="width:30%; border: 1px solid black;">
</p>

#### Historique des produits sauvegardés

<p align="justify">
Cet écran présente l'historique des produits sauvegardés.
</p>

<p align="center">
  <img src="readme_assets/prototype/history/19.jpg" alt="Screen 19" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/history/20.jpg" alt="Screen 20" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/history/23.jpg" alt="Screen 23" style="width:30%; border: 1px solid black;">
</p>

#### Partage de la localisation d'où le produit a été scanné

<p align="justify">
Ces écrans permettent de gérer les produits sauvegardés, en les supprimant, en les partageant ou en envoyant la localisation d'où le produit a été scanné.
</p>

<p align="center">
  <img src="readme_assets/prototype/location/23.jpg" alt="Screen 23" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/location/24.jpg" alt="Screen 24" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/location/27.jpg" alt="Screen 27" style="width:30%; border: 1px solid black;">
</p>

#### Les produits hors connexion

<p align="justify">
Cet écran permet de visualiser les produits lorsqu'on n'a pas de connexion internet à travers un mécanisme de cache pour les images et une base de données locale pour stocker les informations sur le produit.
</p>

<p align="center">
  <img src="readme_assets/prototype/offline/23.jpg" alt="Screen 23" style="width:30%; border: 1px solid black;">
  ➔
  <img src="readme_assets/prototype/offline/28.jpg" alt="Screen 28" style="width:30%; border: 1px solid black;">
</p>