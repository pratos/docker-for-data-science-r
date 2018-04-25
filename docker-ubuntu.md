### Docker setup for Ubuntu:

- Setting up the repository:

```bash
sudo apt-get update
```

- Install packages required

```bash
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

- Adding Docker GPG Key:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

- Verifying the key for the download:

```bash
sudo apt-key fingerprint 0EBFCD88
```

- Expected output:

```bash
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
OK

sudo apt-key fingerprint 0EBFCD88
pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
```

- Since we are concerned with `stable` version, we'll be setting up that repository:

```bash
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

- Updating the package index so that we can view `docker-ce`:

```bash
sudo apt-get update
```

- Installing `docker`:

```bash
sudo apt-get install docker-ce
```

- To check which versions of `docker` are available:

```bash
apt-cache madison docker-ce
```

- A snapshot of versions available:

```bash
docker-ce | 18.03.0~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.12.1~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.12.0~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.09.1~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.09.0~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.06.2~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.06.1~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.06.0~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.03.2~ce-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.03.1~ce-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
 docker-ce | 17.03.0~ce-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
```

- Putting in the version required:

```bash
sudo apt-get install docker-ce=<VERSION>
```

- We need to add, user (you) to the `docker user group` (Source: [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)):

```bash
$ sudo usermod -aG docker ${USER}
$ su - ${USER}
$ id -nG
```

All this should be enough to install docker on your Ubuntu system.

- Installing `docker-compose`:

```bash
$ sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

$ sudo chmod +x /usr/local/bin/docker-compose

$ docker-compose --version
docker-compose version 1.20.1, build 1719ceb
```

- Installing `docker-machine`:

```bash
$ curl -L https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
sudo install /tmp/docker-machine /usr/local/bin/docker-machine
```
