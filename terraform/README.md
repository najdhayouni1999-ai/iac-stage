# Stage IaC - Infrastructure Terraform + Proxmox + Ansible

Infrastructure as Code deployant une architecture 3-tiers (Web/App/DB) sur Proxmox VE via Terraform, avec configuration automatisee via Ansible. Application de demonstration : raccourcisseur d'URL avec suivi de campagnes marketing.

## Architecture

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

Toutes les VMs sont clonees depuis un template cloud-init Ubuntu 24.04 (VMID 9000) via un module Terraform reutilisable (modules/vm), sur le reseau 192.168.200.0/24 (passerelle 192.168.200.2).

## Prerequis

- Proxmox VE avec un template cloud-init Ubuntu 24.04 deja cree (VMID 9000)
- Terraform >= 1.15
- Une cle SSH ed25519 generee localement (ssh-keygen -t ed25519)
- Un token API Proxmox avec les droits de creation/gestion de VM

## Structure du projet

- provider.tf : configuration du provider bpg/proxmox
- variables.tf : variables globales (endpoint, token API)
- terraform.tfvars.example : modele de variables (a copier en .tfvars)
- main.tf : instanciation des 3 VMs via le module
- outputs.tf : IPs exposees en sortie
- inventory.tf : generation automatique de l'inventaire Ansible
- templates/inventory.tpl : modele d'inventaire Ansible
- modules/vm/ : module Terraform reutilisable (main.tf, variables.tf, outputs.tf, versions.tf)

## Deploiement

### 1. Configurer les variables

    cp terraform.tfvars.example terraform.tfvars

Editer terraform.tfvars avec l'endpoint Proxmox et le token API reels (ce fichier n'est jamais commite).

### 2. Initialiser Terraform

    terraform init

### 3. Verifier le plan

    terraform plan

Doit afficher 3 VMs a creer (web-01, app-01, db-01).

### 4. Provisionner l'infrastructure

    terraform apply

Cree les 3 VMs et genere automatiquement inventory.ini pour Ansible.

### 5. Configurer les VMs via Ansible

    ansible-playbook -i inventory.ini playbooks/site.yml

### 6. Verifier le deploiement

    curl http://<web_ip>/api/health

Doit retourner un statut ok.

## Detruire l'infrastructure

    terraform destroy

## Securite

- Aucun secret (token API, mot de passe DB, cle privee SSH) n'est commite dans ce depot
- terraform.tfvars et les fichiers .env sont exclus via .gitignore
- Utiliser terraform.tfvars.example comme modele pour recreer sa propre configuration

## Stack technique

- Infra : Proxmox VE, Terraform (provider bpg/proxmox)
- Configuration : Ansible
- Application : Python/FastAPI, PostgreSQL, Nginx
- Frontend : HTML/JS vanilla + Chart.js
