---
name: architecture-design-process
description: Guidelines for cloud architecture design and documentation.
---

# Architecture Design Process Skill

This skill guides you through translating a vision into a production-ready cloud architecture.

## 1. Discovery & Requirements
- Gather functional and non-functional requirements through targeted questioning.
- Summarize requirements and get user approval.

## 2. Service Selection & Rationale
- Favor simple, managed, and serverless architectures.
- For each selected service, document:
  - **Service Name**
  - **Category**
  - **Justification**: Link it to a specific requirement.
  - **Documentation URL**: Official link.

## 3. Visualizing Architecture
- Use MermaidJS for all architecture diagrams.
- Clearly show data flow and component relationships.

## 4. Documentation Structure
Maintain standard architecture files:
- `01_ARCHITECTURE_OVERVIEW.md`: High-level explanation and MermaidJS diagrams.
- `02_COMPONENTS.md`: Deep dive into service configurations and roles.
- `03_DEPLOYMENT_STRATEGY.md`: IaC vs manual instructions and step-by-step guides.
- Convention: Store in `docs/architecture/YYYYMMDD-feature-name/`.
