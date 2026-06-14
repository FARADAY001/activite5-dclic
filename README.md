# Magazine Infos — Gestion des Rédacteurs

Application Flutter Android de gestion des rédacteurs d'un magazine numérique, connectée à Firebase Firestore en temps réel.

---

## Fonctionnalités

- **Page d'accueil** : présentation du magazine avec titre, description, icônes de contact (téléphone, mail, partage) et rubriques
- **Ajouter un rédacteur** : formulaire avec validation (nom et spécialité obligatoires)
- **Liste des rédacteurs** : affichage temps réel via StreamBuilder, avec recherche par nom ou spécialité et tri (A→Z, Z→A)
- **Détail d'un rédacteur** : affichage complet des informations avec raccourci vers la modification
- **Modifier un rédacteur** : formulaire prérempli avec les données existantes
- **Supprimer un rédacteur** : confirmation par boîte de dialogue avant suppression

---

## Architecture MVC

```
lib/
├── main.dart                        # Initialisation Firebase + point d'entrée
├── modele/
│   └── redacteur.dart               # Modèle de données (fromFirestore, toMap)
├── controllers/
│   └── redacteur_controller.dart    # Logique CRUD Firestore
├── views/
│   ├── ajout_redacteur_page.dart    # Formulaire d'ajout
│   ├── redacteur_info_page.dart     # Liste + recherche + tri
│   ├── detail_redacteur_page.dart   # Détail d'un rédacteur
│   └── modifier_redacteur_page.dart # Formulaire de modification
├── pages/
│   ├── home_page.dart               # Page principale avec Drawer
│   └── accueil_page.dart            # Contenu de la page d'accueil
└── widgets/
    ├── app_drawer.dart              # Menu de navigation latéral
    ├── partie_titre.dart            # Widget titre du magazine
    ├── partie_texte.dart            # Widget description
    ├── partie_icone.dart            # Widget icônes de contact
    └── partie_rubrique.dart         # Widget rubriques (images)
```

### Rôles des couches

| Couche | Rôle |
|--------|------|
| **Model** | Représente les données. Aucune logique d'interface. |
| **Controller** | Centralise tous les accès à Firestore. Les vues ne touchent jamais Firestore directement. |
| **View** | Affiche les données et transmet les actions utilisateur au contrôleur. |

---

## Technologies utilisées

| Technologie | Usage |
|-------------|-------|
| Flutter | Framework mobile Android |
| Firebase Firestore | Base de données temps réel |
| firebase_core | Initialisation Firebase |
| cloud_firestore | Accès à la base Firestore |
| url_launcher | Appel téléphonique et email |
| share_plus | Partage natif |

---

## Structure Firestore

```
Collection : redacteurs
└── {id auto-généré}
    ├── nom       : String
    └── specialite: String
```

---

## Installation et configuration

### Prérequis
- Flutter SDK installé
- Android Studio ou VS Code
- Un compte Firebase

### Étapes

1. **Cloner le projet**
   ```bash
   git clone <url-du-projet>
   cd activite5-dclic
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configurer Firebase**
   - Créer un projet sur [console.firebase.google.com](https://console.firebase.google.com)
   - Ajouter une application Android avec l'ID : `com.example.activite5plus`
   - Télécharger `google-services.json` et le placer dans `android/app/`
   - Créer une base Firestore avec la collection `redacteurs`

4. **Lancer l'application**
   ```bash
   flutter run
   ```

---

## Auteur

Projet réalisé dans le cadre du cours **Développement Mobile — Niveau Approfondi**  
Activité n°3 — Flutter + Firebase Firestore + Architecture MVC
