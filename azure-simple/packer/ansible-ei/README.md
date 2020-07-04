# WSO2 Enterprise Integrator Ansible scripts

This repository contains the Ansible scripts for installing and configuring WSO2 Enterprise Integrator.

## Supported Operating Systems
- Ubuntu 16.04 or higher
- CentOS 7

## Supported Ansible Versions

- Ansible 2.8.0

## Directory Structure
```
.
├── dev
│   ├── group_vars
│   │   └── all.yml
|   |   └── integrator.yml
|   |
│   ├── host_vars
│   │   ├── integrator_1.yml
│   └── inventory
├── files
│   ├── lib
│   │   ├── amazon-corretto-8.242.08.1-linux-x64.tar.gz
│   │   └── mysql-connector-java-5.1.48-bin.jar
│   └── packs
│       └── wso2ei-6.6.0.zip
├── issue_template.md
├── LICENSE
├── pull_request_template.md
├── README.md
├── roles
│   ├── common
│   │   └── tasks
│   │       ├── custom.yml
│   │       └── main.yml
│   └── integrator
│       ├── tasks
│       │   ├── custom.yml
│       │   └── main.yml
│       └── templates
│           ├── carbon-home
│           │   ├── bin
│           │   │   └── integrator.sh.j2
│           │   ├── conf
│           │   │   ├── axis2
│           │   │   │   └── axis2.xml.j2
│           │   │   ├── carbon.xml.j2
│           │   │   ├── datasources
│           │   │   │   └── master-datasources.xml.j2
│           │   │   ├── jndi.properties.j2
│           │   │   ├── registry.xml.j2
│           │   │   ├── synapse.properties.j2
│           │   │   ├── tomcat
│           │   │   │   └── catalina-server.xml.j2
│           │   │   └── user-mgt.xml.j2
│           │   └── repository
│           │       └── deployment
│           │           └── server
│           │               └── eventpublishers
│           │                   ├── MessageFlowConfigurationPublisher.xml.j2
│           │                   └── MessageFlowStatisticsPublisher.xml.j2
│           └── wso2ei-integrator.service.j2
├── scripts
│   ├── update.sh
│   └── update_README.md
└── site.yml
```

## Packs to be Copied

Copy the following files to `files/packs` directory.

1. [WSO2 Enterprise Integrator 6.6.0 package](https://wso2.com/integration/install/)

Copy the following files to `files/lib` directory.

1. [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/5.1.html)
2. [Amazon Coretto for Linux x64 JDK](https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/downloads-list.html)

## Running WSO2 Enterprise Integrator Ansible scripts

### 1. Run the existing scripts without customization
The existing Ansible scripts contain the configurations to set-up WSO2 Enterprise Integrator. In order to deploy that, you need to replace the `[ip_address]` and `[ssh_user]` given in the `inventory` file under `dev` folder by the IP of the location where you need to host the Enterprise Integrator and the SSH user. An example is given below.
```
[ei]
integrator_1 ansible_host=localhost ansible_user=wso2carbon ansible_connection=local
```

Run the following command to run the scripts.

`ansible-playbook -i dev/inventory site.yml`

If you need to alter the configurations given, please change the parameterized values in the yaml files under `group_vars` and `host_vars`.

### 2. Customize the WSO2 Ansible scripts

The templates that are used by the Ansible scripts are in j2 format in-order to enable parameterization.

#### Step 1
Uncomment the following line in `main.yml` under the role you want to customize.
```
- import_tasks: custom.yml
```

#### Step 2
Add the configurations to the `custom.yml`. A sample is given below.

```
- name: "Copy custom file"
  template:
    src: path/to/example/file/example.xml.j2
    dest: destination/example.xml.j2
  when: "(inventory_hostname in groups['sp'])"
```

Follow the steps mentioned under `docs` directory to customize/create new Ansible scripts and deploy the recommended patterns.
