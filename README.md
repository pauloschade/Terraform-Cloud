
# Terraform Cloud Setup Guide

## Dependencies

* `python3`
* `terraform`
* `aws-cli` (optional, for managing AWS keys)

## Configuring AWS Credentials

Run the following command to set up your AWS credentials:

```bash
aws configure 
```

Then, enter your access keys:

```
AWS Access Key ID [None]: {ACCESS_KEY}
AWS Secret Access Key [None]: {SECRET_ACCESS_KEY}
```

## Usage

### Features
* The project enables creation and deletion of instances, security groups, and security group rules.
* You can change the working region (US-EAST-1 or US-WEST-1).
* User accounts can be created, with optional restriction to a specific region (`us-east-1`) or not.
* A VPC is automatically created for the machines.
* An auto-scaling group (HA) is set up automatically. To test, stop an instance created by the HA (identified by a "-"), and the system will bring it back up.

**Note**: Instances created manually will not be part of the auto-scaling group.

### How to Use

Run the following command and follow the instructions:

```bash
python3 main.py
```

### Additional Notes

* The default region is `us-east-1`.
* JSON files (`tfvars.json` for `us-east-1` and `tfvars_alternate.json` for `us-west-1`) are used to manage changes.
* To initialize, select option `4` (Run Terraform) and then option `0` (Init). **Note**: Running Init will erase the contents of the JSON files.
* To confirm any changes (instances, security groups, security group rules, or users), choose option `4` (Run Terraform) followed by option `1` (Deploy Instances - runs `terraform apply`).
* To delete everything in the current region, choose option `4` (Run Terraform) followed by option `2` (Destroy Instances - runs `terraform destroy`).
