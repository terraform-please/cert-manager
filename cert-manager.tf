resource "kubernetes_manifest" "customresourcedefinition_clusterissuers_cert_manager_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "clusterissuers.cert-manager.io"
    }
    "spec" = {
      "group" = "cert-manager.io"
      "names" = {
        "categories" = [
          "cert-manager",
        ]
        "kind" = "ClusterIssuer"
        "listKind" = "ClusterIssuerList"
        "plural" = "clusterissuers"
        "singular" = "clusterissuer"
      }
      "scope" = "Cluster"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].status"
              "name" = "Ready"
              "type" = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].message"
              "name" = "Status"
              "priority" = 1
              "type" = "string"
            },
            {
              "description" = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "A ClusterIssuer represents a certificate issuing authority which can be referenced as part of `issuerRef` fields. It is similar to an Issuer, however it is cluster-scoped and therefore can be referenced by resources that exist in *any* namespace, not just the same namespace as the referent."
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "Desired state of the ClusterIssuer resource."
                  "properties" = {
                    "acme" = {
                      "description" = "ACME configures this issuer to communicate with a RFC8555 (ACME) server to obtain signed x509 certificates."
                      "properties" = {
                        "caBundle" = {
                          "description" = "Base64-encoded bundle of PEM CAs which can be used to validate the certificate chain presented by the ACME server. Mutually exclusive with SkipTLSVerify; prefer using CABundle to prevent various kinds of security vulnerabilities. If CABundle and SkipTLSVerify are unset, the system certificate bundle inside the container is used to validate the TLS connection."
                          "format" = "byte"
                          "type" = "string"
                        }
                        "disableAccountKeyGeneration" = {
                          "description" = "Enables or disables generating a new ACME account key. If true, the Issuer resource will *not* request a new account but will expect the account key to be supplied via an existing secret. If false, the cert-manager system will generate a new ACME account key for the Issuer. Defaults to false."
                          "type" = "boolean"
                        }
                        "email" = {
                          "description" = "Email is the email address to be associated with the ACME account. This field is optional, but it is strongly recommended to be set. It will be used to contact you in case of issues with your account or certificates, including expiry notification emails. This field may be updated after the account is initially registered."
                          "type" = "string"
                        }
                        "enableDurationFeature" = {
                          "description" = "Enables requesting a Not After date on certificates that matches the duration of the certificate. This is not supported by all ACME servers like Let's Encrypt. If set to true when the ACME server does not support it it will create an error on the Order. Defaults to false."
                          "type" = "boolean"
                        }
                        "externalAccountBinding" = {
                          "description" = "ExternalAccountBinding is a reference to a CA external account of the ACME server. If set, upon registration cert-manager will attempt to associate the given external account credentials with the registered ACME account."
                          "properties" = {
                            "keyAlgorithm" = {
                              "description" = "Deprecated: keyAlgorithm field exists for historical compatibility reasons and should not be used. The algorithm is now hardcoded to HS256 in golang/x/crypto/acme."
                              "enum" = [
                                "HS256",
                                "HS384",
                                "HS512",
                              ]
                              "type" = "string"
                            }
                            "keyID" = {
                              "description" = "keyID is the ID of the CA key that the External Account is bound to."
                              "type" = "string"
                            }
                            "keySecretRef" = {
                              "description" = "keySecretRef is a Secret Key Selector referencing a data item in a Kubernetes Secret which holds the symmetric MAC key of the External Account Binding. The `key` is the index string that is paired with the key data in the Secret and should not be confused with the key data itself, or indeed with the External Account Binding keyID above. The secret key stored in the Secret **must** be un-padded, base64 URL encoded data."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                          }
                          "required" = [
                            "keyID",
                            "keySecretRef",
                          ]
                          "type" = "object"
                        }
                        "preferredChain" = {
                          "description" = "PreferredChain is the chain to use if the ACME server outputs multiple. PreferredChain is no guarantee that this one gets delivered by the ACME endpoint. For example, for Let's Encrypt's DST crosssign you would use: \"DST Root CA X3\" or \"ISRG Root X1\" for the newer Let's Encrypt root CA. This value picks the first certificate bundle in the ACME alternative chains that has a certificate with this value as its issuer's CN"
                          "maxLength" = 64
                          "type" = "string"
                        }
                        "privateKeySecretRef" = {
                          "description" = "PrivateKey is the name of a Kubernetes Secret resource that will be used to store the automatically generated ACME account private key. Optionally, a `key` may be specified to select a specific entry within the named Secret resource. If `key` is not specified, a default of `tls.key` will be used."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "name",
                          ]
                          "type" = "object"
                        }
                        "server" = {
                          "description" = "Server is the URL used to access the ACME server's 'directory' endpoint. For example, for Let's Encrypt's staging endpoint, you would use: \"https://acme-staging-v02.api.letsencrypt.org/directory\". Only ACME v2 endpoints (i.e. RFC 8555) are supported."
                          "type" = "string"
                        }
                        "skipTLSVerify" = {
                          "description" = "INSECURE: Enables or disables validation of the ACME server TLS certificate. If true, requests to the ACME server will not have the TLS certificate chain validated. Mutually exclusive with CABundle; prefer using CABundle to prevent various kinds of security vulnerabilities. Only enable this option in development environments. If CABundle and SkipTLSVerify are unset, the system certificate bundle inside the container is used to validate the TLS connection. Defaults to false."
                          "type" = "boolean"
                        }
                        "solvers" = {
                          "description" = "Solvers is a list of challenge solvers that will be used to solve ACME challenges for the matching domains. Solver configurations must be provided in order to obtain certificates from an ACME server. For more information, see: https://cert-manager.io/docs/configuration/acme/"
                          "items" = {
                            "description" = "An ACMEChallengeSolver describes how to solve ACME challenges for the issuer it is part of. A selector may be provided to use different solving strategies for different DNS names. Only one of HTTP01 or DNS01 must be provided."
                            "properties" = {
                              "dns01" = {
                                "description" = "Configures cert-manager to attempt to complete authorizations by performing the DNS01 challenge flow."
                                "properties" = {
                                  "acmeDNS" = {
                                    "description" = "Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage DNS01 challenge records."
                                    "properties" = {
                                      "accountSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "host" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "accountSecretRef",
                                      "host",
                                    ]
                                    "type" = "object"
                                  }
                                  "akamai" = {
                                    "description" = "Use the Akamai DNS zone management API to manage DNS01 challenge records."
                                    "properties" = {
                                      "accessTokenSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "clientSecretSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "clientTokenSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "serviceConsumerDomain" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "accessTokenSecretRef",
                                      "clientSecretSecretRef",
                                      "clientTokenSecretRef",
                                      "serviceConsumerDomain",
                                    ]
                                    "type" = "object"
                                  }
                                  "azureDNS" = {
                                    "description" = "Use the Microsoft Azure DNS API to manage DNS01 challenge records."
                                    "properties" = {
                                      "clientID" = {
                                        "description" = "if both this and ClientSecret are left unset MSI will be used"
                                        "type" = "string"
                                      }
                                      "clientSecretSecretRef" = {
                                        "description" = "if both this and ClientID are left unset MSI will be used"
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "environment" = {
                                        "description" = "name of the Azure environment (default AzurePublicCloud)"
                                        "enum" = [
                                          "AzurePublicCloud",
                                          "AzureChinaCloud",
                                          "AzureGermanCloud",
                                          "AzureUSGovernmentCloud",
                                        ]
                                        "type" = "string"
                                      }
                                      "hostedZoneName" = {
                                        "description" = "name of the DNS zone that should be used"
                                        "type" = "string"
                                      }
                                      "managedIdentity" = {
                                        "description" = "managed identity configuration, can not be used at the same time as clientID, clientSecretSecretRef or tenantID"
                                        "properties" = {
                                          "clientID" = {
                                            "description" = "client ID of the managed identity, can not be used at the same time as resourceID"
                                            "type" = "string"
                                          }
                                          "resourceID" = {
                                            "description" = "resource ID of the managed identity, can not be used at the same time as clientID"
                                            "type" = "string"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "resourceGroupName" = {
                                        "description" = "resource group the DNS zone is located in"
                                        "type" = "string"
                                      }
                                      "subscriptionID" = {
                                        "description" = "ID of the Azure subscription"
                                        "type" = "string"
                                      }
                                      "tenantID" = {
                                        "description" = "when specifying ClientID and ClientSecret then this field is also needed"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "resourceGroupName",
                                      "subscriptionID",
                                    ]
                                    "type" = "object"
                                  }
                                  "cloudDNS" = {
                                    "description" = "Use the Google Cloud DNS API to manage DNS01 challenge records."
                                    "properties" = {
                                      "hostedZoneName" = {
                                        "description" = "HostedZoneName is an optional field that tells cert-manager in which Cloud DNS zone the challenge record has to be created. If left empty cert-manager will automatically choose a zone."
                                        "type" = "string"
                                      }
                                      "project" = {
                                        "type" = "string"
                                      }
                                      "serviceAccountSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "project",
                                    ]
                                    "type" = "object"
                                  }
                                  "cloudflare" = {
                                    "description" = "Use the Cloudflare API to manage DNS01 challenge records."
                                    "properties" = {
                                      "apiKeySecretRef" = {
                                        "description" = "API key to use to authenticate with Cloudflare. Note: using an API token to authenticate is now the recommended method as it allows greater control of permissions."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "apiTokenSecretRef" = {
                                        "description" = "API token used to authenticate with Cloudflare."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "email" = {
                                        "description" = "Email of the account, only required when using API key based authentication."
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "cnameStrategy" = {
                                    "description" = "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones."
                                    "enum" = [
                                      "None",
                                      "Follow",
                                    ]
                                    "type" = "string"
                                  }
                                  "digitalocean" = {
                                    "description" = "Use the DigitalOcean DNS API to manage DNS01 challenge records."
                                    "properties" = {
                                      "tokenSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "tokenSecretRef",
                                    ]
                                    "type" = "object"
                                  }
                                  "rfc2136" = {
                                    "description" = "Use RFC2136 (\"Dynamic Updates in the Domain Name System\") (https://datatracker.ietf.org/doc/rfc2136/) to manage DNS01 challenge records."
                                    "properties" = {
                                      "nameserver" = {
                                        "description" = "The IP address or hostname of an authoritative DNS server supporting RFC2136 in the form host:port. If the host is an IPv6 address it must be enclosed in square brackets (e.g [2001:db8::1])\u00a0; port is optional. This field is required."
                                        "type" = "string"
                                      }
                                      "tsigAlgorithm" = {
                                        "description" = "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``."
                                        "type" = "string"
                                      }
                                      "tsigKeyName" = {
                                        "description" = "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required."
                                        "type" = "string"
                                      }
                                      "tsigSecretSecretRef" = {
                                        "description" = "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "nameserver",
                                    ]
                                    "type" = "object"
                                  }
                                  "route53" = {
                                    "description" = "Use the AWS Route53 API to manage DNS01 challenge records."
                                    "properties" = {
                                      "accessKeyID" = {
                                        "description" = "The AccessKeyID is used for authentication. Cannot be set when SecretAccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                        "type" = "string"
                                      }
                                      "accessKeyIDSecretRef" = {
                                        "description" = "The SecretAccessKey is used for authentication. If set, pull the AWS access key ID from a key within a Kubernetes Secret. Cannot be set when AccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "hostedZoneID" = {
                                        "description" = "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call."
                                        "type" = "string"
                                      }
                                      "region" = {
                                        "description" = "Always set the region when using AccessKeyID and SecretAccessKey"
                                        "type" = "string"
                                      }
                                      "role" = {
                                        "description" = "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata"
                                        "type" = "string"
                                      }
                                      "secretAccessKeySecretRef" = {
                                        "description" = "The SecretAccessKey is used for authentication. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "region",
                                    ]
                                    "type" = "object"
                                  }
                                  "webhook" = {
                                    "description" = "Configure an external webhook based DNS01 challenge solver to manage DNS01 challenge records."
                                    "properties" = {
                                      "config" = {
                                        "description" = "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation."
                                        "x-kubernetes-preserve-unknown-fields" = true
                                      }
                                      "groupName" = {
                                        "description" = "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation."
                                        "type" = "string"
                                      }
                                      "solverName" = {
                                        "description" = "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "groupName",
                                      "solverName",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "http01" = {
                                "description" = "Configures cert-manager to attempt to complete authorizations by performing the HTTP01 challenge flow. It is not possible to obtain certificates for wildcard domain names (e.g. `*.example.com`) using the HTTP01 challenge mechanism."
                                "properties" = {
                                  "gatewayHTTPRoute" = {
                                    "description" = "The Gateway API is a sig-network community API that models service networking in Kubernetes (https://gateway-api.sigs.k8s.io/). The Gateway solver will create HTTPRoutes with the specified labels in the same namespace as the challenge. This solver is experimental, and fields / behaviour may change in the future."
                                    "properties" = {
                                      "labels" = {
                                        "additionalProperties" = {
                                          "type" = "string"
                                        }
                                        "description" = "Custom labels that will be applied to HTTPRoutes created by cert-manager while solving HTTP-01 challenges."
                                        "type" = "object"
                                      }
                                      "parentRefs" = {
                                        "description" = "When solving an HTTP-01 challenge, cert-manager creates an HTTPRoute. cert-manager needs to know which parentRefs should be used when creating the HTTPRoute. Usually, the parentRef references a Gateway. See: https://gateway-api.sigs.k8s.io/api-types/httproute/#attaching-to-gateways"
                                        "items" = {
                                          "description" = <<-EOT
                                          ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with "Core" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
                                           The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
                                          EOT
                                          "properties" = {
                                            "group" = {
                                              "default" = "gateway.networking.k8s.io"
                                              "description" = <<-EOT
                                              Group is the group of the referent. When unspecified, "gateway.networking.k8s.io" is inferred. To set the core API group (such as for a "Service" kind referent), Group must be explicitly set to "" (empty string). 
                                               Support: Core
                                              EOT
                                              "maxLength" = 253
                                              "pattern" = "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
                                              "type" = "string"
                                            }
                                            "kind" = {
                                              "default" = "Gateway"
                                              "description" = <<-EOT
                                              Kind is kind of the referent. 
                                               Support: Core (Gateway) 
                                               Support: Implementation-specific (Other Resources)
                                              EOT
                                              "maxLength" = 63
                                              "minLength" = 1
                                              "pattern" = "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
                                              "type" = "string"
                                            }
                                            "name" = {
                                              "description" = <<-EOT
                                              Name is the name of the referent. 
                                               Support: Core
                                              EOT
                                              "maxLength" = 253
                                              "minLength" = 1
                                              "type" = "string"
                                            }
                                            "namespace" = {
                                              "description" = <<-EOT
                                              Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. 
                                               Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. 
                                               Support: Core
                                              EOT
                                              "maxLength" = 63
                                              "minLength" = 1
                                              "pattern" = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
                                              "type" = "string"
                                            }
                                            "port" = {
                                              "description" = <<-EOT
                                              Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. 
                                               When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. 
                                               Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. 
                                               For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
                                               Support: Extended 
                                               <gateway:experimental>
                                              EOT
                                              "format" = "int32"
                                              "maximum" = 65535
                                              "minimum" = 1
                                              "type" = "integer"
                                            }
                                            "sectionName" = {
                                              "description" = <<-EOT
                                              SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
                                               * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
                                               Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
                                               When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
                                               Support: Core
                                              EOT
                                              "maxLength" = 253
                                              "minLength" = 1
                                              "pattern" = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
                                              "type" = "string"
                                            }
                                          }
                                          "required" = [
                                            "name",
                                          ]
                                          "type" = "object"
                                        }
                                        "type" = "array"
                                      }
                                      "serviceType" = {
                                        "description" = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort."
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "ingress" = {
                                    "description" = "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed."
                                    "properties" = {
                                      "class" = {
                                        "description" = "This field configures the annotation `kubernetes.io/ingress.class` when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of `class`, `name` or `ingressClassName` may be specified."
                                        "type" = "string"
                                      }
                                      "ingressClassName" = {
                                        "description" = "This field configures the field `ingressClassName` on the created Ingress resources used to solve ACME challenges that use this challenge solver. This is the recommended way of configuring the ingress class. Only one of `class`, `name` or `ingressClassName` may be specified."
                                        "type" = "string"
                                      }
                                      "ingressTemplate" = {
                                        "description" = "Optional ingress template used to configure the ACME challenge solver ingress used for HTTP01 challenges."
                                        "properties" = {
                                          "metadata" = {
                                            "description" = "ObjectMeta overrides for the ingress used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values."
                                            "properties" = {
                                              "annotations" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Annotations that should be added to the created ACME HTTP01 solver ingress."
                                                "type" = "object"
                                              }
                                              "labels" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Labels that should be added to the created ACME HTTP01 solver ingress."
                                                "type" = "object"
                                              }
                                            }
                                            "type" = "object"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "name" = {
                                        "description" = "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources. Only one of `class`, `name` or `ingressClassName` may be specified."
                                        "type" = "string"
                                      }
                                      "podTemplate" = {
                                        "description" = "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges."
                                        "properties" = {
                                          "metadata" = {
                                            "description" = "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values."
                                            "properties" = {
                                              "annotations" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Annotations that should be added to the create ACME HTTP01 solver pods."
                                                "type" = "object"
                                              }
                                              "labels" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Labels that should be added to the created ACME HTTP01 solver pods."
                                                "type" = "object"
                                              }
                                            }
                                            "type" = "object"
                                          }
                                          "spec" = {
                                            "description" = "PodSpec defines overrides for the HTTP01 challenge solver pod. Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields. All other fields will be ignored."
                                            "properties" = {
                                              "affinity" = {
                                                "description" = "If specified, the pod's scheduling constraints"
                                                "properties" = {
                                                  "nodeAffinity" = {
                                                    "description" = "Describes node affinity scheduling rules for the pod."
                                                    "properties" = {
                                                      "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
                                                        "items" = {
                                                          "description" = "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
                                                          "properties" = {
                                                            "preference" = {
                                                              "description" = "A node selector term, associated with the corresponding weight."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "A list of node selector requirements by node's labels."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchFields" = {
                                                                  "description" = "A list of node selector requirements by node's fields."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "weight" = {
                                                              "description" = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
                                                              "format" = "int32"
                                                              "type" = "integer"
                                                            }
                                                          }
                                                          "required" = [
                                                            "preference",
                                                            "weight",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
                                                        "properties" = {
                                                          "nodeSelectorTerms" = {
                                                            "description" = "Required. A list of node selector terms. The terms are ORed."
                                                            "items" = {
                                                              "description" = "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "A list of node selector requirements by node's labels."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchFields" = {
                                                                  "description" = "A list of node selector requirements by node's fields."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "type" = "array"
                                                          }
                                                        }
                                                        "required" = [
                                                          "nodeSelectorTerms",
                                                        ]
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                    }
                                                    "type" = "object"
                                                  }
                                                  "podAffinity" = {
                                                    "description" = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
                                                    "properties" = {
                                                      "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
                                                        "items" = {
                                                          "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                                          "properties" = {
                                                            "podAffinityTerm" = {
                                                              "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                                              "properties" = {
                                                                "labelSelector" = {
                                                                  "description" = "A label query over a set of resources, in this case pods."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaceSelector" = {
                                                                  "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaces" = {
                                                                  "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "topologyKey" = {
                                                                  "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                                  "type" = "string"
                                                                }
                                                              }
                                                              "required" = [
                                                                "topologyKey",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "weight" = {
                                                              "description" = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
                                                              "format" = "int32"
                                                              "type" = "integer"
                                                            }
                                                          }
                                                          "required" = [
                                                            "podAffinityTerm",
                                                            "weight",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
                                                        "items" = {
                                                          "description" = "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
                                                          "properties" = {
                                                            "labelSelector" = {
                                                              "description" = "A label query over a set of resources, in this case pods."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaceSelector" = {
                                                              "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaces" = {
                                                              "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                              "items" = {
                                                                "type" = "string"
                                                              }
                                                              "type" = "array"
                                                            }
                                                            "topologyKey" = {
                                                              "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                              "type" = "string"
                                                            }
                                                          }
                                                          "required" = [
                                                            "topologyKey",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                    }
                                                    "type" = "object"
                                                  }
                                                  "podAntiAffinity" = {
                                                    "description" = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
                                                    "properties" = {
                                                      "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
                                                        "items" = {
                                                          "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                                          "properties" = {
                                                            "podAffinityTerm" = {
                                                              "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                                              "properties" = {
                                                                "labelSelector" = {
                                                                  "description" = "A label query over a set of resources, in this case pods."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaceSelector" = {
                                                                  "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaces" = {
                                                                  "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "topologyKey" = {
                                                                  "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                                  "type" = "string"
                                                                }
                                                              }
                                                              "required" = [
                                                                "topologyKey",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "weight" = {
                                                              "description" = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
                                                              "format" = "int32"
                                                              "type" = "integer"
                                                            }
                                                          }
                                                          "required" = [
                                                            "podAffinityTerm",
                                                            "weight",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
                                                        "items" = {
                                                          "description" = "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
                                                          "properties" = {
                                                            "labelSelector" = {
                                                              "description" = "A label query over a set of resources, in this case pods."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaceSelector" = {
                                                              "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaces" = {
                                                              "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                              "items" = {
                                                                "type" = "string"
                                                              }
                                                              "type" = "array"
                                                            }
                                                            "topologyKey" = {
                                                              "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                              "type" = "string"
                                                            }
                                                          }
                                                          "required" = [
                                                            "topologyKey",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                    }
                                                    "type" = "object"
                                                  }
                                                }
                                                "type" = "object"
                                              }
                                              "imagePullSecrets" = {
                                                "description" = "If specified, the pod's imagePullSecrets"
                                                "items" = {
                                                  "description" = "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
                                                  "properties" = {
                                                    "name" = {
                                                      "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                                      "type" = "string"
                                                    }
                                                  }
                                                  "type" = "object"
                                                  "x-kubernetes-map-type" = "atomic"
                                                }
                                                "type" = "array"
                                              }
                                              "nodeSelector" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"
                                                "type" = "object"
                                              }
                                              "priorityClassName" = {
                                                "description" = "If specified, the pod's priorityClassName."
                                                "type" = "string"
                                              }
                                              "serviceAccountName" = {
                                                "description" = "If specified, the pod's service account"
                                                "type" = "string"
                                              }
                                              "tolerations" = {
                                                "description" = "If specified, the pod's tolerations."
                                                "items" = {
                                                  "description" = "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
                                                  "properties" = {
                                                    "effect" = {
                                                      "description" = "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
                                                      "type" = "string"
                                                    }
                                                    "key" = {
                                                      "description" = "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
                                                      "type" = "string"
                                                    }
                                                    "operator" = {
                                                      "description" = "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
                                                      "type" = "string"
                                                    }
                                                    "tolerationSeconds" = {
                                                      "description" = "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
                                                      "format" = "int64"
                                                      "type" = "integer"
                                                    }
                                                    "value" = {
                                                      "description" = "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
                                                      "type" = "string"
                                                    }
                                                  }
                                                  "type" = "object"
                                                }
                                                "type" = "array"
                                              }
                                            }
                                            "type" = "object"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "serviceType" = {
                                        "description" = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort."
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "selector" = {
                                "description" = "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver. If not specified, the solver will be treated as the 'default' solver with the lowest priority, i.e. if any other solver has a more specific match, it will be used instead."
                                "properties" = {
                                  "dnsNames" = {
                                    "description" = "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected."
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "dnsZones" = {
                                    "description" = "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected."
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "matchLabels" = {
                                    "additionalProperties" = {
                                      "type" = "string"
                                    }
                                    "description" = "A label selector that is used to refine the set of certificate's that this challenge solver will apply to."
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                      }
                      "required" = [
                        "privateKeySecretRef",
                        "server",
                      ]
                      "type" = "object"
                    }
                    "ca" = {
                      "description" = "CA configures this issuer to sign certificates using a signing CA keypair stored in a Secret resource. This is used to build internal PKIs that are managed by cert-manager."
                      "properties" = {
                        "crlDistributionPoints" = {
                          "description" = "The CRL distribution points is an X.509 v3 certificate extension which identifies the location of the CRL from which the revocation of this certificate can be checked. If not set, certificates will be issued without distribution points set."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "ocspServers" = {
                          "description" = "The OCSP server list is an X.509 v3 extension that defines a list of URLs of OCSP responders. The OCSP responders can be queried for the revocation status of an issued certificate. If not set, the certificate will be issued with no OCSP servers set. For example, an OCSP server URL could be \"http://ocsp.int-x3.letsencrypt.org\"."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "secretName" = {
                          "description" = "SecretName is the name of the secret used to sign Certificates issued by this Issuer."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "secretName",
                      ]
                      "type" = "object"
                    }
                    "selfSigned" = {
                      "description" = "SelfSigned configures this issuer to 'self sign' certificates using the private key used to create the CertificateRequest object."
                      "properties" = {
                        "crlDistributionPoints" = {
                          "description" = "The CRL distribution points is an X.509 v3 certificate extension which identifies the location of the CRL from which the revocation of this certificate can be checked. If not set certificate will be issued without CDP. Values are strings."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                      }
                      "type" = "object"
                    }
                    "vault" = {
                      "description" = "Vault configures this issuer to sign certificates using a HashiCorp Vault PKI backend."
                      "properties" = {
                        "auth" = {
                          "description" = "Auth configures how cert-manager authenticates with the Vault server."
                          "properties" = {
                            "appRole" = {
                              "description" = "AppRole authenticates with Vault using the App Role auth mechanism, with the role and secret stored in a Kubernetes Secret resource."
                              "properties" = {
                                "path" = {
                                  "description" = "Path where the App Role authentication backend is mounted in Vault, e.g: \"approle\""
                                  "type" = "string"
                                }
                                "roleId" = {
                                  "description" = "RoleID configured in the App Role authentication backend when setting up the authentication backend in Vault."
                                  "type" = "string"
                                }
                                "secretRef" = {
                                  "description" = "Reference to a key in a Secret that contains the App Role secret used to authenticate with Vault. The `key` field must be specified and denotes which entry within the Secret resource is used as the app role secret."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "path",
                                "roleId",
                                "secretRef",
                              ]
                              "type" = "object"
                            }
                            "kubernetes" = {
                              "description" = "Kubernetes authenticates with Vault by passing the ServiceAccount token stored in the named Secret resource to the Vault server."
                              "properties" = {
                                "mountPath" = {
                                  "description" = "The Vault mountPath here is the mount path to use when authenticating with Vault. For example, setting a value to `/v1/auth/foo`, will use the path `/v1/auth/foo/login` to authenticate with Vault. If unspecified, the default value \"/v1/auth/kubernetes\" will be used."
                                  "type" = "string"
                                }
                                "role" = {
                                  "description" = "A required field containing the Vault Role to assume. A Role binds a Kubernetes ServiceAccount with a set of Vault policies."
                                  "type" = "string"
                                }
                                "secretRef" = {
                                  "description" = "The required Secret field containing a Kubernetes ServiceAccount JWT used for authenticating with Vault. Use of 'ambient credentials' is not supported."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "serviceAccountRef" = {
                                  "description" = "A reference to a service account that will be used to request a bound token (also known as \"projected token\"). Compared to using \"secretRef\", using this field means that you don't rely on statically bound tokens. To use this field, you must configure an RBAC rule to let cert-manager request a token."
                                  "properties" = {
                                    "name" = {
                                      "description" = "Name of the ServiceAccount used to request a token."
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "role",
                              ]
                              "type" = "object"
                            }
                            "tokenSecretRef" = {
                              "description" = "TokenSecretRef authenticates with Vault by presenting a token."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                          }
                          "type" = "object"
                        }
                        "caBundle" = {
                          "description" = "Base64-encoded bundle of PEM CAs which will be used to validate the certificate chain presented by Vault. Only used if using HTTPS to connect to Vault and ignored for HTTP connections. Mutually exclusive with CABundleSecretRef. If neither CABundle nor CABundleSecretRef are defined, the certificate bundle in the cert-manager controller container is used to validate the TLS connection."
                          "format" = "byte"
                          "type" = "string"
                        }
                        "caBundleSecretRef" = {
                          "description" = "Reference to a Secret containing a bundle of PEM-encoded CAs to use when verifying the certificate chain presented by Vault when using HTTPS. Mutually exclusive with CABundle. If neither CABundle nor CABundleSecretRef are defined, the certificate bundle in the cert-manager controller container is used to validate the TLS connection. If no key for the Secret is specified, cert-manager will default to 'ca.crt'."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "name",
                          ]
                          "type" = "object"
                        }
                        "namespace" = {
                          "description" = "Name of the vault namespace. Namespaces is a set of features within Vault Enterprise that allows Vault environments to support Secure Multi-tenancy. e.g: \"ns1\" More about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces"
                          "type" = "string"
                        }
                        "path" = {
                          "description" = "Path is the mount path of the Vault PKI backend's `sign` endpoint, e.g: \"my_pki_mount/sign/my-role-name\"."
                          "type" = "string"
                        }
                        "server" = {
                          "description" = "Server is the connection address for the Vault server, e.g: \"https://vault.example.com:8200\"."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "auth",
                        "path",
                        "server",
                      ]
                      "type" = "object"
                    }
                    "venafi" = {
                      "description" = "Venafi configures this issuer to sign certificates using a Venafi TPP or Venafi Cloud policy zone."
                      "properties" = {
                        "cloud" = {
                          "description" = "Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified."
                          "properties" = {
                            "apiTokenSecretRef" = {
                              "description" = "APITokenSecretRef is a secret key selector for the Venafi Cloud API token."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "url" = {
                              "description" = "URL is the base URL for Venafi Cloud. Defaults to \"https://api.venafi.cloud/v1\"."
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "apiTokenSecretRef",
                          ]
                          "type" = "object"
                        }
                        "tpp" = {
                          "description" = "TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified."
                          "properties" = {
                            "caBundle" = {
                              "description" = "Base64-encoded bundle of PEM CAs which will be used to validate the certificate chain presented by the TPP server. Only used if using HTTPS; ignored for HTTP. If undefined, the certificate bundle in the cert-manager controller container is used to validate the chain."
                              "format" = "byte"
                              "type" = "string"
                            }
                            "credentialsRef" = {
                              "description" = "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'."
                              "properties" = {
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "url" = {
                              "description" = "URL is the base URL for the vedsdk endpoint of the Venafi TPP instance, for example: \"https://tpp.example.com/vedsdk\"."
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "credentialsRef",
                            "url",
                          ]
                          "type" = "object"
                        }
                        "zone" = {
                          "description" = "Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "zone",
                      ]
                      "type" = "object"
                    }
                  }
                  "type" = "object"
                }
                "status" = {
                  "description" = "Status of the ClusterIssuer. This is set and managed automatically."
                  "properties" = {
                    "acme" = {
                      "description" = "ACME specific status options. This field should only be set if the Issuer is configured to use an ACME server to issue certificates."
                      "properties" = {
                        "lastPrivateKeyHash" = {
                          "description" = "LastPrivateKeyHash is a hash of the private key associated with the latest registered ACME account, in order to track changes made to registered account associated with the Issuer"
                          "type" = "string"
                        }
                        "lastRegisteredEmail" = {
                          "description" = "LastRegisteredEmail is the email associated with the latest registered ACME account, in order to track changes made to registered account associated with the  Issuer"
                          "type" = "string"
                        }
                        "uri" = {
                          "description" = "URI is the unique account identifier, which can also be used to retrieve account details from the CA"
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "conditions" = {
                      "description" = "List of status conditions to indicate the status of a CertificateRequest. Known condition types are `Ready`."
                      "items" = {
                        "description" = "IssuerCondition contains condition information for an Issuer."
                        "properties" = {
                          "lastTransitionTime" = {
                            "description" = "LastTransitionTime is the timestamp corresponding to the last status change of this condition."
                            "format" = "date-time"
                            "type" = "string"
                          }
                          "message" = {
                            "description" = "Message is a human readable description of the details of the last transition, complementing reason."
                            "type" = "string"
                          }
                          "observedGeneration" = {
                            "description" = "If set, this represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.condition[x].observedGeneration is 9, the condition is out of date with respect to the current state of the Issuer."
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "reason" = {
                            "description" = "Reason is a brief machine readable explanation for the condition's last transition."
                            "type" = "string"
                          }
                          "status" = {
                            "description" = "Status of the condition, one of (`True`, `False`, `Unknown`)."
                            "enum" = [
                              "True",
                              "False",
                              "Unknown",
                            ]
                            "type" = "string"
                          }
                          "type" = {
                            "description" = "Type of the condition, known values are (`Ready`)."
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "status",
                          "type",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "type",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
resource "kubernetes_manifest" "customresourcedefinition_challenges_acme_cert_manager_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "challenges.acme.cert-manager.io"
    }
    "spec" = {
      "group" = "acme.cert-manager.io"
      "names" = {
        "categories" = [
          "cert-manager",
          "cert-manager-acme",
        ]
        "kind" = "Challenge"
        "listKind" = "ChallengeList"
        "plural" = "challenges"
        "singular" = "challenge"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".status.state"
              "name" = "State"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.dnsName"
              "name" = "Domain"
              "type" = "string"
            },
            {
              "jsonPath" = ".status.reason"
              "name" = "Reason"
              "priority" = 1
              "type" = "string"
            },
            {
              "description" = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "Challenge is a type to represent a Challenge request with an ACME server"
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "properties" = {
                    "authorizationURL" = {
                      "description" = "The URL to the ACME Authorization resource that this challenge is a part of."
                      "type" = "string"
                    }
                    "dnsName" = {
                      "description" = "dnsName is the identifier that this challenge is for, e.g. example.com. If the requested DNSName is a 'wildcard', this field MUST be set to the non-wildcard domain, e.g. for `*.example.com`, it must be `example.com`."
                      "type" = "string"
                    }
                    "issuerRef" = {
                      "description" = "References a properly configured ACME-type Issuer which should be used to create this Challenge. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Challenge will be marked as failed."
                      "properties" = {
                        "group" = {
                          "description" = "Group of the resource being referred to."
                          "type" = "string"
                        }
                        "kind" = {
                          "description" = "Kind of the resource being referred to."
                          "type" = "string"
                        }
                        "name" = {
                          "description" = "Name of the resource being referred to."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "name",
                      ]
                      "type" = "object"
                    }
                    "key" = {
                      "description" = "The ACME challenge key for this challenge For HTTP01 challenges, this is the value that must be responded with to complete the HTTP01 challenge in the format: `<private key JWK thumbprint>.<key from acme server for challenge>`. For DNS01 challenges, this is the base64 encoded SHA256 sum of the `<private key JWK thumbprint>.<key from acme server for challenge>` text that must be set as the TXT record content."
                      "type" = "string"
                    }
                    "solver" = {
                      "description" = "Contains the domain solving configuration that should be used to solve this challenge resource."
                      "properties" = {
                        "dns01" = {
                          "description" = "Configures cert-manager to attempt to complete authorizations by performing the DNS01 challenge flow."
                          "properties" = {
                            "acmeDNS" = {
                              "description" = "Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage DNS01 challenge records."
                              "properties" = {
                                "accountSecretRef" = {
                                  "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "host" = {
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "accountSecretRef",
                                "host",
                              ]
                              "type" = "object"
                            }
                            "akamai" = {
                              "description" = "Use the Akamai DNS zone management API to manage DNS01 challenge records."
                              "properties" = {
                                "accessTokenSecretRef" = {
                                  "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "clientSecretSecretRef" = {
                                  "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "clientTokenSecretRef" = {
                                  "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "serviceConsumerDomain" = {
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "accessTokenSecretRef",
                                "clientSecretSecretRef",
                                "clientTokenSecretRef",
                                "serviceConsumerDomain",
                              ]
                              "type" = "object"
                            }
                            "azureDNS" = {
                              "description" = "Use the Microsoft Azure DNS API to manage DNS01 challenge records."
                              "properties" = {
                                "clientID" = {
                                  "description" = "if both this and ClientSecret are left unset MSI will be used"
                                  "type" = "string"
                                }
                                "clientSecretSecretRef" = {
                                  "description" = "if both this and ClientID are left unset MSI will be used"
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "environment" = {
                                  "description" = "name of the Azure environment (default AzurePublicCloud)"
                                  "enum" = [
                                    "AzurePublicCloud",
                                    "AzureChinaCloud",
                                    "AzureGermanCloud",
                                    "AzureUSGovernmentCloud",
                                  ]
                                  "type" = "string"
                                }
                                "hostedZoneName" = {
                                  "description" = "name of the DNS zone that should be used"
                                  "type" = "string"
                                }
                                "managedIdentity" = {
                                  "description" = "managed identity configuration, can not be used at the same time as clientID, clientSecretSecretRef or tenantID"
                                  "properties" = {
                                    "clientID" = {
                                      "description" = "client ID of the managed identity, can not be used at the same time as resourceID"
                                      "type" = "string"
                                    }
                                    "resourceID" = {
                                      "description" = "resource ID of the managed identity, can not be used at the same time as clientID"
                                      "type" = "string"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "resourceGroupName" = {
                                  "description" = "resource group the DNS zone is located in"
                                  "type" = "string"
                                }
                                "subscriptionID" = {
                                  "description" = "ID of the Azure subscription"
                                  "type" = "string"
                                }
                                "tenantID" = {
                                  "description" = "when specifying ClientID and ClientSecret then this field is also needed"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "resourceGroupName",
                                "subscriptionID",
                              ]
                              "type" = "object"
                            }
                            "cloudDNS" = {
                              "description" = "Use the Google Cloud DNS API to manage DNS01 challenge records."
                              "properties" = {
                                "hostedZoneName" = {
                                  "description" = "HostedZoneName is an optional field that tells cert-manager in which Cloud DNS zone the challenge record has to be created. If left empty cert-manager will automatically choose a zone."
                                  "type" = "string"
                                }
                                "project" = {
                                  "type" = "string"
                                }
                                "serviceAccountSecretRef" = {
                                  "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "project",
                              ]
                              "type" = "object"
                            }
                            "cloudflare" = {
                              "description" = "Use the Cloudflare API to manage DNS01 challenge records."
                              "properties" = {
                                "apiKeySecretRef" = {
                                  "description" = "API key to use to authenticate with Cloudflare. Note: using an API token to authenticate is now the recommended method as it allows greater control of permissions."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "apiTokenSecretRef" = {
                                  "description" = "API token used to authenticate with Cloudflare."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "email" = {
                                  "description" = "Email of the account, only required when using API key based authentication."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "cnameStrategy" = {
                              "description" = "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones."
                              "enum" = [
                                "None",
                                "Follow",
                              ]
                              "type" = "string"
                            }
                            "digitalocean" = {
                              "description" = "Use the DigitalOcean DNS API to manage DNS01 challenge records."
                              "properties" = {
                                "tokenSecretRef" = {
                                  "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "tokenSecretRef",
                              ]
                              "type" = "object"
                            }
                            "rfc2136" = {
                              "description" = "Use RFC2136 (\"Dynamic Updates in the Domain Name System\") (https://datatracker.ietf.org/doc/rfc2136/) to manage DNS01 challenge records."
                              "properties" = {
                                "nameserver" = {
                                  "description" = "The IP address or hostname of an authoritative DNS server supporting RFC2136 in the form host:port. If the host is an IPv6 address it must be enclosed in square brackets (e.g [2001:db8::1])\u00a0; port is optional. This field is required."
                                  "type" = "string"
                                }
                                "tsigAlgorithm" = {
                                  "description" = "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``."
                                  "type" = "string"
                                }
                                "tsigKeyName" = {
                                  "description" = "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required."
                                  "type" = "string"
                                }
                                "tsigSecretSecretRef" = {
                                  "description" = "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "nameserver",
                              ]
                              "type" = "object"
                            }
                            "route53" = {
                              "description" = "Use the AWS Route53 API to manage DNS01 challenge records."
                              "properties" = {
                                "accessKeyID" = {
                                  "description" = "The AccessKeyID is used for authentication. Cannot be set when SecretAccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                  "type" = "string"
                                }
                                "accessKeyIDSecretRef" = {
                                  "description" = "The SecretAccessKey is used for authentication. If set, pull the AWS access key ID from a key within a Kubernetes Secret. Cannot be set when AccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "hostedZoneID" = {
                                  "description" = "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call."
                                  "type" = "string"
                                }
                                "region" = {
                                  "description" = "Always set the region when using AccessKeyID and SecretAccessKey"
                                  "type" = "string"
                                }
                                "role" = {
                                  "description" = "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata"
                                  "type" = "string"
                                }
                                "secretAccessKeySecretRef" = {
                                  "description" = "The SecretAccessKey is used for authentication. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "region",
                              ]
                              "type" = "object"
                            }
                            "webhook" = {
                              "description" = "Configure an external webhook based DNS01 challenge solver to manage DNS01 challenge records."
                              "properties" = {
                                "config" = {
                                  "description" = "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation."
                                  "x-kubernetes-preserve-unknown-fields" = true
                                }
                                "groupName" = {
                                  "description" = "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation."
                                  "type" = "string"
                                }
                                "solverName" = {
                                  "description" = "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'."
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "groupName",
                                "solverName",
                              ]
                              "type" = "object"
                            }
                          }
                          "type" = "object"
                        }
                        "http01" = {
                          "description" = "Configures cert-manager to attempt to complete authorizations by performing the HTTP01 challenge flow. It is not possible to obtain certificates for wildcard domain names (e.g. `*.example.com`) using the HTTP01 challenge mechanism."
                          "properties" = {
                            "gatewayHTTPRoute" = {
                              "description" = "The Gateway API is a sig-network community API that models service networking in Kubernetes (https://gateway-api.sigs.k8s.io/). The Gateway solver will create HTTPRoutes with the specified labels in the same namespace as the challenge. This solver is experimental, and fields / behaviour may change in the future."
                              "properties" = {
                                "labels" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "Custom labels that will be applied to HTTPRoutes created by cert-manager while solving HTTP-01 challenges."
                                  "type" = "object"
                                }
                                "parentRefs" = {
                                  "description" = "When solving an HTTP-01 challenge, cert-manager creates an HTTPRoute. cert-manager needs to know which parentRefs should be used when creating the HTTPRoute. Usually, the parentRef references a Gateway. See: https://gateway-api.sigs.k8s.io/api-types/httproute/#attaching-to-gateways"
                                  "items" = {
                                    "description" = <<-EOT
                                    ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with "Core" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
                                     The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
                                    EOT
                                    "properties" = {
                                      "group" = {
                                        "default" = "gateway.networking.k8s.io"
                                        "description" = <<-EOT
                                        Group is the group of the referent. When unspecified, "gateway.networking.k8s.io" is inferred. To set the core API group (such as for a "Service" kind referent), Group must be explicitly set to "" (empty string). 
                                         Support: Core
                                        EOT
                                        "maxLength" = 253
                                        "pattern" = "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
                                        "type" = "string"
                                      }
                                      "kind" = {
                                        "default" = "Gateway"
                                        "description" = <<-EOT
                                        Kind is kind of the referent. 
                                         Support: Core (Gateway) 
                                         Support: Implementation-specific (Other Resources)
                                        EOT
                                        "maxLength" = 63
                                        "minLength" = 1
                                        "pattern" = "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = <<-EOT
                                        Name is the name of the referent. 
                                         Support: Core
                                        EOT
                                        "maxLength" = 253
                                        "minLength" = 1
                                        "type" = "string"
                                      }
                                      "namespace" = {
                                        "description" = <<-EOT
                                        Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. 
                                         Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. 
                                         Support: Core
                                        EOT
                                        "maxLength" = 63
                                        "minLength" = 1
                                        "pattern" = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "description" = <<-EOT
                                        Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. 
                                         When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. 
                                         Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. 
                                         For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
                                         Support: Extended 
                                         <gateway:experimental>
                                        EOT
                                        "format" = "int32"
                                        "maximum" = 65535
                                        "minimum" = 1
                                        "type" = "integer"
                                      }
                                      "sectionName" = {
                                        "description" = <<-EOT
                                        SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
                                         * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
                                         Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
                                         When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
                                         Support: Core
                                        EOT
                                        "maxLength" = 253
                                        "minLength" = 1
                                        "pattern" = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "name",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "serviceType" = {
                                  "description" = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "ingress" = {
                              "description" = "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed."
                              "properties" = {
                                "class" = {
                                  "description" = "This field configures the annotation `kubernetes.io/ingress.class` when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of `class`, `name` or `ingressClassName` may be specified."
                                  "type" = "string"
                                }
                                "ingressClassName" = {
                                  "description" = "This field configures the field `ingressClassName` on the created Ingress resources used to solve ACME challenges that use this challenge solver. This is the recommended way of configuring the ingress class. Only one of `class`, `name` or `ingressClassName` may be specified."
                                  "type" = "string"
                                }
                                "ingressTemplate" = {
                                  "description" = "Optional ingress template used to configure the ACME challenge solver ingress used for HTTP01 challenges."
                                  "properties" = {
                                    "metadata" = {
                                      "description" = "ObjectMeta overrides for the ingress used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values."
                                      "properties" = {
                                        "annotations" = {
                                          "additionalProperties" = {
                                            "type" = "string"
                                          }
                                          "description" = "Annotations that should be added to the created ACME HTTP01 solver ingress."
                                          "type" = "object"
                                        }
                                        "labels" = {
                                          "additionalProperties" = {
                                            "type" = "string"
                                          }
                                          "description" = "Labels that should be added to the created ACME HTTP01 solver ingress."
                                          "type" = "object"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "name" = {
                                  "description" = "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources. Only one of `class`, `name` or `ingressClassName` may be specified."
                                  "type" = "string"
                                }
                                "podTemplate" = {
                                  "description" = "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges."
                                  "properties" = {
                                    "metadata" = {
                                      "description" = "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values."
                                      "properties" = {
                                        "annotations" = {
                                          "additionalProperties" = {
                                            "type" = "string"
                                          }
                                          "description" = "Annotations that should be added to the create ACME HTTP01 solver pods."
                                          "type" = "object"
                                        }
                                        "labels" = {
                                          "additionalProperties" = {
                                            "type" = "string"
                                          }
                                          "description" = "Labels that should be added to the created ACME HTTP01 solver pods."
                                          "type" = "object"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                    "spec" = {
                                      "description" = "PodSpec defines overrides for the HTTP01 challenge solver pod. Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields. All other fields will be ignored."
                                      "properties" = {
                                        "affinity" = {
                                          "description" = "If specified, the pod's scheduling constraints"
                                          "properties" = {
                                            "nodeAffinity" = {
                                              "description" = "Describes node affinity scheduling rules for the pod."
                                              "properties" = {
                                                "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                  "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
                                                  "items" = {
                                                    "description" = "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
                                                    "properties" = {
                                                      "preference" = {
                                                        "description" = "A node selector term, associated with the corresponding weight."
                                                        "properties" = {
                                                          "matchExpressions" = {
                                                            "description" = "A list of node selector requirements by node's labels."
                                                            "items" = {
                                                              "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "The label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "matchFields" = {
                                                            "description" = "A list of node selector requirements by node's fields."
                                                            "items" = {
                                                              "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "The label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                        }
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                      "weight" = {
                                                        "description" = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
                                                        "format" = "int32"
                                                        "type" = "integer"
                                                      }
                                                    }
                                                    "required" = [
                                                      "preference",
                                                      "weight",
                                                    ]
                                                    "type" = "object"
                                                  }
                                                  "type" = "array"
                                                }
                                                "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                  "description" = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
                                                  "properties" = {
                                                    "nodeSelectorTerms" = {
                                                      "description" = "Required. A list of node selector terms. The terms are ORed."
                                                      "items" = {
                                                        "description" = "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
                                                        "properties" = {
                                                          "matchExpressions" = {
                                                            "description" = "A list of node selector requirements by node's labels."
                                                            "items" = {
                                                              "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "The label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "matchFields" = {
                                                            "description" = "A list of node selector requirements by node's fields."
                                                            "items" = {
                                                              "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "The label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                        }
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                      "type" = "array"
                                                    }
                                                  }
                                                  "required" = [
                                                    "nodeSelectorTerms",
                                                  ]
                                                  "type" = "object"
                                                  "x-kubernetes-map-type" = "atomic"
                                                }
                                              }
                                              "type" = "object"
                                            }
                                            "podAffinity" = {
                                              "description" = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
                                              "properties" = {
                                                "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                  "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
                                                  "items" = {
                                                    "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                                    "properties" = {
                                                      "podAffinityTerm" = {
                                                        "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                                        "properties" = {
                                                          "labelSelector" = {
                                                            "description" = "A label query over a set of resources, in this case pods."
                                                            "properties" = {
                                                              "matchExpressions" = {
                                                                "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                "items" = {
                                                                  "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                  "properties" = {
                                                                    "key" = {
                                                                      "description" = "key is the label key that the selector applies to."
                                                                      "type" = "string"
                                                                    }
                                                                    "operator" = {
                                                                      "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                      "type" = "string"
                                                                    }
                                                                    "values" = {
                                                                      "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                      "items" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                  }
                                                                  "required" = [
                                                                    "key",
                                                                    "operator",
                                                                  ]
                                                                  "type" = "object"
                                                                }
                                                                "type" = "array"
                                                              }
                                                              "matchLabels" = {
                                                                "additionalProperties" = {
                                                                  "type" = "string"
                                                                }
                                                                "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                "type" = "object"
                                                              }
                                                            }
                                                            "type" = "object"
                                                            "x-kubernetes-map-type" = "atomic"
                                                          }
                                                          "namespaceSelector" = {
                                                            "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                            "properties" = {
                                                              "matchExpressions" = {
                                                                "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                "items" = {
                                                                  "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                  "properties" = {
                                                                    "key" = {
                                                                      "description" = "key is the label key that the selector applies to."
                                                                      "type" = "string"
                                                                    }
                                                                    "operator" = {
                                                                      "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                      "type" = "string"
                                                                    }
                                                                    "values" = {
                                                                      "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                      "items" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                  }
                                                                  "required" = [
                                                                    "key",
                                                                    "operator",
                                                                  ]
                                                                  "type" = "object"
                                                                }
                                                                "type" = "array"
                                                              }
                                                              "matchLabels" = {
                                                                "additionalProperties" = {
                                                                  "type" = "string"
                                                                }
                                                                "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                "type" = "object"
                                                              }
                                                            }
                                                            "type" = "object"
                                                            "x-kubernetes-map-type" = "atomic"
                                                          }
                                                          "namespaces" = {
                                                            "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                            "items" = {
                                                              "type" = "string"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "topologyKey" = {
                                                            "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                            "type" = "string"
                                                          }
                                                        }
                                                        "required" = [
                                                          "topologyKey",
                                                        ]
                                                        "type" = "object"
                                                      }
                                                      "weight" = {
                                                        "description" = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
                                                        "format" = "int32"
                                                        "type" = "integer"
                                                      }
                                                    }
                                                    "required" = [
                                                      "podAffinityTerm",
                                                      "weight",
                                                    ]
                                                    "type" = "object"
                                                  }
                                                  "type" = "array"
                                                }
                                                "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                  "description" = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
                                                  "items" = {
                                                    "description" = "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
                                                    "properties" = {
                                                      "labelSelector" = {
                                                        "description" = "A label query over a set of resources, in this case pods."
                                                        "properties" = {
                                                          "matchExpressions" = {
                                                            "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                            "items" = {
                                                              "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "key is the label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "matchLabels" = {
                                                            "additionalProperties" = {
                                                              "type" = "string"
                                                            }
                                                            "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                            "type" = "object"
                                                          }
                                                        }
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                      "namespaceSelector" = {
                                                        "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                        "properties" = {
                                                          "matchExpressions" = {
                                                            "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                            "items" = {
                                                              "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "key is the label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "matchLabels" = {
                                                            "additionalProperties" = {
                                                              "type" = "string"
                                                            }
                                                            "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                            "type" = "object"
                                                          }
                                                        }
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                      "namespaces" = {
                                                        "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                        "items" = {
                                                          "type" = "string"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "topologyKey" = {
                                                        "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                        "type" = "string"
                                                      }
                                                    }
                                                    "required" = [
                                                      "topologyKey",
                                                    ]
                                                    "type" = "object"
                                                  }
                                                  "type" = "array"
                                                }
                                              }
                                              "type" = "object"
                                            }
                                            "podAntiAffinity" = {
                                              "description" = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
                                              "properties" = {
                                                "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                  "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
                                                  "items" = {
                                                    "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                                    "properties" = {
                                                      "podAffinityTerm" = {
                                                        "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                                        "properties" = {
                                                          "labelSelector" = {
                                                            "description" = "A label query over a set of resources, in this case pods."
                                                            "properties" = {
                                                              "matchExpressions" = {
                                                                "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                "items" = {
                                                                  "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                  "properties" = {
                                                                    "key" = {
                                                                      "description" = "key is the label key that the selector applies to."
                                                                      "type" = "string"
                                                                    }
                                                                    "operator" = {
                                                                      "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                      "type" = "string"
                                                                    }
                                                                    "values" = {
                                                                      "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                      "items" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                  }
                                                                  "required" = [
                                                                    "key",
                                                                    "operator",
                                                                  ]
                                                                  "type" = "object"
                                                                }
                                                                "type" = "array"
                                                              }
                                                              "matchLabels" = {
                                                                "additionalProperties" = {
                                                                  "type" = "string"
                                                                }
                                                                "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                "type" = "object"
                                                              }
                                                            }
                                                            "type" = "object"
                                                            "x-kubernetes-map-type" = "atomic"
                                                          }
                                                          "namespaceSelector" = {
                                                            "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                            "properties" = {
                                                              "matchExpressions" = {
                                                                "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                "items" = {
                                                                  "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                  "properties" = {
                                                                    "key" = {
                                                                      "description" = "key is the label key that the selector applies to."
                                                                      "type" = "string"
                                                                    }
                                                                    "operator" = {
                                                                      "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                      "type" = "string"
                                                                    }
                                                                    "values" = {
                                                                      "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                      "items" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                  }
                                                                  "required" = [
                                                                    "key",
                                                                    "operator",
                                                                  ]
                                                                  "type" = "object"
                                                                }
                                                                "type" = "array"
                                                              }
                                                              "matchLabels" = {
                                                                "additionalProperties" = {
                                                                  "type" = "string"
                                                                }
                                                                "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                "type" = "object"
                                                              }
                                                            }
                                                            "type" = "object"
                                                            "x-kubernetes-map-type" = "atomic"
                                                          }
                                                          "namespaces" = {
                                                            "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                            "items" = {
                                                              "type" = "string"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "topologyKey" = {
                                                            "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                            "type" = "string"
                                                          }
                                                        }
                                                        "required" = [
                                                          "topologyKey",
                                                        ]
                                                        "type" = "object"
                                                      }
                                                      "weight" = {
                                                        "description" = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
                                                        "format" = "int32"
                                                        "type" = "integer"
                                                      }
                                                    }
                                                    "required" = [
                                                      "podAffinityTerm",
                                                      "weight",
                                                    ]
                                                    "type" = "object"
                                                  }
                                                  "type" = "array"
                                                }
                                                "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                  "description" = "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
                                                  "items" = {
                                                    "description" = "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
                                                    "properties" = {
                                                      "labelSelector" = {
                                                        "description" = "A label query over a set of resources, in this case pods."
                                                        "properties" = {
                                                          "matchExpressions" = {
                                                            "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                            "items" = {
                                                              "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "key is the label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "matchLabels" = {
                                                            "additionalProperties" = {
                                                              "type" = "string"
                                                            }
                                                            "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                            "type" = "object"
                                                          }
                                                        }
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                      "namespaceSelector" = {
                                                        "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                        "properties" = {
                                                          "matchExpressions" = {
                                                            "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                            "items" = {
                                                              "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                              "properties" = {
                                                                "key" = {
                                                                  "description" = "key is the label key that the selector applies to."
                                                                  "type" = "string"
                                                                }
                                                                "operator" = {
                                                                  "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                  "type" = "string"
                                                                }
                                                                "values" = {
                                                                  "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "required" = [
                                                                "key",
                                                                "operator",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "type" = "array"
                                                          }
                                                          "matchLabels" = {
                                                            "additionalProperties" = {
                                                              "type" = "string"
                                                            }
                                                            "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                            "type" = "object"
                                                          }
                                                        }
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                      "namespaces" = {
                                                        "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                        "items" = {
                                                          "type" = "string"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "topologyKey" = {
                                                        "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                        "type" = "string"
                                                      }
                                                    }
                                                    "required" = [
                                                      "topologyKey",
                                                    ]
                                                    "type" = "object"
                                                  }
                                                  "type" = "array"
                                                }
                                              }
                                              "type" = "object"
                                            }
                                          }
                                          "type" = "object"
                                        }
                                        "imagePullSecrets" = {
                                          "description" = "If specified, the pod's imagePullSecrets"
                                          "items" = {
                                            "description" = "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
                                            "properties" = {
                                              "name" = {
                                                "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                                "type" = "string"
                                              }
                                            }
                                            "type" = "object"
                                            "x-kubernetes-map-type" = "atomic"
                                          }
                                          "type" = "array"
                                        }
                                        "nodeSelector" = {
                                          "additionalProperties" = {
                                            "type" = "string"
                                          }
                                          "description" = "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"
                                          "type" = "object"
                                        }
                                        "priorityClassName" = {
                                          "description" = "If specified, the pod's priorityClassName."
                                          "type" = "string"
                                        }
                                        "serviceAccountName" = {
                                          "description" = "If specified, the pod's service account"
                                          "type" = "string"
                                        }
                                        "tolerations" = {
                                          "description" = "If specified, the pod's tolerations."
                                          "items" = {
                                            "description" = "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
                                            "properties" = {
                                              "effect" = {
                                                "description" = "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
                                                "type" = "string"
                                              }
                                              "key" = {
                                                "description" = "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
                                                "type" = "string"
                                              }
                                              "operator" = {
                                                "description" = "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
                                                "type" = "string"
                                              }
                                              "tolerationSeconds" = {
                                                "description" = "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
                                                "format" = "int64"
                                                "type" = "integer"
                                              }
                                              "value" = {
                                                "description" = "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
                                                "type" = "string"
                                              }
                                            }
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "serviceType" = {
                                  "description" = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                          }
                          "type" = "object"
                        }
                        "selector" = {
                          "description" = "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver. If not specified, the solver will be treated as the 'default' solver with the lowest priority, i.e. if any other solver has a more specific match, it will be used instead."
                          "properties" = {
                            "dnsNames" = {
                              "description" = "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected."
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "dnsZones" = {
                              "description" = "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected."
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "matchLabels" = {
                              "additionalProperties" = {
                                "type" = "string"
                              }
                              "description" = "A label selector that is used to refine the set of certificate's that this challenge solver will apply to."
                              "type" = "object"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "token" = {
                      "description" = "The ACME challenge token for this challenge. This is the raw value returned from the ACME server."
                      "type" = "string"
                    }
                    "type" = {
                      "description" = "The type of ACME challenge this resource represents. One of \"HTTP-01\" or \"DNS-01\"."
                      "enum" = [
                        "HTTP-01",
                        "DNS-01",
                      ]
                      "type" = "string"
                    }
                    "url" = {
                      "description" = "The URL of the ACME Challenge resource for this challenge. This can be used to lookup details about the status of this challenge."
                      "type" = "string"
                    }
                    "wildcard" = {
                      "description" = "wildcard will be true if this challenge is for a wildcard identifier, for example '*.example.com'."
                      "type" = "boolean"
                    }
                  }
                  "required" = [
                    "authorizationURL",
                    "dnsName",
                    "issuerRef",
                    "key",
                    "solver",
                    "token",
                    "type",
                    "url",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "properties" = {
                    "presented" = {
                      "description" = "presented will be set to true if the challenge values for this challenge are currently 'presented'. This *does not* imply the self check is passing. Only that the values have been 'submitted' for the appropriate challenge mechanism (i.e. the DNS01 TXT record has been presented, or the HTTP01 configuration has been configured)."
                      "type" = "boolean"
                    }
                    "processing" = {
                      "description" = "Used to denote whether this challenge should be processed or not. This field will only be set to true by the 'scheduling' component. It will only be set to false by the 'challenges' controller, after the challenge has reached a final state or timed out. If this field is set to false, the challenge controller will not take any more action."
                      "type" = "boolean"
                    }
                    "reason" = {
                      "description" = "Contains human readable information on why the Challenge is in the current state."
                      "type" = "string"
                    }
                    "state" = {
                      "description" = "Contains the current 'state' of the challenge. If not set, the state of the challenge is unknown."
                      "enum" = [
                        "valid",
                        "ready",
                        "pending",
                        "processing",
                        "invalid",
                        "expired",
                        "errored",
                      ]
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "metadata",
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
resource "kubernetes_manifest" "customresourcedefinition_certificaterequests_cert_manager_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "certificaterequests.cert-manager.io"
    }
    "spec" = {
      "group" = "cert-manager.io"
      "names" = {
        "categories" = [
          "cert-manager",
        ]
        "kind" = "CertificateRequest"
        "listKind" = "CertificateRequestList"
        "plural" = "certificaterequests"
        "shortNames" = [
          "cr",
          "crs",
        ]
        "singular" = "certificaterequest"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Approved\")].status"
              "name" = "Approved"
              "type" = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Denied\")].status"
              "name" = "Denied"
              "type" = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].status"
              "name" = "Ready"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.issuerRef.name"
              "name" = "Issuer"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.username"
              "name" = "Requestor"
              "type" = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].message"
              "name" = "Status"
              "priority" = 1
              "type" = "string"
            },
            {
              "description" = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = <<-EOT
              A CertificateRequest is used to request a signed certificate from one of the configured issuers. 
               All fields within the CertificateRequest's `spec` are immutable after creation. A CertificateRequest will either succeed or fail, as denoted by its `status.state` field. 
               A CertificateRequest is a one-shot resource, meaning it represents a single point in time request for a certificate and cannot be re-used.
              EOT
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "Desired state of the CertificateRequest resource."
                  "properties" = {
                    "duration" = {
                      "description" = "The requested 'duration' (i.e. lifetime) of the Certificate. This option may be ignored/overridden by some issuer types."
                      "type" = "string"
                    }
                    "extra" = {
                      "additionalProperties" = {
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "description" = "Extra contains extra attributes of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable."
                      "type" = "object"
                    }
                    "groups" = {
                      "description" = "Groups contains group membership of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "atomic"
                    }
                    "isCA" = {
                      "description" = "IsCA will request to mark the certificate as valid for certificate signing when submitting to the issuer. This will automatically add the `cert sign` usage to the list of `usages`."
                      "type" = "boolean"
                    }
                    "issuerRef" = {
                      "description" = "IssuerRef is a reference to the issuer for this CertificateRequest.  If the `kind` field is not set, or set to `Issuer`, an Issuer resource with the given name in the same namespace as the CertificateRequest will be used.  If the `kind` field is set to `ClusterIssuer`, a ClusterIssuer with the provided name will be used. The `name` field in this stanza is required at all times. The group field refers to the API group of the issuer which defaults to `cert-manager.io` if empty."
                      "properties" = {
                        "group" = {
                          "description" = "Group of the resource being referred to."
                          "type" = "string"
                        }
                        "kind" = {
                          "description" = "Kind of the resource being referred to."
                          "type" = "string"
                        }
                        "name" = {
                          "description" = "Name of the resource being referred to."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "name",
                      ]
                      "type" = "object"
                    }
                    "request" = {
                      "description" = "The PEM-encoded x509 certificate signing request to be submitted to the CA for signing."
                      "format" = "byte"
                      "type" = "string"
                    }
                    "uid" = {
                      "description" = "UID contains the uid of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable."
                      "type" = "string"
                    }
                    "usages" = {
                      "description" = "Usages is the set of x509 usages that are requested for the certificate. If usages are set they SHOULD be encoded inside the CSR spec Defaults to `digital signature` and `key encipherment` if not specified."
                      "items" = {
                        "description" = <<-EOT
                        KeyUsage specifies valid usage contexts for keys. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3 https://tools.ietf.org/html/rfc5280#section-4.2.1.12 
                         Valid KeyUsage values are as follows: "signing", "digital signature", "content commitment", "key encipherment", "key agreement", "data encipherment", "cert sign", "crl sign", "encipher only", "decipher only", "any", "server auth", "client auth", "code signing", "email protection", "s/mime", "ipsec end system", "ipsec tunnel", "ipsec user", "timestamping", "ocsp signing", "microsoft sgc", "netscape sgc"
                        EOT
                        "enum" = [
                          "signing",
                          "digital signature",
                          "content commitment",
                          "key encipherment",
                          "key agreement",
                          "data encipherment",
                          "cert sign",
                          "crl sign",
                          "encipher only",
                          "decipher only",
                          "any",
                          "server auth",
                          "client auth",
                          "code signing",
                          "email protection",
                          "s/mime",
                          "ipsec end system",
                          "ipsec tunnel",
                          "ipsec user",
                          "timestamping",
                          "ocsp signing",
                          "microsoft sgc",
                          "netscape sgc",
                        ]
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "username" = {
                      "description" = "Username contains the name of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable."
                      "type" = "string"
                    }
                  }
                  "required" = [
                    "issuerRef",
                    "request",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = "Status of the CertificateRequest. This is set and managed automatically."
                  "properties" = {
                    "ca" = {
                      "description" = "The PEM encoded x509 certificate of the signer, also known as the CA (Certificate Authority). This is set on a best-effort basis by different issuers. If not set, the CA is assumed to be unknown/not available."
                      "format" = "byte"
                      "type" = "string"
                    }
                    "certificate" = {
                      "description" = "The PEM encoded x509 certificate resulting from the certificate signing request. If not set, the CertificateRequest has either not been completed or has failed. More information on failure can be found by checking the `conditions` field."
                      "format" = "byte"
                      "type" = "string"
                    }
                    "conditions" = {
                      "description" = "List of status conditions to indicate the status of a CertificateRequest. Known condition types are `Ready` and `InvalidRequest`."
                      "items" = {
                        "description" = "CertificateRequestCondition contains condition information for a CertificateRequest."
                        "properties" = {
                          "lastTransitionTime" = {
                            "description" = "LastTransitionTime is the timestamp corresponding to the last status change of this condition."
                            "format" = "date-time"
                            "type" = "string"
                          }
                          "message" = {
                            "description" = "Message is a human readable description of the details of the last transition, complementing reason."
                            "type" = "string"
                          }
                          "reason" = {
                            "description" = "Reason is a brief machine readable explanation for the condition's last transition."
                            "type" = "string"
                          }
                          "status" = {
                            "description" = "Status of the condition, one of (`True`, `False`, `Unknown`)."
                            "enum" = [
                              "True",
                              "False",
                              "Unknown",
                            ]
                            "type" = "string"
                          }
                          "type" = {
                            "description" = "Type of the condition, known values are (`Ready`, `InvalidRequest`, `Approved`, `Denied`)."
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "status",
                          "type",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "type",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                    "failureTime" = {
                      "description" = "FailureTime stores the time that this CertificateRequest failed. This is used to influence garbage collection and back-off."
                      "format" = "date-time"
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
resource "kubernetes_manifest" "customresourcedefinition_issuers_cert_manager_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "issuers.cert-manager.io"
    }
    "spec" = {
      "group" = "cert-manager.io"
      "names" = {
        "categories" = [
          "cert-manager",
        ]
        "kind" = "Issuer"
        "listKind" = "IssuerList"
        "plural" = "issuers"
        "singular" = "issuer"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].status"
              "name" = "Ready"
              "type" = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].message"
              "name" = "Status"
              "priority" = 1
              "type" = "string"
            },
            {
              "description" = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "An Issuer represents a certificate issuing authority which can be referenced as part of `issuerRef` fields. It is scoped to a single namespace and can therefore only be referenced by resources within the same namespace."
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "Desired state of the Issuer resource."
                  "properties" = {
                    "acme" = {
                      "description" = "ACME configures this issuer to communicate with a RFC8555 (ACME) server to obtain signed x509 certificates."
                      "properties" = {
                        "caBundle" = {
                          "description" = "Base64-encoded bundle of PEM CAs which can be used to validate the certificate chain presented by the ACME server. Mutually exclusive with SkipTLSVerify; prefer using CABundle to prevent various kinds of security vulnerabilities. If CABundle and SkipTLSVerify are unset, the system certificate bundle inside the container is used to validate the TLS connection."
                          "format" = "byte"
                          "type" = "string"
                        }
                        "disableAccountKeyGeneration" = {
                          "description" = "Enables or disables generating a new ACME account key. If true, the Issuer resource will *not* request a new account but will expect the account key to be supplied via an existing secret. If false, the cert-manager system will generate a new ACME account key for the Issuer. Defaults to false."
                          "type" = "boolean"
                        }
                        "email" = {
                          "description" = "Email is the email address to be associated with the ACME account. This field is optional, but it is strongly recommended to be set. It will be used to contact you in case of issues with your account or certificates, including expiry notification emails. This field may be updated after the account is initially registered."
                          "type" = "string"
                        }
                        "enableDurationFeature" = {
                          "description" = "Enables requesting a Not After date on certificates that matches the duration of the certificate. This is not supported by all ACME servers like Let's Encrypt. If set to true when the ACME server does not support it it will create an error on the Order. Defaults to false."
                          "type" = "boolean"
                        }
                        "externalAccountBinding" = {
                          "description" = "ExternalAccountBinding is a reference to a CA external account of the ACME server. If set, upon registration cert-manager will attempt to associate the given external account credentials with the registered ACME account."
                          "properties" = {
                            "keyAlgorithm" = {
                              "description" = "Deprecated: keyAlgorithm field exists for historical compatibility reasons and should not be used. The algorithm is now hardcoded to HS256 in golang/x/crypto/acme."
                              "enum" = [
                                "HS256",
                                "HS384",
                                "HS512",
                              ]
                              "type" = "string"
                            }
                            "keyID" = {
                              "description" = "keyID is the ID of the CA key that the External Account is bound to."
                              "type" = "string"
                            }
                            "keySecretRef" = {
                              "description" = "keySecretRef is a Secret Key Selector referencing a data item in a Kubernetes Secret which holds the symmetric MAC key of the External Account Binding. The `key` is the index string that is paired with the key data in the Secret and should not be confused with the key data itself, or indeed with the External Account Binding keyID above. The secret key stored in the Secret **must** be un-padded, base64 URL encoded data."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                          }
                          "required" = [
                            "keyID",
                            "keySecretRef",
                          ]
                          "type" = "object"
                        }
                        "preferredChain" = {
                          "description" = "PreferredChain is the chain to use if the ACME server outputs multiple. PreferredChain is no guarantee that this one gets delivered by the ACME endpoint. For example, for Let's Encrypt's DST crosssign you would use: \"DST Root CA X3\" or \"ISRG Root X1\" for the newer Let's Encrypt root CA. This value picks the first certificate bundle in the ACME alternative chains that has a certificate with this value as its issuer's CN"
                          "maxLength" = 64
                          "type" = "string"
                        }
                        "privateKeySecretRef" = {
                          "description" = "PrivateKey is the name of a Kubernetes Secret resource that will be used to store the automatically generated ACME account private key. Optionally, a `key` may be specified to select a specific entry within the named Secret resource. If `key` is not specified, a default of `tls.key` will be used."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "name",
                          ]
                          "type" = "object"
                        }
                        "server" = {
                          "description" = "Server is the URL used to access the ACME server's 'directory' endpoint. For example, for Let's Encrypt's staging endpoint, you would use: \"https://acme-staging-v02.api.letsencrypt.org/directory\". Only ACME v2 endpoints (i.e. RFC 8555) are supported."
                          "type" = "string"
                        }
                        "skipTLSVerify" = {
                          "description" = "INSECURE: Enables or disables validation of the ACME server TLS certificate. If true, requests to the ACME server will not have the TLS certificate chain validated. Mutually exclusive with CABundle; prefer using CABundle to prevent various kinds of security vulnerabilities. Only enable this option in development environments. If CABundle and SkipTLSVerify are unset, the system certificate bundle inside the container is used to validate the TLS connection. Defaults to false."
                          "type" = "boolean"
                        }
                        "solvers" = {
                          "description" = "Solvers is a list of challenge solvers that will be used to solve ACME challenges for the matching domains. Solver configurations must be provided in order to obtain certificates from an ACME server. For more information, see: https://cert-manager.io/docs/configuration/acme/"
                          "items" = {
                            "description" = "An ACMEChallengeSolver describes how to solve ACME challenges for the issuer it is part of. A selector may be provided to use different solving strategies for different DNS names. Only one of HTTP01 or DNS01 must be provided."
                            "properties" = {
                              "dns01" = {
                                "description" = "Configures cert-manager to attempt to complete authorizations by performing the DNS01 challenge flow."
                                "properties" = {
                                  "acmeDNS" = {
                                    "description" = "Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage DNS01 challenge records."
                                    "properties" = {
                                      "accountSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "host" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "accountSecretRef",
                                      "host",
                                    ]
                                    "type" = "object"
                                  }
                                  "akamai" = {
                                    "description" = "Use the Akamai DNS zone management API to manage DNS01 challenge records."
                                    "properties" = {
                                      "accessTokenSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "clientSecretSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "clientTokenSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "serviceConsumerDomain" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "accessTokenSecretRef",
                                      "clientSecretSecretRef",
                                      "clientTokenSecretRef",
                                      "serviceConsumerDomain",
                                    ]
                                    "type" = "object"
                                  }
                                  "azureDNS" = {
                                    "description" = "Use the Microsoft Azure DNS API to manage DNS01 challenge records."
                                    "properties" = {
                                      "clientID" = {
                                        "description" = "if both this and ClientSecret are left unset MSI will be used"
                                        "type" = "string"
                                      }
                                      "clientSecretSecretRef" = {
                                        "description" = "if both this and ClientID are left unset MSI will be used"
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "environment" = {
                                        "description" = "name of the Azure environment (default AzurePublicCloud)"
                                        "enum" = [
                                          "AzurePublicCloud",
                                          "AzureChinaCloud",
                                          "AzureGermanCloud",
                                          "AzureUSGovernmentCloud",
                                        ]
                                        "type" = "string"
                                      }
                                      "hostedZoneName" = {
                                        "description" = "name of the DNS zone that should be used"
                                        "type" = "string"
                                      }
                                      "managedIdentity" = {
                                        "description" = "managed identity configuration, can not be used at the same time as clientID, clientSecretSecretRef or tenantID"
                                        "properties" = {
                                          "clientID" = {
                                            "description" = "client ID of the managed identity, can not be used at the same time as resourceID"
                                            "type" = "string"
                                          }
                                          "resourceID" = {
                                            "description" = "resource ID of the managed identity, can not be used at the same time as clientID"
                                            "type" = "string"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "resourceGroupName" = {
                                        "description" = "resource group the DNS zone is located in"
                                        "type" = "string"
                                      }
                                      "subscriptionID" = {
                                        "description" = "ID of the Azure subscription"
                                        "type" = "string"
                                      }
                                      "tenantID" = {
                                        "description" = "when specifying ClientID and ClientSecret then this field is also needed"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "resourceGroupName",
                                      "subscriptionID",
                                    ]
                                    "type" = "object"
                                  }
                                  "cloudDNS" = {
                                    "description" = "Use the Google Cloud DNS API to manage DNS01 challenge records."
                                    "properties" = {
                                      "hostedZoneName" = {
                                        "description" = "HostedZoneName is an optional field that tells cert-manager in which Cloud DNS zone the challenge record has to be created. If left empty cert-manager will automatically choose a zone."
                                        "type" = "string"
                                      }
                                      "project" = {
                                        "type" = "string"
                                      }
                                      "serviceAccountSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "project",
                                    ]
                                    "type" = "object"
                                  }
                                  "cloudflare" = {
                                    "description" = "Use the Cloudflare API to manage DNS01 challenge records."
                                    "properties" = {
                                      "apiKeySecretRef" = {
                                        "description" = "API key to use to authenticate with Cloudflare. Note: using an API token to authenticate is now the recommended method as it allows greater control of permissions."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "apiTokenSecretRef" = {
                                        "description" = "API token used to authenticate with Cloudflare."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "email" = {
                                        "description" = "Email of the account, only required when using API key based authentication."
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "cnameStrategy" = {
                                    "description" = "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones."
                                    "enum" = [
                                      "None",
                                      "Follow",
                                    ]
                                    "type" = "string"
                                  }
                                  "digitalocean" = {
                                    "description" = "Use the DigitalOcean DNS API to manage DNS01 challenge records."
                                    "properties" = {
                                      "tokenSecretRef" = {
                                        "description" = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "tokenSecretRef",
                                    ]
                                    "type" = "object"
                                  }
                                  "rfc2136" = {
                                    "description" = "Use RFC2136 (\"Dynamic Updates in the Domain Name System\") (https://datatracker.ietf.org/doc/rfc2136/) to manage DNS01 challenge records."
                                    "properties" = {
                                      "nameserver" = {
                                        "description" = "The IP address or hostname of an authoritative DNS server supporting RFC2136 in the form host:port. If the host is an IPv6 address it must be enclosed in square brackets (e.g [2001:db8::1])\u00a0; port is optional. This field is required."
                                        "type" = "string"
                                      }
                                      "tsigAlgorithm" = {
                                        "description" = "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``."
                                        "type" = "string"
                                      }
                                      "tsigKeyName" = {
                                        "description" = "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required."
                                        "type" = "string"
                                      }
                                      "tsigSecretSecretRef" = {
                                        "description" = "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required."
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "nameserver",
                                    ]
                                    "type" = "object"
                                  }
                                  "route53" = {
                                    "description" = "Use the AWS Route53 API to manage DNS01 challenge records."
                                    "properties" = {
                                      "accessKeyID" = {
                                        "description" = "The AccessKeyID is used for authentication. Cannot be set when SecretAccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                        "type" = "string"
                                      }
                                      "accessKeyIDSecretRef" = {
                                        "description" = "The SecretAccessKey is used for authentication. If set, pull the AWS access key ID from a key within a Kubernetes Secret. Cannot be set when AccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "hostedZoneID" = {
                                        "description" = "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call."
                                        "type" = "string"
                                      }
                                      "region" = {
                                        "description" = "Always set the region when using AccessKeyID and SecretAccessKey"
                                        "type" = "string"
                                      }
                                      "role" = {
                                        "description" = "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata"
                                        "type" = "string"
                                      }
                                      "secretAccessKeySecretRef" = {
                                        "description" = "The SecretAccessKey is used for authentication. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials"
                                        "properties" = {
                                          "key" = {
                                            "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                    }
                                    "required" = [
                                      "region",
                                    ]
                                    "type" = "object"
                                  }
                                  "webhook" = {
                                    "description" = "Configure an external webhook based DNS01 challenge solver to manage DNS01 challenge records."
                                    "properties" = {
                                      "config" = {
                                        "description" = "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation."
                                        "x-kubernetes-preserve-unknown-fields" = true
                                      }
                                      "groupName" = {
                                        "description" = "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation."
                                        "type" = "string"
                                      }
                                      "solverName" = {
                                        "description" = "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "groupName",
                                      "solverName",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "http01" = {
                                "description" = "Configures cert-manager to attempt to complete authorizations by performing the HTTP01 challenge flow. It is not possible to obtain certificates for wildcard domain names (e.g. `*.example.com`) using the HTTP01 challenge mechanism."
                                "properties" = {
                                  "gatewayHTTPRoute" = {
                                    "description" = "The Gateway API is a sig-network community API that models service networking in Kubernetes (https://gateway-api.sigs.k8s.io/). The Gateway solver will create HTTPRoutes with the specified labels in the same namespace as the challenge. This solver is experimental, and fields / behaviour may change in the future."
                                    "properties" = {
                                      "labels" = {
                                        "additionalProperties" = {
                                          "type" = "string"
                                        }
                                        "description" = "Custom labels that will be applied to HTTPRoutes created by cert-manager while solving HTTP-01 challenges."
                                        "type" = "object"
                                      }
                                      "parentRefs" = {
                                        "description" = "When solving an HTTP-01 challenge, cert-manager creates an HTTPRoute. cert-manager needs to know which parentRefs should be used when creating the HTTPRoute. Usually, the parentRef references a Gateway. See: https://gateway-api.sigs.k8s.io/api-types/httproute/#attaching-to-gateways"
                                        "items" = {
                                          "description" = <<-EOT
                                          ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with "Core" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
                                           The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
                                          EOT
                                          "properties" = {
                                            "group" = {
                                              "default" = "gateway.networking.k8s.io"
                                              "description" = <<-EOT
                                              Group is the group of the referent. When unspecified, "gateway.networking.k8s.io" is inferred. To set the core API group (such as for a "Service" kind referent), Group must be explicitly set to "" (empty string). 
                                               Support: Core
                                              EOT
                                              "maxLength" = 253
                                              "pattern" = "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
                                              "type" = "string"
                                            }
                                            "kind" = {
                                              "default" = "Gateway"
                                              "description" = <<-EOT
                                              Kind is kind of the referent. 
                                               Support: Core (Gateway) 
                                               Support: Implementation-specific (Other Resources)
                                              EOT
                                              "maxLength" = 63
                                              "minLength" = 1
                                              "pattern" = "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
                                              "type" = "string"
                                            }
                                            "name" = {
                                              "description" = <<-EOT
                                              Name is the name of the referent. 
                                               Support: Core
                                              EOT
                                              "maxLength" = 253
                                              "minLength" = 1
                                              "type" = "string"
                                            }
                                            "namespace" = {
                                              "description" = <<-EOT
                                              Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. 
                                               Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. 
                                               Support: Core
                                              EOT
                                              "maxLength" = 63
                                              "minLength" = 1
                                              "pattern" = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
                                              "type" = "string"
                                            }
                                            "port" = {
                                              "description" = <<-EOT
                                              Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. 
                                               When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. 
                                               Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. 
                                               For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
                                               Support: Extended 
                                               <gateway:experimental>
                                              EOT
                                              "format" = "int32"
                                              "maximum" = 65535
                                              "minimum" = 1
                                              "type" = "integer"
                                            }
                                            "sectionName" = {
                                              "description" = <<-EOT
                                              SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
                                               * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
                                               Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
                                               When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
                                               Support: Core
                                              EOT
                                              "maxLength" = 253
                                              "minLength" = 1
                                              "pattern" = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
                                              "type" = "string"
                                            }
                                          }
                                          "required" = [
                                            "name",
                                          ]
                                          "type" = "object"
                                        }
                                        "type" = "array"
                                      }
                                      "serviceType" = {
                                        "description" = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort."
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "ingress" = {
                                    "description" = "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed."
                                    "properties" = {
                                      "class" = {
                                        "description" = "This field configures the annotation `kubernetes.io/ingress.class` when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of `class`, `name` or `ingressClassName` may be specified."
                                        "type" = "string"
                                      }
                                      "ingressClassName" = {
                                        "description" = "This field configures the field `ingressClassName` on the created Ingress resources used to solve ACME challenges that use this challenge solver. This is the recommended way of configuring the ingress class. Only one of `class`, `name` or `ingressClassName` may be specified."
                                        "type" = "string"
                                      }
                                      "ingressTemplate" = {
                                        "description" = "Optional ingress template used to configure the ACME challenge solver ingress used for HTTP01 challenges."
                                        "properties" = {
                                          "metadata" = {
                                            "description" = "ObjectMeta overrides for the ingress used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values."
                                            "properties" = {
                                              "annotations" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Annotations that should be added to the created ACME HTTP01 solver ingress."
                                                "type" = "object"
                                              }
                                              "labels" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Labels that should be added to the created ACME HTTP01 solver ingress."
                                                "type" = "object"
                                              }
                                            }
                                            "type" = "object"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "name" = {
                                        "description" = "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources. Only one of `class`, `name` or `ingressClassName` may be specified."
                                        "type" = "string"
                                      }
                                      "podTemplate" = {
                                        "description" = "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges."
                                        "properties" = {
                                          "metadata" = {
                                            "description" = "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values."
                                            "properties" = {
                                              "annotations" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Annotations that should be added to the create ACME HTTP01 solver pods."
                                                "type" = "object"
                                              }
                                              "labels" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "Labels that should be added to the created ACME HTTP01 solver pods."
                                                "type" = "object"
                                              }
                                            }
                                            "type" = "object"
                                          }
                                          "spec" = {
                                            "description" = "PodSpec defines overrides for the HTTP01 challenge solver pod. Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields. All other fields will be ignored."
                                            "properties" = {
                                              "affinity" = {
                                                "description" = "If specified, the pod's scheduling constraints"
                                                "properties" = {
                                                  "nodeAffinity" = {
                                                    "description" = "Describes node affinity scheduling rules for the pod."
                                                    "properties" = {
                                                      "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
                                                        "items" = {
                                                          "description" = "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
                                                          "properties" = {
                                                            "preference" = {
                                                              "description" = "A node selector term, associated with the corresponding weight."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "A list of node selector requirements by node's labels."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchFields" = {
                                                                  "description" = "A list of node selector requirements by node's fields."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "weight" = {
                                                              "description" = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
                                                              "format" = "int32"
                                                              "type" = "integer"
                                                            }
                                                          }
                                                          "required" = [
                                                            "preference",
                                                            "weight",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
                                                        "properties" = {
                                                          "nodeSelectorTerms" = {
                                                            "description" = "Required. A list of node selector terms. The terms are ORed."
                                                            "items" = {
                                                              "description" = "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "A list of node selector requirements by node's labels."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchFields" = {
                                                                  "description" = "A list of node selector requirements by node's fields."
                                                                  "items" = {
                                                                    "description" = "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "The label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "type" = "array"
                                                          }
                                                        }
                                                        "required" = [
                                                          "nodeSelectorTerms",
                                                        ]
                                                        "type" = "object"
                                                        "x-kubernetes-map-type" = "atomic"
                                                      }
                                                    }
                                                    "type" = "object"
                                                  }
                                                  "podAffinity" = {
                                                    "description" = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
                                                    "properties" = {
                                                      "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
                                                        "items" = {
                                                          "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                                          "properties" = {
                                                            "podAffinityTerm" = {
                                                              "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                                              "properties" = {
                                                                "labelSelector" = {
                                                                  "description" = "A label query over a set of resources, in this case pods."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaceSelector" = {
                                                                  "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaces" = {
                                                                  "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "topologyKey" = {
                                                                  "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                                  "type" = "string"
                                                                }
                                                              }
                                                              "required" = [
                                                                "topologyKey",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "weight" = {
                                                              "description" = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
                                                              "format" = "int32"
                                                              "type" = "integer"
                                                            }
                                                          }
                                                          "required" = [
                                                            "podAffinityTerm",
                                                            "weight",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
                                                        "items" = {
                                                          "description" = "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
                                                          "properties" = {
                                                            "labelSelector" = {
                                                              "description" = "A label query over a set of resources, in this case pods."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaceSelector" = {
                                                              "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaces" = {
                                                              "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                              "items" = {
                                                                "type" = "string"
                                                              }
                                                              "type" = "array"
                                                            }
                                                            "topologyKey" = {
                                                              "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                              "type" = "string"
                                                            }
                                                          }
                                                          "required" = [
                                                            "topologyKey",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                    }
                                                    "type" = "object"
                                                  }
                                                  "podAntiAffinity" = {
                                                    "description" = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
                                                    "properties" = {
                                                      "preferredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
                                                        "items" = {
                                                          "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                                          "properties" = {
                                                            "podAffinityTerm" = {
                                                              "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                                              "properties" = {
                                                                "labelSelector" = {
                                                                  "description" = "A label query over a set of resources, in this case pods."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaceSelector" = {
                                                                  "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                                  "properties" = {
                                                                    "matchExpressions" = {
                                                                      "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                      "items" = {
                                                                        "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                        "properties" = {
                                                                          "key" = {
                                                                            "description" = "key is the label key that the selector applies to."
                                                                            "type" = "string"
                                                                          }
                                                                          "operator" = {
                                                                            "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                            "type" = "string"
                                                                          }
                                                                          "values" = {
                                                                            "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                            "items" = {
                                                                              "type" = "string"
                                                                            }
                                                                            "type" = "array"
                                                                          }
                                                                        }
                                                                        "required" = [
                                                                          "key",
                                                                          "operator",
                                                                        ]
                                                                        "type" = "object"
                                                                      }
                                                                      "type" = "array"
                                                                    }
                                                                    "matchLabels" = {
                                                                      "additionalProperties" = {
                                                                        "type" = "string"
                                                                      }
                                                                      "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                      "type" = "object"
                                                                    }
                                                                  }
                                                                  "type" = "object"
                                                                  "x-kubernetes-map-type" = "atomic"
                                                                }
                                                                "namespaces" = {
                                                                  "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                                  "items" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "topologyKey" = {
                                                                  "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                                  "type" = "string"
                                                                }
                                                              }
                                                              "required" = [
                                                                "topologyKey",
                                                              ]
                                                              "type" = "object"
                                                            }
                                                            "weight" = {
                                                              "description" = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
                                                              "format" = "int32"
                                                              "type" = "integer"
                                                            }
                                                          }
                                                          "required" = [
                                                            "podAffinityTerm",
                                                            "weight",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                      "requiredDuringSchedulingIgnoredDuringExecution" = {
                                                        "description" = "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
                                                        "items" = {
                                                          "description" = "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
                                                          "properties" = {
                                                            "labelSelector" = {
                                                              "description" = "A label query over a set of resources, in this case pods."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaceSelector" = {
                                                              "description" = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
                                                              "properties" = {
                                                                "matchExpressions" = {
                                                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                                                  "items" = {
                                                                    "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                                                    "properties" = {
                                                                      "key" = {
                                                                        "description" = "key is the label key that the selector applies to."
                                                                        "type" = "string"
                                                                      }
                                                                      "operator" = {
                                                                        "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                                        "type" = "string"
                                                                      }
                                                                      "values" = {
                                                                        "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                                        "items" = {
                                                                          "type" = "string"
                                                                        }
                                                                        "type" = "array"
                                                                      }
                                                                    }
                                                                    "required" = [
                                                                      "key",
                                                                      "operator",
                                                                    ]
                                                                    "type" = "object"
                                                                  }
                                                                  "type" = "array"
                                                                }
                                                                "matchLabels" = {
                                                                  "additionalProperties" = {
                                                                    "type" = "string"
                                                                  }
                                                                  "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                                                  "type" = "object"
                                                                }
                                                              }
                                                              "type" = "object"
                                                              "x-kubernetes-map-type" = "atomic"
                                                            }
                                                            "namespaces" = {
                                                              "description" = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
                                                              "items" = {
                                                                "type" = "string"
                                                              }
                                                              "type" = "array"
                                                            }
                                                            "topologyKey" = {
                                                              "description" = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
                                                              "type" = "string"
                                                            }
                                                          }
                                                          "required" = [
                                                            "topologyKey",
                                                          ]
                                                          "type" = "object"
                                                        }
                                                        "type" = "array"
                                                      }
                                                    }
                                                    "type" = "object"
                                                  }
                                                }
                                                "type" = "object"
                                              }
                                              "imagePullSecrets" = {
                                                "description" = "If specified, the pod's imagePullSecrets"
                                                "items" = {
                                                  "description" = "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
                                                  "properties" = {
                                                    "name" = {
                                                      "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                                      "type" = "string"
                                                    }
                                                  }
                                                  "type" = "object"
                                                  "x-kubernetes-map-type" = "atomic"
                                                }
                                                "type" = "array"
                                              }
                                              "nodeSelector" = {
                                                "additionalProperties" = {
                                                  "type" = "string"
                                                }
                                                "description" = "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"
                                                "type" = "object"
                                              }
                                              "priorityClassName" = {
                                                "description" = "If specified, the pod's priorityClassName."
                                                "type" = "string"
                                              }
                                              "serviceAccountName" = {
                                                "description" = "If specified, the pod's service account"
                                                "type" = "string"
                                              }
                                              "tolerations" = {
                                                "description" = "If specified, the pod's tolerations."
                                                "items" = {
                                                  "description" = "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
                                                  "properties" = {
                                                    "effect" = {
                                                      "description" = "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
                                                      "type" = "string"
                                                    }
                                                    "key" = {
                                                      "description" = "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
                                                      "type" = "string"
                                                    }
                                                    "operator" = {
                                                      "description" = "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
                                                      "type" = "string"
                                                    }
                                                    "tolerationSeconds" = {
                                                      "description" = "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
                                                      "format" = "int64"
                                                      "type" = "integer"
                                                    }
                                                    "value" = {
                                                      "description" = "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
                                                      "type" = "string"
                                                    }
                                                  }
                                                  "type" = "object"
                                                }
                                                "type" = "array"
                                              }
                                            }
                                            "type" = "object"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "serviceType" = {
                                        "description" = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort."
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "selector" = {
                                "description" = "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver. If not specified, the solver will be treated as the 'default' solver with the lowest priority, i.e. if any other solver has a more specific match, it will be used instead."
                                "properties" = {
                                  "dnsNames" = {
                                    "description" = "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected."
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "dnsZones" = {
                                    "description" = "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected."
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "matchLabels" = {
                                    "additionalProperties" = {
                                      "type" = "string"
                                    }
                                    "description" = "A label selector that is used to refine the set of certificate's that this challenge solver will apply to."
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                      }
                      "required" = [
                        "privateKeySecretRef",
                        "server",
                      ]
                      "type" = "object"
                    }
                    "ca" = {
                      "description" = "CA configures this issuer to sign certificates using a signing CA keypair stored in a Secret resource. This is used to build internal PKIs that are managed by cert-manager."
                      "properties" = {
                        "crlDistributionPoints" = {
                          "description" = "The CRL distribution points is an X.509 v3 certificate extension which identifies the location of the CRL from which the revocation of this certificate can be checked. If not set, certificates will be issued without distribution points set."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "ocspServers" = {
                          "description" = "The OCSP server list is an X.509 v3 extension that defines a list of URLs of OCSP responders. The OCSP responders can be queried for the revocation status of an issued certificate. If not set, the certificate will be issued with no OCSP servers set. For example, an OCSP server URL could be \"http://ocsp.int-x3.letsencrypt.org\"."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "secretName" = {
                          "description" = "SecretName is the name of the secret used to sign Certificates issued by this Issuer."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "secretName",
                      ]
                      "type" = "object"
                    }
                    "selfSigned" = {
                      "description" = "SelfSigned configures this issuer to 'self sign' certificates using the private key used to create the CertificateRequest object."
                      "properties" = {
                        "crlDistributionPoints" = {
                          "description" = "The CRL distribution points is an X.509 v3 certificate extension which identifies the location of the CRL from which the revocation of this certificate can be checked. If not set certificate will be issued without CDP. Values are strings."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                      }
                      "type" = "object"
                    }
                    "vault" = {
                      "description" = "Vault configures this issuer to sign certificates using a HashiCorp Vault PKI backend."
                      "properties" = {
                        "auth" = {
                          "description" = "Auth configures how cert-manager authenticates with the Vault server."
                          "properties" = {
                            "appRole" = {
                              "description" = "AppRole authenticates with Vault using the App Role auth mechanism, with the role and secret stored in a Kubernetes Secret resource."
                              "properties" = {
                                "path" = {
                                  "description" = "Path where the App Role authentication backend is mounted in Vault, e.g: \"approle\""
                                  "type" = "string"
                                }
                                "roleId" = {
                                  "description" = "RoleID configured in the App Role authentication backend when setting up the authentication backend in Vault."
                                  "type" = "string"
                                }
                                "secretRef" = {
                                  "description" = "Reference to a key in a Secret that contains the App Role secret used to authenticate with Vault. The `key` field must be specified and denotes which entry within the Secret resource is used as the app role secret."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "path",
                                "roleId",
                                "secretRef",
                              ]
                              "type" = "object"
                            }
                            "kubernetes" = {
                              "description" = "Kubernetes authenticates with Vault by passing the ServiceAccount token stored in the named Secret resource to the Vault server."
                              "properties" = {
                                "mountPath" = {
                                  "description" = "The Vault mountPath here is the mount path to use when authenticating with Vault. For example, setting a value to `/v1/auth/foo`, will use the path `/v1/auth/foo/login` to authenticate with Vault. If unspecified, the default value \"/v1/auth/kubernetes\" will be used."
                                  "type" = "string"
                                }
                                "role" = {
                                  "description" = "A required field containing the Vault Role to assume. A Role binds a Kubernetes ServiceAccount with a set of Vault policies."
                                  "type" = "string"
                                }
                                "secretRef" = {
                                  "description" = "The required Secret field containing a Kubernetes ServiceAccount JWT used for authenticating with Vault. Use of 'ambient credentials' is not supported."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "serviceAccountRef" = {
                                  "description" = "A reference to a service account that will be used to request a bound token (also known as \"projected token\"). Compared to using \"secretRef\", using this field means that you don't rely on statically bound tokens. To use this field, you must configure an RBAC rule to let cert-manager request a token."
                                  "properties" = {
                                    "name" = {
                                      "description" = "Name of the ServiceAccount used to request a token."
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "role",
                              ]
                              "type" = "object"
                            }
                            "tokenSecretRef" = {
                              "description" = "TokenSecretRef authenticates with Vault by presenting a token."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                          }
                          "type" = "object"
                        }
                        "caBundle" = {
                          "description" = "Base64-encoded bundle of PEM CAs which will be used to validate the certificate chain presented by Vault. Only used if using HTTPS to connect to Vault and ignored for HTTP connections. Mutually exclusive with CABundleSecretRef. If neither CABundle nor CABundleSecretRef are defined, the certificate bundle in the cert-manager controller container is used to validate the TLS connection."
                          "format" = "byte"
                          "type" = "string"
                        }
                        "caBundleSecretRef" = {
                          "description" = "Reference to a Secret containing a bundle of PEM-encoded CAs to use when verifying the certificate chain presented by Vault when using HTTPS. Mutually exclusive with CABundle. If neither CABundle nor CABundleSecretRef are defined, the certificate bundle in the cert-manager controller container is used to validate the TLS connection. If no key for the Secret is specified, cert-manager will default to 'ca.crt'."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                              "type" = "string"
                            }
                            "name" = {
                              "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "name",
                          ]
                          "type" = "object"
                        }
                        "namespace" = {
                          "description" = "Name of the vault namespace. Namespaces is a set of features within Vault Enterprise that allows Vault environments to support Secure Multi-tenancy. e.g: \"ns1\" More about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces"
                          "type" = "string"
                        }
                        "path" = {
                          "description" = "Path is the mount path of the Vault PKI backend's `sign` endpoint, e.g: \"my_pki_mount/sign/my-role-name\"."
                          "type" = "string"
                        }
                        "server" = {
                          "description" = "Server is the connection address for the Vault server, e.g: \"https://vault.example.com:8200\"."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "auth",
                        "path",
                        "server",
                      ]
                      "type" = "object"
                    }
                    "venafi" = {
                      "description" = "Venafi configures this issuer to sign certificates using a Venafi TPP or Venafi Cloud policy zone."
                      "properties" = {
                        "cloud" = {
                          "description" = "Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified."
                          "properties" = {
                            "apiTokenSecretRef" = {
                              "description" = "APITokenSecretRef is a secret key selector for the Venafi Cloud API token."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "url" = {
                              "description" = "URL is the base URL for Venafi Cloud. Defaults to \"https://api.venafi.cloud/v1\"."
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "apiTokenSecretRef",
                          ]
                          "type" = "object"
                        }
                        "tpp" = {
                          "description" = "TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified."
                          "properties" = {
                            "caBundle" = {
                              "description" = "Base64-encoded bundle of PEM CAs which will be used to validate the certificate chain presented by the TPP server. Only used if using HTTPS; ignored for HTTP. If undefined, the certificate bundle in the cert-manager controller container is used to validate the chain."
                              "format" = "byte"
                              "type" = "string"
                            }
                            "credentialsRef" = {
                              "description" = "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'."
                              "properties" = {
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "url" = {
                              "description" = "URL is the base URL for the vedsdk endpoint of the Venafi TPP instance, for example: \"https://tpp.example.com/vedsdk\"."
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "credentialsRef",
                            "url",
                          ]
                          "type" = "object"
                        }
                        "zone" = {
                          "description" = "Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "zone",
                      ]
                      "type" = "object"
                    }
                  }
                  "type" = "object"
                }
                "status" = {
                  "description" = "Status of the Issuer. This is set and managed automatically."
                  "properties" = {
                    "acme" = {
                      "description" = "ACME specific status options. This field should only be set if the Issuer is configured to use an ACME server to issue certificates."
                      "properties" = {
                        "lastPrivateKeyHash" = {
                          "description" = "LastPrivateKeyHash is a hash of the private key associated with the latest registered ACME account, in order to track changes made to registered account associated with the Issuer"
                          "type" = "string"
                        }
                        "lastRegisteredEmail" = {
                          "description" = "LastRegisteredEmail is the email associated with the latest registered ACME account, in order to track changes made to registered account associated with the  Issuer"
                          "type" = "string"
                        }
                        "uri" = {
                          "description" = "URI is the unique account identifier, which can also be used to retrieve account details from the CA"
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "conditions" = {
                      "description" = "List of status conditions to indicate the status of a CertificateRequest. Known condition types are `Ready`."
                      "items" = {
                        "description" = "IssuerCondition contains condition information for an Issuer."
                        "properties" = {
                          "lastTransitionTime" = {
                            "description" = "LastTransitionTime is the timestamp corresponding to the last status change of this condition."
                            "format" = "date-time"
                            "type" = "string"
                          }
                          "message" = {
                            "description" = "Message is a human readable description of the details of the last transition, complementing reason."
                            "type" = "string"
                          }
                          "observedGeneration" = {
                            "description" = "If set, this represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.condition[x].observedGeneration is 9, the condition is out of date with respect to the current state of the Issuer."
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "reason" = {
                            "description" = "Reason is a brief machine readable explanation for the condition's last transition."
                            "type" = "string"
                          }
                          "status" = {
                            "description" = "Status of the condition, one of (`True`, `False`, `Unknown`)."
                            "enum" = [
                              "True",
                              "False",
                              "Unknown",
                            ]
                            "type" = "string"
                          }
                          "type" = {
                            "description" = "Type of the condition, known values are (`Ready`)."
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "status",
                          "type",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "type",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
resource "kubernetes_manifest" "customresourcedefinition_certificates_cert_manager_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "certificates.cert-manager.io"
    }
    "spec" = {
      "group" = "cert-manager.io"
      "names" = {
        "categories" = [
          "cert-manager",
        ]
        "kind" = "Certificate"
        "listKind" = "CertificateList"
        "plural" = "certificates"
        "shortNames" = [
          "cert",
          "certs",
        ]
        "singular" = "certificate"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].status"
              "name" = "Ready"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.secretName"
              "name" = "Secret"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.issuerRef.name"
              "name" = "Issuer"
              "priority" = 1
              "type" = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].message"
              "name" = "Status"
              "priority" = 1
              "type" = "string"
            },
            {
              "description" = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = <<-EOT
              A Certificate resource should be created to ensure an up to date and signed x509 certificate is stored in the Kubernetes Secret resource named in `spec.secretName`. 
               The stored certificate will be renewed before it expires (as configured by `spec.renewBefore`).
              EOT
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "Desired state of the Certificate resource."
                  "properties" = {
                    "additionalOutputFormats" = {
                      "description" = "AdditionalOutputFormats defines extra output formats of the private key and signed certificate chain to be written to this Certificate's target Secret. This is an Alpha Feature and is only enabled with the `--feature-gates=AdditionalCertificateOutputFormats=true` option on both the controller and webhook components."
                      "items" = {
                        "description" = "CertificateAdditionalOutputFormat defines an additional output format of a Certificate resource. These contain supplementary data formats of the signed certificate chain and paired private key."
                        "properties" = {
                          "type" = {
                            "description" = "Type is the name of the format type that should be written to the Certificate's target Secret."
                            "enum" = [
                              "DER",
                              "CombinedPEM",
                            ]
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "type",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "commonName" = {
                      "description" = "CommonName is a common name to be used on the Certificate. The CommonName should have a length of 64 characters or fewer to avoid generating invalid CSRs. This value is ignored by TLS clients when any subject alt name is set. This is x509 behaviour: https://tools.ietf.org/html/rfc6125#section-6.4.4"
                      "type" = "string"
                    }
                    "dnsNames" = {
                      "description" = "DNSNames is a list of DNS subjectAltNames to be set on the Certificate."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "duration" = {
                      "description" = "The requested 'duration' (i.e. lifetime) of the Certificate. This option may be ignored/overridden by some issuer types. If unset this defaults to 90 days. Certificate will be renewed either 2/3 through its duration or `renewBefore` period before its expiry, whichever is later. Minimum accepted duration is 1 hour. Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration"
                      "type" = "string"
                    }
                    "emailAddresses" = {
                      "description" = "EmailAddresses is a list of email subjectAltNames to be set on the Certificate."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "encodeUsagesInRequest" = {
                      "description" = "EncodeUsagesInRequest controls whether key usages should be present in the CertificateRequest"
                      "type" = "boolean"
                    }
                    "ipAddresses" = {
                      "description" = "IPAddresses is a list of IP address subjectAltNames to be set on the Certificate."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "isCA" = {
                      "description" = "IsCA will mark this Certificate as valid for certificate signing. This will automatically add the `cert sign` usage to the list of `usages`."
                      "type" = "boolean"
                    }
                    "issuerRef" = {
                      "description" = "IssuerRef is a reference to the issuer for this certificate. If the `kind` field is not set, or set to `Issuer`, an Issuer resource with the given name in the same namespace as the Certificate will be used. If the `kind` field is set to `ClusterIssuer`, a ClusterIssuer with the provided name will be used. The `name` field in this stanza is required at all times."
                      "properties" = {
                        "group" = {
                          "description" = "Group of the resource being referred to."
                          "type" = "string"
                        }
                        "kind" = {
                          "description" = "Kind of the resource being referred to."
                          "type" = "string"
                        }
                        "name" = {
                          "description" = "Name of the resource being referred to."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "name",
                      ]
                      "type" = "object"
                    }
                    "keystores" = {
                      "description" = "Keystores configures additional keystore output formats stored in the `secretName` Secret resource."
                      "properties" = {
                        "jks" = {
                          "description" = "JKS configures options for storing a JKS keystore in the `spec.secretName` Secret resource."
                          "properties" = {
                            "create" = {
                              "description" = "Create enables JKS keystore creation for the Certificate. If true, a file named `keystore.jks` will be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef`. The keystore file will be updated immediately. If the issuer provided a CA certificate, a file named `truststore.jks` will also be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef` containing the issuing Certificate Authority"
                              "type" = "boolean"
                            }
                            "passwordSecretRef" = {
                              "description" = "PasswordSecretRef is a reference to a key in a Secret resource containing the password used to encrypt the JKS keystore."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                          }
                          "required" = [
                            "create",
                            "passwordSecretRef",
                          ]
                          "type" = "object"
                        }
                        "pkcs12" = {
                          "description" = "PKCS12 configures options for storing a PKCS12 keystore in the `spec.secretName` Secret resource."
                          "properties" = {
                            "create" = {
                              "description" = "Create enables PKCS12 keystore creation for the Certificate. If true, a file named `keystore.p12` will be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef`. The keystore file will be updated immediately. If the issuer provided a CA certificate, a file named `truststore.p12` will also be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef` containing the issuing Certificate Authority"
                              "type" = "boolean"
                            }
                            "passwordSecretRef" = {
                              "description" = "PasswordSecretRef is a reference to a key in a Secret resource containing the password used to encrypt the PKCS12 keystore."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                          }
                          "required" = [
                            "create",
                            "passwordSecretRef",
                          ]
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "literalSubject" = {
                      "description" = "LiteralSubject is an LDAP formatted string that represents the [X.509 Subject field](https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6). Use this *instead* of the Subject field if you need to ensure the correct ordering of the RDN sequence, such as when issuing certs for LDAP authentication. See https://github.com/cert-manager/cert-manager/issues/3203, https://github.com/cert-manager/cert-manager/issues/4424. This field is alpha level and is only supported by cert-manager installations where LiteralCertificateSubject feature gate is enabled on both cert-manager controller and webhook."
                      "type" = "string"
                    }
                    "privateKey" = {
                      "description" = "Options to control private keys used for the Certificate."
                      "properties" = {
                        "algorithm" = {
                          "description" = "Algorithm is the private key algorithm of the corresponding private key for this certificate. If provided, allowed values are either `RSA`,`Ed25519` or `ECDSA` If `algorithm` is specified and `size` is not provided, key size of 256 will be used for `ECDSA` key algorithm and key size of 2048 will be used for `RSA` key algorithm. key size is ignored when using the `Ed25519` key algorithm."
                          "enum" = [
                            "RSA",
                            "ECDSA",
                            "Ed25519",
                          ]
                          "type" = "string"
                        }
                        "encoding" = {
                          "description" = "The private key cryptography standards (PKCS) encoding for this certificate's private key to be encoded in. If provided, allowed values are `PKCS1` and `PKCS8` standing for PKCS#1 and PKCS#8, respectively. Defaults to `PKCS1` if not specified."
                          "enum" = [
                            "PKCS1",
                            "PKCS8",
                          ]
                          "type" = "string"
                        }
                        "rotationPolicy" = {
                          "description" = "RotationPolicy controls how private keys should be regenerated when a re-issuance is being processed. If set to Never, a private key will only be generated if one does not already exist in the target `spec.secretName`. If one does exists but it does not have the correct algorithm or size, a warning will be raised to await user intervention. If set to Always, a private key matching the specified requirements will be generated whenever a re-issuance occurs. Default is 'Never' for backward compatibility."
                          "enum" = [
                            "Never",
                            "Always",
                          ]
                          "type" = "string"
                        }
                        "size" = {
                          "description" = "Size is the key bit size of the corresponding private key for this certificate. If `algorithm` is set to `RSA`, valid values are `2048`, `4096` or `8192`, and will default to `2048` if not specified. If `algorithm` is set to `ECDSA`, valid values are `256`, `384` or `521`, and will default to `256` if not specified. If `algorithm` is set to `Ed25519`, Size is ignored. No other values are allowed."
                          "type" = "integer"
                        }
                      }
                      "type" = "object"
                    }
                    "renewBefore" = {
                      "description" = "How long before the currently issued certificate's expiry cert-manager should renew the certificate. The default is 2/3 of the issued certificate's duration. Minimum accepted value is 5 minutes. Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration"
                      "type" = "string"
                    }
                    "revisionHistoryLimit" = {
                      "description" = "revisionHistoryLimit is the maximum number of CertificateRequest revisions that are maintained in the Certificate's history. Each revision represents a single `CertificateRequest` created by this Certificate, either when it was created, renewed, or Spec was changed. Revisions will be removed by oldest first if the number of revisions exceeds this number. If set, revisionHistoryLimit must be a value of `1` or greater. If unset (`nil`), revisions will not be garbage collected. Default value is `nil`."
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "secretName" = {
                      "description" = "SecretName is the name of the secret resource that will be automatically created and managed by this Certificate resource. It will be populated with a private key and certificate, signed by the denoted issuer."
                      "type" = "string"
                    }
                    "secretTemplate" = {
                      "description" = "SecretTemplate defines annotations and labels to be copied to the Certificate's Secret. Labels and annotations on the Secret will be changed as they appear on the SecretTemplate when added or removed. SecretTemplate annotations are added in conjunction with, and cannot overwrite, the base set of annotations cert-manager sets on the Certificate's Secret."
                      "properties" = {
                        "annotations" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = "Annotations is a key value map to be copied to the target Kubernetes Secret."
                          "type" = "object"
                        }
                        "labels" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = "Labels is a key value map to be copied to the target Kubernetes Secret."
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "subject" = {
                      "description" = "Full X509 name specification (https://golang.org/pkg/crypto/x509/pkix/#Name)."
                      "properties" = {
                        "countries" = {
                          "description" = "Countries to be used on the Certificate."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "localities" = {
                          "description" = "Cities to be used on the Certificate."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "organizationalUnits" = {
                          "description" = "Organizational Units to be used on the Certificate."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "organizations" = {
                          "description" = "Organizations to be used on the Certificate."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "postalCodes" = {
                          "description" = "Postal codes to be used on the Certificate."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "provinces" = {
                          "description" = "State/Provinces to be used on the Certificate."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "serialNumber" = {
                          "description" = "Serial number to be used on the Certificate."
                          "type" = "string"
                        }
                        "streetAddresses" = {
                          "description" = "Street addresses to be used on the Certificate."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                      }
                      "type" = "object"
                    }
                    "uris" = {
                      "description" = "URIs is a list of URI subjectAltNames to be set on the Certificate."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "usages" = {
                      "description" = "Usages is the set of x509 usages that are requested for the certificate. Defaults to `digital signature` and `key encipherment` if not specified."
                      "items" = {
                        "description" = <<-EOT
                        KeyUsage specifies valid usage contexts for keys. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3 https://tools.ietf.org/html/rfc5280#section-4.2.1.12 
                         Valid KeyUsage values are as follows: "signing", "digital signature", "content commitment", "key encipherment", "key agreement", "data encipherment", "cert sign", "crl sign", "encipher only", "decipher only", "any", "server auth", "client auth", "code signing", "email protection", "s/mime", "ipsec end system", "ipsec tunnel", "ipsec user", "timestamping", "ocsp signing", "microsoft sgc", "netscape sgc"
                        EOT
                        "enum" = [
                          "signing",
                          "digital signature",
                          "content commitment",
                          "key encipherment",
                          "key agreement",
                          "data encipherment",
                          "cert sign",
                          "crl sign",
                          "encipher only",
                          "decipher only",
                          "any",
                          "server auth",
                          "client auth",
                          "code signing",
                          "email protection",
                          "s/mime",
                          "ipsec end system",
                          "ipsec tunnel",
                          "ipsec user",
                          "timestamping",
                          "ocsp signing",
                          "microsoft sgc",
                          "netscape sgc",
                        ]
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                  }
                  "required" = [
                    "issuerRef",
                    "secretName",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = "Status of the Certificate. This is set and managed automatically."
                  "properties" = {
                    "conditions" = {
                      "description" = "List of status conditions to indicate the status of certificates. Known condition types are `Ready` and `Issuing`."
                      "items" = {
                        "description" = "CertificateCondition contains condition information for an Certificate."
                        "properties" = {
                          "lastTransitionTime" = {
                            "description" = "LastTransitionTime is the timestamp corresponding to the last status change of this condition."
                            "format" = "date-time"
                            "type" = "string"
                          }
                          "message" = {
                            "description" = "Message is a human readable description of the details of the last transition, complementing reason."
                            "type" = "string"
                          }
                          "observedGeneration" = {
                            "description" = "If set, this represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.condition[x].observedGeneration is 9, the condition is out of date with respect to the current state of the Certificate."
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "reason" = {
                            "description" = "Reason is a brief machine readable explanation for the condition's last transition."
                            "type" = "string"
                          }
                          "status" = {
                            "description" = "Status of the condition, one of (`True`, `False`, `Unknown`)."
                            "enum" = [
                              "True",
                              "False",
                              "Unknown",
                            ]
                            "type" = "string"
                          }
                          "type" = {
                            "description" = "Type of the condition, known values are (`Ready`, `Issuing`)."
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "status",
                          "type",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "type",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                    "failedIssuanceAttempts" = {
                      "description" = "The number of continuous failed issuance attempts up till now. This field gets removed (if set) on a successful issuance and gets set to 1 if unset and an issuance has failed. If an issuance has failed, the delay till the next issuance will be calculated using formula time.Hour * 2 ^ (failedIssuanceAttempts - 1)."
                      "type" = "integer"
                    }
                    "lastFailureTime" = {
                      "description" = "LastFailureTime is set only if the lastest issuance for this Certificate failed and contains the time of the failure. If an issuance has failed, the delay till the next issuance will be calculated using formula time.Hour * 2 ^ (failedIssuanceAttempts - 1). If the latest issuance has succeeded this field will be unset."
                      "format" = "date-time"
                      "type" = "string"
                    }
                    "nextPrivateKeySecretName" = {
                      "description" = "The name of the Secret resource containing the private key to be used for the next certificate iteration. The keymanager controller will automatically set this field if the `Issuing` condition is set to `True`. It will automatically unset this field when the Issuing condition is not set or False."
                      "type" = "string"
                    }
                    "notAfter" = {
                      "description" = "The expiration time of the certificate stored in the secret named by this resource in `spec.secretName`."
                      "format" = "date-time"
                      "type" = "string"
                    }
                    "notBefore" = {
                      "description" = "The time after which the certificate stored in the secret named by this resource in spec.secretName is valid."
                      "format" = "date-time"
                      "type" = "string"
                    }
                    "renewalTime" = {
                      "description" = "RenewalTime is the time at which the certificate will be next renewed. If not set, no upcoming renewal is scheduled."
                      "format" = "date-time"
                      "type" = "string"
                    }
                    "revision" = {
                      "description" = <<-EOT
                      The current 'revision' of the certificate as issued. 
                       When a CertificateRequest resource is created, it will have the `cert-manager.io/certificate-revision` set to one greater than the current value of this field. 
                       Upon issuance, this field will be set to the value of the annotation on the CertificateRequest resource used to issue the certificate. 
                       Persisting the value on the CertificateRequest resource allows the certificates controller to know whether a request is part of an old issuance or if it is part of the ongoing revision's issuance by checking if the revision value in the annotation is greater than this field.
                      EOT
                      "type" = "integer"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
resource "kubernetes_manifest" "customresourcedefinition_orders_acme_cert_manager_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "orders.acme.cert-manager.io"
    }
    "spec" = {
      "group" = "acme.cert-manager.io"
      "names" = {
        "categories" = [
          "cert-manager",
          "cert-manager-acme",
        ]
        "kind" = "Order"
        "listKind" = "OrderList"
        "plural" = "orders"
        "singular" = "order"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".status.state"
              "name" = "State"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.issuerRef.name"
              "name" = "Issuer"
              "priority" = 1
              "type" = "string"
            },
            {
              "jsonPath" = ".status.reason"
              "name" = "Reason"
              "priority" = 1
              "type" = "string"
            },
            {
              "description" = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "Order is a type to represent an Order with an ACME server"
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "properties" = {
                    "commonName" = {
                      "description" = "CommonName is the common name as specified on the DER encoded CSR. If specified, this value must also be present in `dnsNames` or `ipAddresses`. This field must match the corresponding field on the DER encoded CSR."
                      "type" = "string"
                    }
                    "dnsNames" = {
                      "description" = "DNSNames is a list of DNS names that should be included as part of the Order validation process. This field must match the corresponding field on the DER encoded CSR."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "duration" = {
                      "description" = "Duration is the duration for the not after date for the requested certificate. this is set on order creation as pe the ACME spec."
                      "type" = "string"
                    }
                    "ipAddresses" = {
                      "description" = "IPAddresses is a list of IP addresses that should be included as part of the Order validation process. This field must match the corresponding field on the DER encoded CSR."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "issuerRef" = {
                      "description" = "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Order. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Order will be marked as failed."
                      "properties" = {
                        "group" = {
                          "description" = "Group of the resource being referred to."
                          "type" = "string"
                        }
                        "kind" = {
                          "description" = "Kind of the resource being referred to."
                          "type" = "string"
                        }
                        "name" = {
                          "description" = "Name of the resource being referred to."
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "name",
                      ]
                      "type" = "object"
                    }
                    "request" = {
                      "description" = "Certificate signing request bytes in DER encoding. This will be used when finalizing the order. This field must be set on the order."
                      "format" = "byte"
                      "type" = "string"
                    }
                  }
                  "required" = [
                    "issuerRef",
                    "request",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "properties" = {
                    "authorizations" = {
                      "description" = "Authorizations contains data returned from the ACME server on what authorizations must be completed in order to validate the DNS names specified on the Order."
                      "items" = {
                        "description" = "ACMEAuthorization contains data returned from the ACME server on an authorization that must be completed in order validate a DNS name on an ACME Order resource."
                        "properties" = {
                          "challenges" = {
                            "description" = "Challenges specifies the challenge types offered by the ACME server. One of these challenge types will be selected when validating the DNS name and an appropriate Challenge resource will be created to perform the ACME challenge process."
                            "items" = {
                              "description" = "Challenge specifies a challenge offered by the ACME server for an Order. An appropriate Challenge resource can be created to perform the ACME challenge process."
                              "properties" = {
                                "token" = {
                                  "description" = "Token is the token that must be presented for this challenge. This is used to compute the 'key' that must also be presented."
                                  "type" = "string"
                                }
                                "type" = {
                                  "description" = "Type is the type of challenge being offered, e.g. 'http-01', 'dns-01', 'tls-sni-01', etc. This is the raw value retrieved from the ACME server. Only 'http-01' and 'dns-01' are supported by cert-manager, other values will be ignored."
                                  "type" = "string"
                                }
                                "url" = {
                                  "description" = "URL is the URL of this challenge. It can be used to retrieve additional metadata about the Challenge from the ACME server."
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "token",
                                "type",
                                "url",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                          }
                          "identifier" = {
                            "description" = "Identifier is the DNS name to be validated as part of this authorization"
                            "type" = "string"
                          }
                          "initialState" = {
                            "description" = "InitialState is the initial state of the ACME authorization when first fetched from the ACME server. If an Authorization is already 'valid', the Order controller will not create a Challenge resource for the authorization. This will occur when working with an ACME server that enables 'authz reuse' (such as Let's Encrypt's production endpoint). If not set and 'identifier' is set, the state is assumed to be pending and a Challenge will be created."
                            "enum" = [
                              "valid",
                              "ready",
                              "pending",
                              "processing",
                              "invalid",
                              "expired",
                              "errored",
                            ]
                            "type" = "string"
                          }
                          "url" = {
                            "description" = "URL is the URL of the Authorization that must be completed"
                            "type" = "string"
                          }
                          "wildcard" = {
                            "description" = "Wildcard will be true if this authorization is for a wildcard DNS name. If this is true, the identifier will be the *non-wildcard* version of the DNS name. For example, if '*.example.com' is the DNS name being validated, this field will be 'true' and the 'identifier' field will be 'example.com'."
                            "type" = "boolean"
                          }
                        }
                        "required" = [
                          "url",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "certificate" = {
                      "description" = "Certificate is a copy of the PEM encoded certificate for this Order. This field will be populated after the order has been successfully finalized with the ACME server, and the order has transitioned to the 'valid' state."
                      "format" = "byte"
                      "type" = "string"
                    }
                    "failureTime" = {
                      "description" = "FailureTime stores the time that this order failed. This is used to influence garbage collection and back-off."
                      "format" = "date-time"
                      "type" = "string"
                    }
                    "finalizeURL" = {
                      "description" = "FinalizeURL of the Order. This is used to obtain certificates for this order once it has been completed."
                      "type" = "string"
                    }
                    "reason" = {
                      "description" = "Reason optionally provides more information about a why the order is in the current state."
                      "type" = "string"
                    }
                    "state" = {
                      "description" = "State contains the current state of this Order resource. States 'success' and 'expired' are 'final'"
                      "enum" = [
                        "valid",
                        "ready",
                        "pending",
                        "processing",
                        "invalid",
                        "expired",
                        "errored",
                      ]
                      "type" = "string"
                    }
                    "url" = {
                      "description" = "URL of the Order. This will initially be empty when the resource is first created. The Order controller will populate this field when the Order is first processed. This field will be immutable after it is initially set."
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "metadata",
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
resource "kubernetes_manifest" "serviceaccount_cert_manager_cert_manager_cainjector" {
  manifest = {
    "apiVersion" = "v1"
    "automountServiceAccountToken" = true
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "cainjector"
        "app.kubernetes.io/component" = "cainjector"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cainjector"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-cainjector"
      "namespace" = var.namespace
    }
  }
}
resource "kubernetes_manifest" "serviceaccount_cert_manager_cert_manager" {
  manifest = {
    "apiVersion" = "v1"
    "automountServiceAccountToken" = true
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager"
      "namespace" = var.namespace
    }
  }
}
resource "kubernetes_manifest" "serviceaccount_cert_manager_cert_manager_webhook" {
  manifest = {
    "apiVersion" = "v1"
    "automountServiceAccountToken" = true
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook"
      "namespace" = var.namespace
    }
  }
}
resource "kubernetes_manifest" "configmap_cert_manager_cert_manager_webhook" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook"
      "namespace" = var.namespace
    }
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_cainjector" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cainjector"
        "app.kubernetes.io/component" = "cainjector"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cainjector"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-cainjector"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "get",
          "create",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "admissionregistration.k8s.io",
        ]
        "resources" = [
          "validatingwebhookconfigurations",
          "mutatingwebhookconfigurations",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "apiregistration.k8s.io",
        ]
        "resources" = [
          "apiservices",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "apiextensions.k8s.io",
        ]
        "resources" = [
          "customresourcedefinitions",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "update",
          "patch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_issuers" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-issuers"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "issuers",
          "issuers/status",
        ]
        "verbs" = [
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "issuers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_clusterissuers" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-clusterissuers"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "clusterissuers",
          "clusterissuers/status",
        ]
        "verbs" = [
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "clusterissuers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_certificates" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-certificates"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates",
          "certificates/status",
          "certificaterequests",
          "certificaterequests/status",
        ]
        "verbs" = [
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates",
          "certificaterequests",
          "clusterissuers",
          "issuers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates/finalizers",
          "certificaterequests/finalizers",
        ]
        "verbs" = [
          "update",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "orders",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "delete",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_orders" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-orders"
    }
    "rules" = [
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "orders",
          "orders/status",
        ]
        "verbs" = [
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "orders",
          "challenges",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "clusterissuers",
          "issuers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "challenges",
        ]
        "verbs" = [
          "create",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "orders/finalizers",
        ]
        "verbs" = [
          "update",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_challenges" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-challenges"
    }
    "rules" = [
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "challenges",
          "challenges/status",
        ]
        "verbs" = [
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "challenges",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "issuers",
          "clusterissuers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods",
          "services",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "networking.k8s.io",
        ]
        "resources" = [
          "ingresses",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "delete",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "gateway.networking.k8s.io",
        ]
        "resources" = [
          "httproutes",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "delete",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "route.openshift.io",
        ]
        "resources" = [
          "routes/custom-host",
        ]
        "verbs" = [
          "create",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "challenges/finalizers",
        ]
        "verbs" = [
          "update",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_ingress_shim" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-ingress-shim"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates",
          "certificaterequests",
        ]
        "verbs" = [
          "create",
          "update",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates",
          "certificaterequests",
          "issuers",
          "clusterissuers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "networking.k8s.io",
        ]
        "resources" = [
          "ingresses",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "networking.k8s.io",
        ]
        "resources" = [
          "ingresses/finalizers",
        ]
        "verbs" = [
          "update",
        ]
      },
      {
        "apiGroups" = [
          "gateway.networking.k8s.io",
        ]
        "resources" = [
          "gateways",
          "httproutes",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "gateway.networking.k8s.io",
        ]
        "resources" = [
          "gateways/finalizers",
          "httproutes/finalizers",
        ]
        "verbs" = [
          "update",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_view" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
        "rbac.authorization.k8s.io/aggregate-to-admin" = "true"
        "rbac.authorization.k8s.io/aggregate-to-edit" = "true"
        "rbac.authorization.k8s.io/aggregate-to-view" = "true"
      }
      "name" = "cert-manager-view"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates",
          "certificaterequests",
          "issuers",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "challenges",
          "orders",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_edit" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
        "rbac.authorization.k8s.io/aggregate-to-admin" = "true"
        "rbac.authorization.k8s.io/aggregate-to-edit" = "true"
      }
      "name" = "cert-manager-edit"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates",
          "certificaterequests",
          "issuers",
        ]
        "verbs" = [
          "create",
          "delete",
          "deletecollection",
          "patch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resources" = [
          "certificates/status",
        ]
        "verbs" = [
          "update",
        ]
      },
      {
        "apiGroups" = [
          "acme.cert-manager.io",
        ]
        "resources" = [
          "challenges",
          "orders",
        ]
        "verbs" = [
          "create",
          "delete",
          "deletecollection",
          "patch",
          "update",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_approve_cert_manager_io" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-approve:cert-manager-io"
    }
    "rules" = [
      {
        "apiGroups" = [
          "cert-manager.io",
        ]
        "resourceNames" = [
          "issuers.cert-manager.io/*",
          "clusterissuers.cert-manager.io/*",
        ]
        "resources" = [
          "signers",
        ]
        "verbs" = [
          "approve",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_controller_certificatesigningrequests" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-certificatesigningrequests"
    }
    "rules" = [
      {
        "apiGroups" = [
          "certificates.k8s.io",
        ]
        "resources" = [
          "certificatesigningrequests",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "certificates.k8s.io",
        ]
        "resources" = [
          "certificatesigningrequests/status",
        ]
        "verbs" = [
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "certificates.k8s.io",
        ]
        "resourceNames" = [
          "issuers.cert-manager.io/*",
          "clusterissuers.cert-manager.io/*",
        ]
        "resources" = [
          "signers",
        ]
        "verbs" = [
          "sign",
        ]
      },
      {
        "apiGroups" = [
          "authorization.k8s.io",
        ]
        "resources" = [
          "subjectaccessreviews",
        ]
        "verbs" = [
          "create",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrole_cert_manager_webhook_subjectaccessreviews" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook:subjectaccessreviews"
    }
    "rules" = [
      {
        "apiGroups" = [
          "authorization.k8s.io",
        ]
        "resources" = [
          "subjectaccessreviews",
        ]
        "verbs" = [
          "create",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_cainjector" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cainjector"
        "app.kubernetes.io/component" = "cainjector"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cainjector"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-cainjector"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-cainjector"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager-cainjector"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_issuers" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-issuers"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-issuers"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_clusterissuers" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-clusterissuers"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-clusterissuers"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_certificates" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-certificates"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-certificates"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_orders" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-orders"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-orders"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_challenges" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-challenges"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-challenges"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_ingress_shim" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-ingress-shim"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-ingress-shim"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_approve_cert_manager_io" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-approve:cert-manager-io"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-approve:cert-manager-io"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_controller_certificatesigningrequests" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "cert-manager"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-controller-certificatesigningrequests"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-controller-certificatesigningrequests"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "clusterrolebinding_cert_manager_webhook_subjectaccessreviews" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook:subjectaccessreviews"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cert-manager-webhook:subjectaccessreviews"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager-webhook"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "role_kube_system_cert_manager_cainjector_leaderelection" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app" = "cainjector"
        "app.kubernetes.io/component" = "cainjector"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cainjector"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-cainjector:leaderelection"
      "namespace" = "kube-system"
    }
    "rules" = [
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resourceNames" = [
          "cert-manager-cainjector-leader-election",
          "cert-manager-cainjector-leader-election-core",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "get",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "create",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "role_kube_system_cert_manager_leaderelection" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager:leaderelection"
      "namespace" = "kube-system"
    }
    "rules" = [
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resourceNames" = [
          "cert-manager-controller",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "get",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "create",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "role_cert_manager_cert_manager_webhook_dynamic_serving" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook:dynamic-serving"
      "namespace" = var.namespace
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resourceNames" = [
          "cert-manager-webhook-ca",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "create",
        ]
      },
    ]
  }
}
resource "kubernetes_manifest" "rolebinding_kube_system_cert_manager_cainjector_leaderelection" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cainjector"
        "app.kubernetes.io/component" = "cainjector"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cainjector"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-cainjector:leaderelection"
      "namespace" = "kube-system"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "cert-manager-cainjector:leaderelection"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager-cainjector"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "rolebinding_kube_system_cert_manager_leaderelection" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager:leaderelection"
      "namespace" = "kube-system"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "cert-manager:leaderelection"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "rolebinding_cert_manager_cert_manager_webhook_dynamic_serving" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook:dynamic-serving"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "cert-manager-webhook:dynamic-serving"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "cert-manager-webhook"
        "namespace" = var.namespace
      },
    ]
  }
}
resource "kubernetes_manifest" "service_cert_manager_cert_manager" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "name" = "tcp-prometheus-servicemonitor"
          "port" = 9402
          "protocol" = "TCP"
          "targetPort" = 9402
        },
      ]
      "selector" = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
      }
      "type" = "ClusterIP"
    }
  }
}
resource "kubernetes_manifest" "service_cert_manager_cert_manager_webhook" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "name" = "https"
          "port" = 443
          "protocol" = "TCP"
          "targetPort" = "https"
        },
      ]
      "selector" = {
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
      }
      "type" = "ClusterIP"
    }
  }
}
resource "kubernetes_manifest" "deployment_cert_manager_cert_manager_cainjector" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "cainjector"
        "app.kubernetes.io/component" = "cainjector"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cainjector"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-cainjector"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "cainjector"
          "app.kubernetes.io/instance" = "cert-manager"
          "app.kubernetes.io/name" = "cainjector"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "cainjector"
            "app.kubernetes.io/component" = "cainjector"
            "app.kubernetes.io/instance" = "cert-manager"
            "app.kubernetes.io/name" = "cainjector"
            "app.kubernetes.io/version" = "v1.13.0-alpha.0"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--v=2",
                "--leader-election-namespace=kube-system",
              ]
              "env" = [
                {
                  "name" = "POD_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
              ]
              "image" = "quay.io/jetstack/cert-manager-cainjector:v1.13.0-alpha.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "cert-manager-cainjector"
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "capabilities" = {
                  "drop" = [
                    "ALL",
                  ]
                }
              }
            },
          ]
          "enableServiceLinks" = false
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "runAsNonRoot" = true
            "seccompProfile" = {
              "type" = "RuntimeDefault"
            }
          }
          "serviceAccountName" = "cert-manager-cainjector"
        }
      }
    }
  }
}
resource "kubernetes_manifest" "deployment_cert_manager_cert_manager" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "cert-manager"
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "cert-manager"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "controller"
          "app.kubernetes.io/instance" = "cert-manager"
          "app.kubernetes.io/name" = "cert-manager"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "prometheus.io/path" = "/metrics"
            "prometheus.io/port" = "9402"
            "prometheus.io/scrape" = "true"
          }
          "labels" = {
            "app" = "cert-manager"
            "app.kubernetes.io/component" = "controller"
            "app.kubernetes.io/instance" = "cert-manager"
            "app.kubernetes.io/name" = "cert-manager"
            "app.kubernetes.io/version" = "v1.13.0-alpha.0"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--v=2",
                "--cluster-resource-namespace=$(POD_NAMESPACE)",
                "--leader-election-namespace=kube-system",
                "--acme-http01-solver-image=quay.io/jetstack/cert-manager-acmesolver:v1.13.0-alpha.0",
                "--max-concurrent-challenges=60",
              ]
              "env" = [
                {
                  "name" = "POD_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
              ]
              "image" = "quay.io/jetstack/cert-manager-controller:v1.13.0-alpha.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "cert-manager-controller"
              "ports" = [
                {
                  "containerPort" = 9402
                  "name" = "http-metrics"
                  "protocol" = "TCP"
                },
                {
                  "containerPort" = 9403
                  "name" = "http-healthz"
                  "protocol" = "TCP"
                },
              ]
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "capabilities" = {
                  "drop" = [
                    "ALL",
                  ]
                }
              }
            },
          ]
          "enableServiceLinks" = false
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "runAsNonRoot" = true
            "seccompProfile" = {
              "type" = "RuntimeDefault"
            }
          }
          "serviceAccountName" = "cert-manager"
        }
      }
    }
  }
}
resource "kubernetes_manifest" "deployment_cert_manager_cert_manager_webhook" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "webhook"
          "app.kubernetes.io/instance" = "cert-manager"
          "app.kubernetes.io/name" = "webhook"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "webhook"
            "app.kubernetes.io/component" = "webhook"
            "app.kubernetes.io/instance" = "cert-manager"
            "app.kubernetes.io/name" = "webhook"
            "app.kubernetes.io/version" = "v1.13.0-alpha.0"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--v=2",
                "--secure-port=10250",
                "--dynamic-serving-ca-secret-namespace=$(POD_NAMESPACE)",
                "--dynamic-serving-ca-secret-name=cert-manager-webhook-ca",
                "--dynamic-serving-dns-names=cert-manager-webhook",
                "--dynamic-serving-dns-names=cert-manager-webhook.$(POD_NAMESPACE)",
                "--dynamic-serving-dns-names=cert-manager-webhook.$(POD_NAMESPACE).svc",
              ]
              "env" = [
                {
                  "name" = "POD_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
              ]
              "image" = "quay.io/jetstack/cert-manager-webhook:v1.13.0-alpha.0"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/livez"
                  "port" = 6080
                  "scheme" = "HTTP"
                }
                "initialDelaySeconds" = 60
                "periodSeconds" = 10
                "successThreshold" = 1
                "timeoutSeconds" = 1
              }
              "name" = "cert-manager-webhook"
              "ports" = [
                {
                  "containerPort" = 10250
                  "name" = "https"
                  "protocol" = "TCP"
                },
                {
                  "containerPort" = 6080
                  "name" = "healthcheck"
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 6080
                  "scheme" = "HTTP"
                }
                "initialDelaySeconds" = 5
                "periodSeconds" = 5
                "successThreshold" = 1
                "timeoutSeconds" = 1
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "capabilities" = {
                  "drop" = [
                    "ALL",
                  ]
                }
              }
            },
          ]
          "enableServiceLinks" = false
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "runAsNonRoot" = true
            "seccompProfile" = {
              "type" = "RuntimeDefault"
            }
          }
          "serviceAccountName" = "cert-manager-webhook"
        }
      }
    }
  }
}
resource "kubernetes_manifest" "mutatingwebhookconfiguration_cert_manager_webhook" {
  manifest = {
    "apiVersion" = "admissionregistration.k8s.io/v1"
    "kind" = "MutatingWebhookConfiguration"
    "metadata" = {
      "annotations" = {
        "cert-manager.io/inject-ca-from-secret" = "cert-manager/cert-manager-webhook-ca"
      }
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook"
    }
    "webhooks" = [
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "cert-manager-webhook"
            "namespace" = var.namespace
            "path" = "/mutate"
          }
        }
        "failurePolicy" = "Fail"
        "matchPolicy" = "Equivalent"
        "name" = "webhook.cert-manager.io"
        "rules" = [
          {
            "apiGroups" = [
              "cert-manager.io",
              "acme.cert-manager.io",
            ]
            "apiVersions" = [
              "v1",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "*/*",
            ]
          },
        ]
        "sideEffects" = "None"
        "timeoutSeconds" = 10
      },
    ]
  }
}
resource "kubernetes_manifest" "validatingwebhookconfiguration_cert_manager_webhook" {
  manifest = {
    "apiVersion" = "admissionregistration.k8s.io/v1"
    "kind" = "ValidatingWebhookConfiguration"
    "metadata" = {
      "annotations" = {
        "cert-manager.io/inject-ca-from-secret" = "cert-manager/cert-manager-webhook-ca"
      }
      "labels" = {
        "app" = "webhook"
        "app.kubernetes.io/component" = "webhook"
        "app.kubernetes.io/instance" = "cert-manager"
        "app.kubernetes.io/name" = "webhook"
        "app.kubernetes.io/version" = "v1.13.0-alpha.0"
      }
      "name" = "cert-manager-webhook"
    }
    "webhooks" = [
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "cert-manager-webhook"
            "namespace" = var.namespace
            "path" = "/validate"
          }
        }
        "failurePolicy" = "Fail"
        "matchPolicy" = "Equivalent"
        "name" = "webhook.cert-manager.io"
        "namespaceSelector" = {
          "matchExpressions" = [
            {
              "key" = "cert-manager.io/disable-validation"
              "operator" = "NotIn"
              "values" = [
                "true",
              ]
            },
            {
              "key" = "name"
              "operator" = "NotIn"
              "values" = [
                "cert-manager",
              ]
            },
          ]
        }
        "rules" = [
          {
            "apiGroups" = [
              "cert-manager.io",
              "acme.cert-manager.io",
            ]
            "apiVersions" = [
              "v1",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "*/*",
            ]
          },
        ]
        "sideEffects" = "None"
        "timeoutSeconds" = 10
      },
    ]
  }
}
