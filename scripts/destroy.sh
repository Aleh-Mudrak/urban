#!/bin/bash
### Destroy Infrastructure

ScriptStarted="$(date +%s)"
startFolder=$PWD

cd ../tf-code/infrustructure
terraform destroy -var-file ../variables/infr.tfvars -auto-approve

cd $startFolder
ScriptTakes=$(($(date +%s)-$ScriptStarted))
echo -e "\n###### Finish ###### Job takes $(date -d@$ScriptTakes -u +%M:%S) (min:sec)\n"
