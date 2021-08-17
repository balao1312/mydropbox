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


## Deployment yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
  labels:
    app: nginx
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

## Deployment rollout status, undo
```
kubectl rollout status deployment deployment-name
kubectl rollout undo deployment deployment-name
```


## DaemonSet yaml
```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: test-ds
  labels:
    app: nginx
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
#      tolerations:
#      - key: node-role.kubernetes.io/master
#        effect: NoSchedule
      containers:
      - name: nginx-server
        image: nginx
```

## StatefulSet yaml
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: test-sts
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  serviceName: "nginx"
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx-server
        image: balao1312/amd_print_test
```

## Job yaml
```
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  template:
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  completions: 5
  #parallelism: 2
  #activeDeadlineSeconds: 3
  backoffLimit: 4
```


## job deadline seconds  
activDeadlineSeconds 的順序比 backoffLimit 還要前面  
所以只要時間超過而結束，job就不會去判斷 BackoffLimit 有沒有達到


## Cronjob yaml
```
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: pi
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: pi
            image: perl
            command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
          restartPolicy: Never
      completions: 5
      #parallelism: 2
      #activeDeadlineSeconds: 3
      backoffLimit: 4
```

