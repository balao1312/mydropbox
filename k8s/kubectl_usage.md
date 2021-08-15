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


