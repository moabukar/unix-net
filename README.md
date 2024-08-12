# UNIX networking (unix, containers, k8s etc)

Repo documenting all my networking in the unix, containers and k8s space.

Note: converting markdown files to pdf:

```bash
brew install pandoc
brew install wkhtmltopdf # or brew install weasyprint

pandoc docker-net.md -o docker-net.pdf --pdf-engine=wkhtmltopdf ## using wkhtmltopdf
# alt
pandoc k8s-net.md -o k8s-net.pdf --pdf-engine=weasyprint ## using weasyprint
```

- [Networking Basics](./net-theory/basics.md)
    - [DNS](./net-theory/dns.md)
    - [NAT](./net-theory/nat.md)
- [UNIX Networking labs](./unix-net.md)
- [UNIX Networking Troubleshoot & Advanced Networking Tools](./net-shoot.md)
- [CGroups & Namespaces in UNIX](./cgroups-ns.md)
- [Docker Networking](./docker-net.md)
- [K8s Networking](./k8s-net.md)
- [AWS Networking](./aws-net.md)
    - [AWS Networking Basics](./aws/aws-net.md)
    - [AWS Networking Labs](./aws/aws-net-labs.md)
    - [EC2 Networking](./aws/ec2-net.md)


TODO
- [] Security
- [] Firewalls
- [] Azure Networking
- [] GCP Networking
 
If you think of anything useful, please feel free to make a PR and add or raise an issue 🙏
