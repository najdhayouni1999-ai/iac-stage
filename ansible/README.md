# Configuration Ansible — Infrastructure 3-Tiers

Ce dossier contient la configuration Ansible pour le provisionnement et la configuration automatique des machines virtuelles (Web, App, DB) créées par Terraform.

## Structure du dossier

```text
ansible/
├── inventory.ini        # Inventaire des serveurs (web-01, app-01, db-01)
├── playbooks/
│   └── site.yml         # Playbook principal de configuration des services
└── README.md            # Documentation de la partie Ansible
```

## Inventory (`inventory.ini`)

L'inventaire définit les 3 nœuds de l'infrastructure :
- **web** (`192.168.200.51`) : Serveur Web Nginx
- **app** (`192.168.200.52`) : Serveur Applicatif FastAPI / Python 3.12
- **db**  (`192.168.200.53`) : Serveur Base de Données PostgreSQL 16

## Utilisation

Pour exécuter le playbook depuis le serveur d'administration (ex. `app-01`) ou une machine ayant accès SSH aux VMs :

```bash
ansible-playbook -i inventory.ini playbooks/site.yml
```
