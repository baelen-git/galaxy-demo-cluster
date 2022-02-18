module "iks" {
  source  = "terraform-cisco-modules/iks/intersight"
  version = "2.2.1"

  infraConfigPolicy = {
    use_existing       = false
    platformType       = "esxi"
    policyName         = "gffa-hx2-esxi"
    description        = "Deploy IKS on HX2 esxi Cluster in GGFA"
    interfaces         = ["DV_VLAN1056"]
    vcTargetName       = "gffa-vcenter.galaxy.cisco.com"
    vcClusterName      = "GFFA-HX2-Cluster"
    vcDatastoreName    = "CCPDatastore"
    vcPassword         = var.vc_password
    vcResourcePoolName = ""
  }

  k8s_network = {
    use_existing = false
    name         = "network"
    pod_cidr     = "100.65.0.0/16"
    service_cidr = "100.64.3.0/24"
  }

  # Version policy
  versionPolicy = {
    useExisting    = false
    policyName     = "1.20.4"
    iksVersionName = "1.20.14-iks.0"
  }

  # IP Pool Information
  ip_pool = {
    use_existing        = false
    name                = "ippool"
    ip_starting_address = "10.100.56.10"
    ip_pool_size        = "20"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "10.100.56.1"
    dns_servers         = ["10.2.1.172"]
  }

  # Network Configuration Settings
  sysconfig = {
    use_existing = false
    name         = "sysconfig"
    domain_name  = "galaxy.cisco.com"
    timezone     = "America/New_York"
    ntp_servers  = ["pool.ntp.org"]
    dns_servers  = ["10.2.1.172"]
  }

  instance_type = {
    use_existing = false
    name         = "small"
    cpu          = 2
    memory       = 8192
    disk_size    = 40
  }

  # Cluster information
  cluster = {
    name                = "baelen-terraform"
    action              = "Unassign"
    wait_for_completion = false
    ssh_user            = "iksadmin"
    ssh_public_key      = var.ssh_key
    worker_nodes        = 3
    control_nodes       = 1
    worker_max          = 4
    load_balancers      = 3
  }
  # Organization
  organization = "tenant-a"
  tags         = var.tags

  addons = [
    {
      createNew       = true
      addonPolicyName = "smm-tf"
      addonName       = "smm"
      description     = "SMM Policy"
      upgradeStrategy = "AlwaysReinstall"
      installStrategy = "InstallOnly"
      releaseVersion  = "1.8.1-cisco2-helm3"
      overrides       = yamlencode({ "demoApplication" : { "enabled" : true } })
    }
  ]

  runtime_policy = {
    use_existing = false
    create_new   = false
  }

  tr_policy = {
    use_existing = false
    create_new   = false
  }
}

