# Pac-Man Game Deployment on AWS EKS with CI/CD

This project demonstrates a complete CI/CD pipeline for deploying a containerized Pac-Man game on AWS using Amazon EKS, Terraform, and other AWS services. The pipeline is designed to automate the build, test, and deployment processes to ensure a seamless and scalable application deployment.

## 📌 Architecture Overview

![Architecture Diagram](./End%20Pro.drawio.png)

## 🕹️ Gameplay Preview

Here are some screenshots from the deployed Pac-Man game:

### 🟡 Game Start
![Game Screenshot 1](./images/Screenshot%202025-05-23%20110620.png)

### 🟡 Game In Progress
![Game Screenshot 2](./images/Screenshot%202025-05-23%20110654.png)

### Key Components

- **GitHub**: Source code repository. Developers push code changes here.
- **CodePipeline**: Orchestrates the CI/CD process.
- **CodeBuild**: Builds the Docker image from source code and pushes it to ECR.
- **ECR (Elastic Container Registry)**: Stores Docker images used for deployment.
- **Amazon EKS (Elastic Kubernetes Service)**: Hosts the Pac-Man application in a scalable Kubernetes cluster.
- **Terraform**: Manages infrastructure as code for provisioning EKS and related resources.
- **Load Balancer**: Distributes traffic among the Kubernetes pods.
- **Amazon S3**: Stores static assets or game resources.
- **EC2 (t3.medium)**: Worker nodes that run Kubernetes pods.
- **YAML Manifest**: Kubernetes deployment files that define application specs.
- **End Users**: Access the deployed Pac-Man game through the load balancer.

## 🚀 Deployment Process

1. **Code Push**:
   - Developer pushes code to GitHub.

2. **CI/CD Trigger**:
   - CodePipeline is triggered by the GitHub webhook.
   - CodeBuild builds the Docker image.
   - Docker image is pushed to Amazon ECR.
   - Kubernetes manifests are updated (if needed).

3. **Terraform Provisioning**:
   - Infrastructure (EKS, EC2 nodes, S3, etc.) is provisioned using Terraform scripts.

4. **Deployment**:
   - The new image from ECR is deployed to EKS using Kubernetes manifests.
   - Load balancer routes user traffic to the pods running the Pac-Man game.

## ⚙️ Prerequisites

- AWS CLI configured
- kubectl installed and configured
- Terraform installed
- Docker installed
- GitHub account with a repository

## 📁 Directory Structure (suggested)

