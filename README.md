# CI/CD - Nginx avec GitHub Actions

Pipeline CI/CD pour une application Nginx conteneurisée.

## 📁 Structure du projet
.
├── .github/workflows/
│ ├── ci.yml # Niveaux 1 & 2 (build, tests)
│ └── cd-architect.yml # Niveau 3 (push GHCR + validation manuelle)
├── Dockerfile
├── nginx.conf
├── index.html
└── README.md


## 🐳 Fichiers clés

- **Dockerfile** : image Nginx alpine avec configuration et page HTML.
- **nginx.conf** : écoute sur le port 80, sert `index.html`, endpoint `/health`.
- **index.html** : page web de démonstration.

## ⚙️ Pipeline CI/CD

### Schéma

Push/PR sur main → CI (build, tests) → Push GHCR → Validation staging → Validation production → Déployé

### Niveaux

| Niveau | Déclenchement | Tests | Publication | Validation manuelle |
|--------|---------------|-------|-------------|---------------------|
| 1 (Novice) | Manuel | fichiers, nginx -t, HTTP | non | non |
| 2 (Engineer) | Auto sur push/PR | + /health | non | non |
| 3 (Architect) | Auto sur push | idem | oui (GHCR + SHA) | oui (staging puis prod) |

### 🔒 Sécurité

- Aucun secret dans le code ou les logs.
- `GITHUB_TOKEN` injecté automatiquement.
- Environnements `staging` et `production` avec *Required reviewers*.

## 📸 Captures d’écran

- Pipeline réussie (niveau 1) : `screenshots/niveau1-success.png`
- Échec volontaire : `screenshots/niveau1-failure.png`
- Pipeline niveau 2 : `screenshots/niveau2-success.png`
- Pipeline niveau 3 : `screenshots/niveau3-success.png`
- Validation manuelle : `screenshots/review-deployment.png`
- Image GHCR : `screenshots/ghcr-package.png`

## 🚀 Utilisation

```bash
git clone https://github.com/TALBOUSSOUMA/ci-cd-nginx.git
cd ci-cd-nginx
docker build -t nginx-test .
docker run -d -p 8080:80 nginx-test
# Ouvrir http://localhost:8080
```

## 📦 Images Docker

Disponibles sur GHCR :
https://github.com/TALBOUSSOUMA/ci-cd-nginx/pkgs/container/ci-cd-nginx

Tags : latest ou <sha_du_commit>.