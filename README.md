# 🚀 Ghost Auto Deploy

Déploiement automatique d’un blog Ghost avec Docker, MySQL, sauvegarde automatique et planification via cron.

![Ghost](https://img.shields.io/badge/Ghost-Blog-blueviolet?style=flat&logo=ghost&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Automation-blue?style=flat&logo=docker&logoColor=white)
![License](https://img.shields.io/badge/Libre-Utilisation-brightgreen)

---

## 📦 Ce projet fait quoi ?

Un seul script `deploy_ghost.sh` pour :

✅ Installer Docker (si absent)  
✅ Déployer Ghost avec MySQL en `docker-compose`  
✅ Sauvegarder automatiquement :
- le contenu (articles, images)
- la base de données (MySQL `.sql`)  
✅ Planifier un backup quotidien via `cron`  
✅ Lancer un blog local disponible sur [http://localhost:2368](http://localhost:2368)

---

## 🧱 Structure du projet

```
ghost-auto-deploy/
├── deploy_ghost.sh       # Script principal de déploiement
├── docker-compose.yml    # Fichier utilisé pour lancer Ghost + MySQL
├── backup_ghost.sh       # Script de sauvegarde automatique
├── backups/              # Dossier où les sauvegardes seront stockées
└── README.md             # Ce fichier
```

---

## ⚙️ Pré-requis

- Ubuntu / Debian (testé sur Ubuntu 22.04+)
- Accès root (`sudo`)  
- Connexion internet pour tirer les images Docker

> Pas besoin d’avoir Docker installé, le script s’en charge 🚀

---

## 🚀 Déploiement automatique

```bash
git clone https://github.com/tonpseudo/ghost-auto-deploy.git
cd ghost-auto-deploy
chmod +x deploy_ghost.sh
./deploy_ghost.sh
```

✅ Après quelques secondes, ton blog est dispo sur :
- [http://localhost:2368](http://localhost:2368)
- [http://localhost:2368/ghost](http://localhost:2368/ghost) pour l’interface d’admin

---

## 💾 Sauvegarde automatique

📍 Sauvegardes créées dans `backups/ghost_backup_YYYY-MM-DD_HH-MM-SS`

Contenu :
- `ghost_content.tar.gz` → tout le contenu de Ghost (images, posts, etc.)
- `ghost_db.sql` → dump SQL de la base MySQL

✅ Planifié tous les jours à **2h00 du matin** via `cron`.

📦 Tu peux aussi lancer manuellement :

```bash
./backup_ghost.sh
```

---

## 🔄 Restauration rapide

### 1. Restaurer le contenu :

```bash
docker run --rm   -v deploy-ghost_ghost_content:/data   -v $(pwd)/backups/ghost_backup_X:/restore   alpine   tar xzf /restore/ghost_content.tar.gz -C /data
```

### 2. Restaurer la base MySQL :

```bash
docker exec -i ghost-db   mysql -u ghost -pghostpass ghost < backups/ghost_backup_X/ghost_db.sql
```

---

## 🧠 Bonus : Pour aller plus loin

- Ajouter Nginx en reverse proxy avec HTTPS (Let's Encrypt)
- Intégrer GitHub Actions pour déploiement CI/CD
- Ajouter une rotation automatique des sauvegardes (7 derniers jours)
- Déploiement distant sur VPS ou VM cloud

---

## 🧑‍💻 Auteur

Projet réalisé par [@tonpseudo](https://github.com/tonpseudo) pour apprendre à déployer des services de manière propre, versionnée, et automatisée.

---

## 📝 Licence

Utilisation libre pour apprendre, tester, ou adapter dans un projet personnel ou pro.
