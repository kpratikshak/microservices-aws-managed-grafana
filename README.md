# microservices-aws-managed-grafana
# Project Overview: This project demonstrates a production-grade observability architecture for microservices running on Amazon EKS. 
The pipeline automates the ingestion of metrics via the Prometheus Operator, secures data transit using AWS SigV4,
and visualizes the Four Golden Signals in a centralized Grafana dashboard.
# # 🏗 Architecture: The architecture follows the "Managed Observability" pattern to reduce operational overhead.
Microservices instrumented with OpenTelemetry and prometheus-client.Collection: Prometheus Operator on EKS scraping metrics and using Remote Write.Security: IAM Roles for Service Accounts (IRSA) providing fine-grained access.Storage: Amazon Managed Prometheus (AMP) for long-term, serverless metric storage.Visualization: Amazon Managed Grafana (AMG) integrated via AWS IAM Identity Center.# 

# 🛠 Tech Stack:
AWS (EKS, AMP, AMG, SNS, IAM), Terraform, Helm , Prometheus Operator, kube-prometheus-stackInstrumentationOpenTelemetry, Python (FastAPI)DashboardsGrafana (PromQL

├── terraform/                # Infrastructure as Code
│   ├── main.tf               # EKS & AMP Workspace
│   ├── grafana.tf            # Managed Grafana & IAM Roles
│   ├── variables.tf          # Configurable inputs
│   └── outputs.tf            # Workspace IDs and Endpoints
├── helm/                     
│   └── values.yaml           # SigV4 & Remote Write configuration
├── app/                      
│   └── main.py               # Instrumented FastAPI Application
└── README.md
🚀 Getting Started

1.Provision InfrastructureInitialize and apply the Terraform configuration to create the EKS cluster and Monitoring Workspaces.Bashcd terraform
terraform init
terraform apply -auto-approve
2. Configure Helm for SigV4Update the helm/values.yaml with your workspace_id and region. 
Then, deploy the monitoring stack:
Bash 
~ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
~ helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring --create-namespace -f helm/values.yaml
3. Deploy the Sample AppDeploy the instrumented Python application to generate custom metrics:
~ kubectl apply -f app/deployment.yaml
