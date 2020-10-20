# alpine-sshd
alpine linux base sshd image

## How to use
1. pull image
```
docker pull kairos9603/alpine-sshd:v0.0.1
```

2. create container
```
docker run -d -p 2222:22 --name alpine-sshd kairos9603/alpine-sshd:v0.0.1
```

3. connect to container via ssh
```
ssh root@localhost -p 2222
```

> Info: Default root password is `P@ssw0rd`
