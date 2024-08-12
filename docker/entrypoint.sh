#!/bin/bash
echo "Welcome to the Docker cgroups and namespaces lab!"

# Display cgroup information
echo "Cgroups information:"
cat /proc/self/cgroup

# Display namespace information
echo "Namespace information:"
ls -l /proc/$$/ns

# Keep the container running for further inspection
exec /bin/bash
