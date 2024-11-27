# Argo Workflows

Create a test workflow

````

k -n argo create -f hello-wf.yaml
````

Minio

````

k port-forward svc/minio 9001:9001
````

admin / pasword

Configuration for archiving logs
````
k get configmap worklfow-controller-configmap -o yaml
````

Create workflow with argo cli

````
argo -n argo submit input-template.yaml

argo -n argo list

argo -n argo delete wf-input-template


````

Override parameters

````

argo -n argo submit input-template.yaml -p message1="Override message 1"

argo -n argo submit input-template.yaml --parameter-file params-input.yaml
````

Create a Workflow template

````
argo -n argo template create workflow-template.yaml

argo templates list

````
## Submit template to create a new workflow

````
argo -n argo submit --from workflowtemplate/wf-template-dag
````

Update template after change

````
argo -n argo template delete wf-template-dag

argo -n argo tempalte create workflowtemplate/wf-template-dag

````

Or update via kubectl

````
k -n argo apply -f <file name>
````

## Cluster Template

````

argo -n argo cluster-template create cluster-wf-template.yaml

argo -n argo cluster-template list

````


https://www.youtube.com/watch?v=XNXJtxkUKeY
