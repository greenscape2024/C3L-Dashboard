# PRJ-004 — G-PRJ004-03 Candidate

This branch is a fail-closed candidate for Dashboard 3.0 source-authority hardening and security remediation.

It does not promote unbound sources to VERIFIED and does not modify production/main.

Key artifacts:
- SOURCE_AUTHORITY_REGISTRY.v1.json
- SOURCE_SCHEMAS.v1.json
- SECURITY_AUTH_CONTRACT.v1.json
- G03_ACCEPTANCE_RULES.v1.json
- AUTH_ADAPTER_INTERFACE.v1.js
- RUNTIME_BINDING_STATUS.v1.json

Production promotion remains blocked until runtime source bindings and the same-origin session backend are independently read back and accepted.
