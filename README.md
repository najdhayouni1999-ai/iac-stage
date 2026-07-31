# Stage IaC — Infrastructure 3-Tiers (Terraform + Ansible)

Infrastructure as Code deployant une architecture **Web / App / DB** sur **Proxmox VE** via **Terraform**, avec configuration automatisee via **Ansible**. Application de demonstration : raccourcisseur d'URL avec suivi de campagnes marketing.

## Architecture

```text
Utilisateur
    |  HTTP :80
    v
web-01 (192.168.200.51)  -- Nginx (reverse proxy + front statique)
    |  HTTP :8080 (/api/*)
    v
app-01 (192.168.200.52)  -- FastAPI / Uvicorn (API applicative)
    |  PostgreSQL :5432
    v
db-01  (192.168.200.53)  -- PostgreSQL 16 (persistance)
```

Les 3 VMs sont clonees depuis un template cloud-init **Ubuntu 24.04** (VMID 9000) via un module Terraform reutilisable, sur le reseau `192.168.200.0/24` (passerelle `192.168.200.2`).

## Structure du projet

```text
iac-stage/
├── README.md                          # Ce fichier — vue d'ensemble du projet
├── .gitignore                         # Exclusion des secrets et fichiers sensibles
├── terraform/                         # Provisionnement de l'infrastructure (Proxmox)
│   ├── README.md                      # Documentation detaillee Terraform
│   ├── main.tf                        # Instanciation des 3 VMs + generation inventaire
│   ├── terraform.tfvars.example       # Modele de variables (a copier en .tfvars)
│   ├── templates/inventory.tpl        # Template d'inventaire Ansible
│   └── modules/vm/                    # Module Terraform reutilisable
└── ansible/                           # Configuration des VMs
    ├── README.md                      # Documentation detaillee Ansible
    ├── inventory.ini.example          # Modele d'inventaire (a copier en inventory.ini)
    └── playbooks/site.yml             # Playbook principal (Nginx, upgrades, PostgreSQL)
```

## Prerequis

- **Proxmox VE** avec un template cloud-init Ubuntu 24.04 (VMID 9000)
- **Terraform** >= 1.15
- **Ansible** installe sur la machine d'administration (ex. app-01)
- Cle SSH **ed25519** generee localement (`ssh-keygen -t ed25519`)
- Token API Proxmox avec droits de creation/gestion de VM

## Deploiement (resume)

### 1. Provisionner l'infrastructure (Terraform)

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars   # puis editer avec vos valeurs
terraform init
terraform plan
terraform apply
```

Terraform cree les 3 VMs et genere automatiquement `terraform/inventory.ini`.

Documentation complete : [terraform/README.md](terraform/README.md)

### 2. Configurer les VMs (Ansible)

```bash
cd ansible
cp inventory.ini.example inventory.ini         # puis adapter les IPs si besoin
ansible-playbook -i inventory.ini playbooks/site.yml
```

Documentation complete : [ansible/README.md](ansible/README.md)

### 3. Verifier le deploiement

```bash
curl http://192.168.200.51/api/health
```

Doit retourner un statut `ok`.

## Securite

- **Aucun secret** (token API, mot de passe DB, cle privee SSH) n'est commite dans ce depot
- Les fichiers sensibles sont exclus via `.gitignore` :
  - `terraform/terraform.tfvars`
  - `terraform/inventory.ini` (genere par Terraform)
  - `ansible/inventory.ini` (copie locale depuis l'exemple)
  - `ansible/vault.yml`, `ansible/*.retry`
- Utiliser les fichiers `.example` comme modeles pour recreer sa propre configuration

## Stack technique

| Couche | Technologies |
|--------|-------------|
| Infrastructure | Proxmox VE, Terraform (provider bpg/proxmox) |
| Configuration | Ansible |
| Application | Python / FastAPI, PostgreSQL, Nginx |
| Frontend | HTML / JS vanilla + Chart.js |

## Detruire l'infrastructure

```bash
cd terraform
terraform destroy
```
