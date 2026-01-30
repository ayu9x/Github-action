# DevOps Assessment - Setup Guide

Complete guide for running locally and deploying to AWS.

---

## 📋 Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| Docker | 20.10+ | Containerization |
| Docker Compose | 2.0+ | Orchestration |
| Git | 2.0+ | Version control |
| Terraform | 1.0+ | Infrastructure (optional) |
| AWS CLI | 2.0+ | Cloud deployment (optional) |

---

## 🚀 Local Development

### Quick Start (Docker)

```bash
# Clone repository
git clone https://github.com/Nexgensis/devops-assessment.git
cd devops-assessment

# Create environment file
cp .env.example .env

# Build and run
docker-compose up -d --build

# View logs
docker-compose logs -f
```

**Access:**
- **Frontend:** [http://localhost:3001](http://localhost:3001) (React App)
- **Backend API:** [http://localhost:8000/api/hello/](http://localhost:8000/api/hello/) (Django API)
- **Django Admin:** [http://localhost:8000/admin/](http://localhost:8000/admin/)

### 🔐 Accessing Django Admin
To log in to the admin panel, you need a superuser account. Create one by running:
```powershell
docker-compose exec backend python manage.py createsuperuser
```
Follow the prompts to set a username and password.

### Stop Services

```bash
docker-compose down
```

---

## 🏭 Production Deployment

### Option 1: Manual Server Setup

```bash
# SSH to your server
ssh user@your-server-ip

# Install Docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone and deploy
git clone https://github.com/Nexgensis/devops-assessment.git
cd devops-assessment
cp .env.example .env
# Edit .env with production values

docker-compose up -d
```

### Option 2: AWS with Terraform

```bash
cd terraform

# Initialize
terraform init

# Preview changes
terraform plan -var="key_name=your-key-pair"

# Deploy (Free Tier: t2.micro)
terraform apply -var="key_name=your-key-pair"

# Get server IP
terraform output instance_public_ip
```

---

## 🔄 CI/CD Setup (GitHub Actions)

### Required Secrets

Add these in GitHub → Settings → Secrets → Actions:

| Secret | Description |
|--------|-------------|
| `DOCKER_USERNAME` | Docker Hub username |
| `DOCKER_TOKEN` | Docker Hub access token |
| `SERVER_HOST` | Server IP for deployment |
| `SERVER_USERNAME` | SSH username (e.g., ec2-user) |
| `SERVER_SSH_KEY` | Private SSH key |

### Enable Deployment

Add repository variable:
- `ENABLE_DEPLOYMENT` = `true`

---

## 🔧 Troubleshooting

### Container Issues

```bash
# Check status
docker-compose ps

# View logs
docker-compose logs backend
docker-compose logs frontend

# Restart services
docker-compose restart
```

### Common Errors

| Error | Solution |
|-------|----------|
| Port 80 in use | `sudo lsof -i :80` then stop the process |
| Backend unhealthy | Check `docker-compose logs backend` |
| Frontend can't reach API | Verify nginx.conf proxy settings |
| Build fails | Clear cache: `docker-compose build --no-cache` |

### Reset Everything

```bash
docker-compose down -v
docker system prune -af
docker-compose up -d --build
```

---

## 📁 Project Structure

```
devops-assessment/
├── backend/
│   ├── Dockerfile          # Multi-stage Alpine build
│   ├── requirements.txt    # Python dependencies
│   └── config/settings.py  # Django settings (env vars)
├── frontend/
│   ├── Dockerfile          # Multi-stage Alpine build
│   └── nginx.conf          # Nginx SPA routing + API proxy
├── terraform/
│   ├── main.tf             # AWS resources (VPC, EC2, SG)
│   ├── variables.tf        # Input variables
│   └── outputs.tf          # Output values
├── .github/workflows/
│   └── deploy.yml          # CI/CD pipeline
├── docker-compose.yml      # Service orchestration
└── .env.example            # Environment template
```

---

## ✅ Verification Checklist

- [ ] Frontend loads at http://localhost
- [ ] "Backend Online" badge shows green
- [ ] "Hello World from Django Backend!" message appears
- [ ] Refresh button works
- [ ] `curl http://localhost:8000/api/hello/` returns JSON
