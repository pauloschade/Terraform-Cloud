# Terraform-Cloud
Dependências:

* python3
* terraform
* aws-cli (caso deseje utilizar para gerenciar chaves)


## configurando credencias:

rode
```
aws configure 
```

configure com suas chaves
```
AWS Access Key ID [None]: {ACCESS_KEY}
AWS Secret Access Key [None]: {SECRET_ACCESS_KEY}
```

## Utilização

### features
* O projeto permite a criar e deletar instâncias, security groups e regras de security groups
* É possível alterar a região de trabalho (US-EAST-1 ou US-WEST-1)
* É possível criar usuários (com limitacões a uma região (us-east-1), ou não)
* É criada automaticamente uma VPC para as máquinas
* É criado automaticamente um HA (para testar pare uma instância - criada pelo HA (terá o nome "-") - e veja que o sistema a subirá de volta), as instâncias criadas por você não faram parte do auto-scalling group

### como usar?
rode o comando a seguir e siga as instruções
```
python3 main.py
```
