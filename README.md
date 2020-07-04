#Terraform Resources for WSO2 Enterprise Integrator

## Installation

### Prerequisites

* Install and set up [Packer](https://www.packer.io/) (>= v1.4.0 )
* Install and set up [Terraform](https://www.terraform.io/) (>= v0.12.00 )


### Instructions:

1. Download the WSO2 Enterprise Integrator terraform resource.

 ```bash
   $ git clone https://github.com/wso2/terraform-is.git
  ```   

2. Build the Enterprise Integrator custom image using centos-base.json packer file.

   **Note:**  If you have an Azure subscription, update user variables `centos-base.json` in root directory `azure-simple/packer` to include your subscription credentials. The WSO2 Enterprise Integrator 6.6.0 distribution needs to download into the `azure-simple/packer/ansible-ei/files/packs` directory.

   ```bash
   $ packer build centos-base.json 
   ```

3. Changed the directory to `azure-simple/terraform`  and update the build `baseimage` in `variables.tf` and `terraform.tfvars`  files inclusive of Azure subscription credentials.

   ```bash
   $ terraform apply  
   ```

   **Note:**  Add the host entry `<PUBLIC-IP> ei.wso2test.com` in `/etc/hosts` file to access the WSO2 Enterprise Integrator console. 
 
4. Try navigating to the following consoles from your favorite browser.

   **https://ei.wso2test.com**
