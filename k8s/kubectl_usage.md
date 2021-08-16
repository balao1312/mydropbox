## Remove taint
```
kubectl taint nodes k8s-dev node-role.kubernetes.io/master:NoSchedule-
```
> Note: - sign after NoSchedule for delete

## Label node
```
kubectl label node k8s-dev node=vm
```


## Label filter
```
kubectl get pods -l run:test
```

## Create with yaml
```
kubectl create -f introduction/pob/basic.yaml
kubectl delete -f introduction/pob/basic.yaml
```

## Edit exsiting pod
```
kubectl edit pod pod-name
```
> Note: hard to track previous changes


## Replace current pod
```
kubectl get pod myapp-pod -o yaml > new.yaml
(then do change to new.yaml)
kubectl replace -f new.yaml
```
> Note: steps too complex


## kubectl apply (mostly used)
```
kubectl apply -f some.yaml
```

## Control specific container in pod
```
kubectl logs -f some-pod -c container-name
kubectl exec -it some-pod -c container-name bash
```

## Pod yaml
```
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: test
    image: hwchiu/netutils
    # image: nginx
```


## Replica Set yaml
```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: test-rs
  labels:
    app: nginx-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx-server
        image: nginx
```



