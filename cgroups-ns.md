# C groups and namespaces lab

## Usage

```bash
docker build -t cgroups-namespaces-lab .

docker run -it --rm --name lab_container --privileged cgroups-namespaces-lab

# inside container

## Check cgroups:

cat /proc/self/cgroup

# listns
ls -l /proc/$$/ns
```
