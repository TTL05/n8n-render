# 🚀 N8N FREELANCEWAAR - Instance Render

Instance N8N optimisée pour l'automatisation des workflows de facturation de l'agence **FREELANCEWAAR**.

## 📋 Informations de Déploiement

- **Service** : N8N Workflow Automation
- **Hébergement** : Render.com
- **Région** : Frankfurt (EU Central) - Optimisé pour l'Afrique de l'Ouest
- **Base de Données** : PostgreSQL 15
- **Timezone** : Africa/Dakar

## 🔗 URLs

- **Interface N8N** : `https://n8n-freelancewaar.onrender.com`
- **Webhooks** : `https://n8n-freelancewaar.onrender.com/webhook/`
- **Health Check** : `https://n8n-freelancewaar.onrender.com/healthz`

## 📦 Structure du Projet

```
n8n-render/
├── render.yaml          # Configuration Blueprint Render
├── Dockerfile           # Image Docker N8N
├── .dockerignore       # Fichiers à exclure du build
├── .gitignore          # Fichiers à exclure de Git
└── README.md           # Ce fichier
```

## ⚙️ Configuration

### Variables d'Environnement Critiques

Les variables suivantes sont **auto-configurées** par Render via `render.yaml` :

#### Base de Données
- `DB_TYPE=postgresdb`
- `DB_POSTGRESDB_HOST` (auto)
- `DB_POSTGRESDB_PORT` (auto)
- `DB_POSTGRESDB_DATABASE` (auto)
- `DB_POSTGRESDB_USER` (auto)
- `DB_POSTGRESDB_PASSWORD` (auto)

#### URLs (À configurer manuellement après déploiement)
- `N8N_EDITOR_BASE_URL=https://n8n-freelancewaar.onrender.com`
- `WEBHOOK_URL=https://n8n-freelancewaar.onrender.com`

#### Sécurité
- `N8N_ENCRYPTION_KEY` (généré automatiquement)
- `N8N_USER_MANAGEMENT_JWT_SECRET` (généré automatiquement)

## 🚀 Déploiement Initial

### Étape 1 : Préparer le Repository

```bash
# Cloner ce repository
git clone https://github.com/VOTRE_USERNAME/n8n-render.git
cd n8n-render

# Vérifier les fichiers
ls -la
# Vous devriez voir: render.yaml, Dockerfile, .dockerignore
```

### Étape 2 : Déployer sur Render

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur **New +** → **Blueprint**
3. Connectez votre repository GitHub `n8n-render`
4. Render détecte automatiquement `render.yaml`
5. Cliquez sur **Apply**
6. Attendez 5-10 minutes pour le déploiement

### Étape 3 : Configurer les URLs

**Sur Render Dashboard → Service n8n-freelancewaar → Environment**

Ajoutez/Modifiez ces variables :

```bash
N8N_HOST=n8n-freelancewaar.onrender.com
N8N_EDITOR_BASE_URL=https://n8n-freelancewaar.onrender.com
WEBHOOK_URL=https://n8n-freelancewaar.onrender.com
```

Cliquez sur **Save Changes** → Le service redémarre automatiquement

### Étape 4 : Créer le Compte Owner

1. Allez sur `https://n8n-freelancewaar.onrender.com`
2. Créez votre compte administrateur
3. Configurez votre profil

## 🔧 Configuration OAuth Google Drive

### Étape 1 : Google Cloud Console

