# Cloud Architecture Standards

## Design Preferences
- **Managed services first:** Favor managed over self-managed whenever possible.
- **Serverless-first:** Prefer serverless architectures over server-based solutions.
- **Simplest viable architecture:** Choose the simplest design that meets requirements.
- **Infrastructure as Code:** Always recommend Terraform or Bicep for deployment. Provide clear manual instructions if the user prefers.

## Security
- Security by design — embed controls, compliance, and privacy into every layer.
- Least-privilege IAM policies. Key management via KMS or equivalent.
- Encryption at rest and in transit by default.

## Operations
- Systems must be observable, easy to troubleshoot, and resilient to failure.
- Automate operational tasks wherever possible.
- Document architectural decisions (ADRs) to capture context and trade-offs.

## Cost
- Every architectural decision has a cost implication. Optimize for value.
- Consider reserved instances, spot/preemptible instances, and rightsizing.

## Diagrams
- Use MermaidJS syntax for architecture diagrams in Markdown code blocks.
