# Cert Manager Terraform Module

This repository contains one-to-one converted versions of
the [Cert Manager](https://github.com/cert-manager/cert-manager) kubectl manifests into
native HCL Terraform format.

## Context

Terraform is a powerful tool for managing infrastructure as code. However, many Kubernetes applications provide their
configurations as kubectl manifests, which cannot be used directly with Terraform. This project converts those
Kubernetes manifests into Terraform configurations, allowing you to manage your Kubernetes resources alongside the rest
of your infrastructure using Terraform.

## Features

* Direct conversions from YAML to HCL
* Organized by version tags
* Easy integration into your Terraform workflows

## Using with Terraform

```hcl
module "cert_manager" {
  source = "git::https://github.com/terraform-please/cert-manager.git//v1.15.3"
}
```

## Using with CDKTF

Update cdktf.json to include the module:

```json
{
  "terraformModules": [
    {
      "name": "cert-manager",
      "source": "git::https://github.com/terraform-please/cert-manager.git//v1.15.3"
    }
  ]
}
```

Then run `cdktf get` to download the module.

Use the module in your Typescript code:

```typescript
import {CertManager} from "@gen/modules/cert-manager";

new CertManager(this, "cert_manager", {
    namespace: "default",
})
```

## Contributing

Feel free to open issues or pull requests for improvements or fixes.
