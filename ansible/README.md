# Configuration Ansible — Infrastructure 3-Tiers

Ce dossier contient la configuration Ansible pour le provisionnement et la configuration automatique des machines virtuelles (Web, App, DB) creees par Terraform.

## Structure du dossier

```text
ansible/
├── inventory.ini.example  # Modele d'inventaire (a copier en inventory.ini)
├── inventory.ini          # Inventaire local (non commite, voir .gitignore)
├── playbooks/
│   └── site.yml           # Playbook principal de configuration des services
└── README.md              # Documentation de la partie Ansible
```

## Configuration de l'inventaire

1. Copier le fichier exemple :

```bash
cp inventory.ini.example inventory.ini
```

2. Adapter les IPs si necessaire. Les valeurs par defaut correspondent a l'architecture documentee :

| Groupe | IP | Role |
|--------|-----|------|
| **web** | `192.168.200.51` | Serveur Web Nginx |
| **app** | `192.168.200.52` | Serveur Applicatif FastAPI / Python 3.12 |
| **db**  | `192.168.200.53` | Serveur Base de Donnees PostgreSQL 16 |

> **Alternative :** apres `terraform apply`, un inventaire est genere automatiquement dans `terraform/inventory.ini`. Vous pouvez le copier ici.

Le fichier `inventory.ini` local n'est **jamais commite** (exclu via `.gitignore`).

## Utilisation

Pour executer le playbook depuis le serveur d'administration (ex. `app-01`) ou une machine ayant acces SSH aux VMs :

```bash
ansible-playbook -i inventory.ini playbooks/site.yml
```

## Securite

- Seules des **references de chemin** SSH sont utilisees (`~/.ssh/id_ed25519`), jamais de cle privee commitee
- `inventory.ini`, `vault.yml` et `*.retry` sont exclus du depot via `.gitignore`

Voir le [README principal](../README.md) pour la vue d'ensemble du projet.
