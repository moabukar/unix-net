# K8s Networking

- All things networking in the k8s space

### DNS Lookups in Services

- Kubernetes uses a DNS server to provide service discovery for pods

```bash
kubectl exec -it <pod-name> -- nslookup <service-name>
kubectl exec -it <pod-name> -- dig <service-name>
kubectl exec -it <pod-name> -- getent hosts <service-name>
```

### Checking Pod Connectivity

- Ensure that pods can communicate with each other as expected.

```bash
kubectl exec -it <pod-name-1> -- ping <pod-name-2>
kubectl exec -it <pod-name-1> -- curl <pod-name-2>:<port>
```

### Pod networking

- Check pod to pod connectivity (2)

```bash
kubectl run web --image=httpd
kubectl get pod -o wide

## Test pod net
kubectl run client -it --image=busybox
ip a
ping -c 3 <WEB POD IP>
wget -qO - <WEB POD IP>
```

### Service routing

- How are services routes via kube-proxy

```bash
## check svc the NAT table:
sudo iptables -L -vn -t nat | grep '<YOUR SERVICE CLUSTER IP>'
## rule chain
sudo iptables -L -vn -t nat | grep -A4 '<CHAIN NAME>'
```

### Network plugins (CNI)

- Kubernetes supports various CNI plugins for network configuration.
  - Common plugins: Flannel, Calico, Weave, Cilium

### Debugging Network Issues

- Debug network issues using logs and network tools.

```bash
kubectl logs <network-pod-name> -n kube-system
kubectl exec -it <pod-name> -- ifconfig
kubectl exec -it <pod-name> -- netstat -an
```

### Port Forwarding

- Forward local ports to a pod for testing purposes.

```bash
kubectl port-forward <pod-name> <local-port>:<pod-port>
kubectl port-forward svc/<service-name> <local-port>:<service-port>
```

### Ingress controllers

- Ingress resources manage external access to services, typically HTTP.
  - Examples of ingress controller include: NGINX, Traefik, HAProxy and more. 
- For ingress in K8s to work, you need to create ingress controllers and then you can setup an ingress to a certain service. Ingress controllers will generally spin up load balancer type of services in your cloud provider where the cluster lives. 

### Service mesh

- Service mesh provides additional features like traffic management, security, and observability.
