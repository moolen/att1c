# flux v2 multi-tenancy

Evaluation of tenant-isolation by enforcing `spec.ServiceAccountName` on `Kind=Kustomization` and `Kind=HelmRelease`.

## use-case

Development Teams should have an easy to use self-service interface to register new tenants in a platform. This is a PoC of using a simple helm chart to automate the RBAC/Namespace creation. But onboarding a team usually needs more work. E.g.:
- pin workloads to certain worker-group
- add annotations and labels
- networking segmentation
- monitoring/alerting/logging integration
- generate policies for this particular namespace

```yaml
# this is not implemented, this is a
# rough outline how it could look like
teams:
- namespace: "tenant-a-preview"
  environment: "preview"
  # network segmentation
  network:
    zone: "tenant" # or `system` or `shared-services`
    egress: true # egress traffic is allowed
    sharing: true # allowed to share services with other namespaces
  # alerting configuration
  alerting:
    teams: "http://xxx.yy.zz"
    email:
    - address: oncall@acme.org
      severity: critical
  # monitoring configuration
  monitoring:
    cloudwatch: true
    services: ["RDS"]
  # logging configuration
  logging:
    tenant: "default"
  # OPA/KYVERNO policy generation
  policies:
    allowed_ingress_zone: a.dev.acme.org
  repo:
    url: https://github.com/moolen/att1c-tenant
    path: "./dev/"
```

