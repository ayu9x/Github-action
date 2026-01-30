# DevOps Assessment Application

A robust full-stack "Hello World" application built with **Django** (Backend) and **React** (Frontend), demonstrating modern DevOps best practices including Docker containerization, CI/CD pipelines, and Infrastructure as Code (Terraform).

![Status](https://img.shields.io/badge/Status-Live-success)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue)
![Terraform](https://img.shields.io/badge/Terraform-AWS-purple)

## 🚀 Live Demo
- **Public URL:** [http://44.214.6.170](http://44.214.6.170)
- **Admin Panel:** [http://44.214.6.170/admin/](http://44.214.6.170/admin/) (Credentials: `admin` / `admin`)
- **API Endpoint:** [http://44.214.6.170/api/hello/](http://44.214.6.170/api/hello/)

---

## 🏗️ Architecture

- **Frontend:** React 19 + TypeScript + Vite (Served via Nginx)
- **Backend:** Django 6.0 + Gunicorn + WhiteNoise (Static Files)
- **Database:** SQLite (Containerized with volume persistence)
- **Infrastructure:** AWS EC2 (t2.micro), VPC, Security Groups via **Terraform**
- **CI/CD:** GitHub Actions (Build & Push to Docker Hub)

---

## 🛠️ Local Setup

### Prerequisites
- Docker & Docker Compose
- Git

### Steps
1. **Clone the repository:**
   ```bash
   git clone https://github.com/ayu9x/Github-action.git
   cd Github-action
   ```

2. **Start the application:**
   ```bash
   docker-compose up -d --build
   ```

3. **Access the App:**
   - Frontend: [http://localhost:3001](http://localhost:3001)
   - Backend API: [http://localhost:8000](http://localhost:8000)

4. **Create Superuser (Optional):**
   ```bash
   docker-compose exec backend python manage.py createsuperuser
   ```

---

## ☁️ Deployment (AWS)

The infrastructure is provisioned using **Terraform**.

### Prerequisites
- AWS Access Key & Secret Key
- Terraform installed

### Deploy Steps
1. Navigate to the terraform directory:
   ```bash
   cd terraform
   ```

2. Create `terraform.tfvars` with your credentials:
   ```hcl
   aws_access_key = "YOUR_ACCESS_KEY"
   aws_secret_key = "YOUR_SECRET_KEY"
   ```

3. Init and Apply:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```

4. The output will provide the **IP Address** and **SSH Command**.

---

## 📂 Project Structure

```
├── backend/            # Django Application
│   ├── config/         # Settings (Whitenoise, CORS, Hosts)
│   ├── core/           # API Logic
│   └── Dockerfile      # Multi-stage Python build
├── frontend/           # React Application
│   ├── src/            # Components & API calls
│   └── Dockerfile      # Multi-stage Node + Nginx build
├── terraform/          # IaC Configuration
│   ├── main.tf         # AWS Resources (EC2, VPC, SG)
│   ├── variables.tf    # Configurable variables
│   └── ssh_keys/       # Generated keys (Ignored by Git)
├── .github/            # CI/CD Workflows
└── docker-compose.yml  # Local orchestration
```

---

## ✅ Assessment Checklist

- [x] **Containerization:** Optimized Dockerfiles for Frontend & Backend.
- [x] **Orchestration:** Docker Compose network & volume configuration.
- [x] **CI/CD:** GitHub Actions workflow for automated builds.
- [x] **One-Click Deploy:** Terraform implementation for AWS Free Tier.
- [x] **Security:** Non-root users, Environment variables, Security Groups.

---

## 🔒 Security Notes
- `DEBUG` is disabled in production.
- `SECRET_KEY` is injected via environment variables.
- SSH Access is restricted to key-pair authentication.
