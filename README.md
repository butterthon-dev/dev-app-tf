### 実行計画
``` shell
terraform plan -var-file="secret.tfvars"
```

### 適用
``` shell
terraform apply -var-file="secret.tfvars"
```

### リソース指定で実行
``` shell
terraform apply -target="{module}.{name}" -var-file="secret.tfvars"
```

### 構成ファイル指定で実行
``` shell
terraform apply `cat ./{構成ファイル名}.tf | terraform fmt - | grep -E 'resource |module ' | tr -d '"' | awk '{printf("-target=%s.%s ", $2,$3);}'` -var-file="secret.tfvars"
```