1. Allez sur [Google Cloud Console](https://console.cloud.google.com/)
2. **APIs & Services → Credentials**
3. Créez ou éditez un **OAuth 2.0 Client ID**
4. **Authorized redirect URIs** → Ajoutez :

```
https://n8n-freelancewaar.onrender.com/rest/oauth2-credential/callback
```

5. Sauvegardez

### Étape 2 : Dans N8N

1. **Credentials → New Credential**
2. Sélectionnez **Google Drive OAuth2 API**
3. Entrez vos Client ID et Client Secret
4. Cliquez sur **Connect my account**
5. Autorisez l'accès

## 📊 Google Sheets Configuration

### Créer les Feuilles

Créez un Google Sheet nommé **"FREELANCEWAAR - Facturation"** avec 2 sheets :

#### Sheet 1 : "Devis_FREELANCEWAAR"
Colonnes : N°, Date Devis, Client Nom, Client Email, Client Adresse, Type Service, Sous-Total HT, TVA %, TVA Montant, Total TTC, Acompte, Reste à Payer, Statut, Travaux Terminés, URL Devis PDF, Notes

#### Sheet 2 : "Factures_FREELANCEWAAR"
Colonnes : N° Facture, N° Devis Lié, Date Émission, Date Échéance, Client Nom, Client Email, Client Téléphone, Client Adresse, Type Service, Total HT, TVA %, TVA Montant, Total TTC, Acompte Payé, Reste à Payer, URL Facture PDF, URL Devis, Moyens Paiement, Rappel 7 Jours, Rappel 14 Jours, Rappel 30 Jours, Payée, Date Paiement, Notes

### Récupérer les IDs

**Google Sheet ID** :
```
https://docs.google.com/spreadsheets/d/ABC123XYZ/edit
                                          ↑↑↑↑↑↑↑↑↑
                                      Copiez cet ID
```

**Google Drive Folder ID** :
```
https://drive.google.com/drive/folders/XYZ789ABC
                                         ↑↑↑↑↑↑↑↑↑
                                     Copiez cet ID
```

## 🔄 Workflow de Facturation

### Flux Automatisé

1. **Devis signé** → Upload PDF dans Google Drive "Devis Signés"
2. **Extraction IA** → N8N extrait les données du PDF
3. **Ajout Sheet** → Données ajoutées dans "Devis_FREELANCEWAAR"
4. **Travaux terminés** → Cocher la case dans le Sheet
5. **Génération Facture** → N8N génère le PDF via invoice-generator.com
6. **Upload Facture** → PDF uploadé dans Drive "Factures"
7. **Mise à jour Sheet** → Données ajoutées dans "Factures_FREELANCEWAAR"
8. **Email** → Notification envoyée au client

### Relances Automatiques

- **7 jours** : Rappel amical
- **14 jours** : Rappel insistant
- **30 jours** : Rappel final

## 🛠️ Maintenance

### Voir les Logs

```bash
# Sur Render Dashboard
Service n8n-freelancewaar → Logs (en temps réel)
```

### Redéployer Manuellement

```bash
# Sur Render Dashboard
Service n8n-freelancewaar → Manual Deploy → Deploy latest commit
```

### Mettre à Jour N8N

N8N se met à jour automatiquement car nous utilisons `n8nio/n8n:latest`.

Pour forcer une mise à jour :
1. Render Dashboard → Service → **Manual Deploy**
2. Docker téléchargera la dernière version

### Backup des Workflows

**Important** : La DB gratuite expire après 90 jours !

```bash
# Dans N8N
Workflows → Select All → Download
```

Sauvegardez le fichier JSON sur votre PC.

## ⚠️ Limitations Plan Gratuit

### Service Web
- ✅ 750 heures/mois (suffisant pour 24/7)
- ❌ 512 MB RAM (limité)
- ❌ Se met en veille après 15 min d'inactivité
- ❌ Redémarrage lent (~30-60 secondes)

### PostgreSQL
- ✅ 1 GB stockage
- ❌ **Expire après 90 jours** (⚠️ CRITIQUE)
- ❌ Connexions limitées

### Solution Anti-Veille

Utilisez [UptimeRobot](https://uptimerobot.com) (gratuit) :
- Monitor HTTPS
- URL : `https://n8n-freelancewaar.onrender.com/healthz`
- Interval : 5 minutes

## 💰 Upgrade Recommandé

Pour une utilisation professionnelle :

**Plan Starter ($14/mois total)** :
- ✅ Service Web : $7/mois (2 GB RAM, toujours actif)
- ✅ PostgreSQL : $7/mois (permanent, pas d'expiration)
- ✅ Backup automatique
- ✅ Meilleure performance

## 🆘 Dépannage

### Problème : "localhost refused to connect"

**Solution** : Variables URL mal configurées

```bash
# Vérifier sur Render → Environment
N8N_EDITOR_BASE_URL=https://n8n-freelancewaar.onrender.com
WEBHOOK_URL=https://n8n-freelancewaar.onrender.com
```

### Problème : "Out of Memory"

**Solution 1** : Upgrade vers Plan Starter ($7/mois)

**Solution 2** : Optimiser (déjà fait dans render.yaml)

### Problème : "Service Unavailable 502"

**Solution** : 
1. Attendez 60 secondes (service se réveille)
2. Vérifiez les logs
3. Redéployez si nécessaire

### Problème : Workflows perdus

**Cause** : DB non connectée

**Solution** :
```bash
# Vérifier sur Render → Environment
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=(doit être rempli)
```

## 📚 Ressources

- [Documentation N8N](https://docs.n8n.io)
- [Communauté N8N](https://community.n8n.io)
- [Documentation Render](https://render.com/docs)
- [Support FREELANCEWAAR](mailto:contact@freelancewaar.com)

## 📄 Licence

Propriété de FREELANCEWAAR - Tous droits réservés

---

**Dernière mise à jour** : Décembre 2024  
**Version** : 1.0.0  
**Contact** : contact@freelancewaar.com
