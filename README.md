To get the repo:

```shell
git clone https://github.com/PlanitarInc/test-paas-options
cd test-paas-options
git submodule init
git sumbodule update
```

To run docker scenario on your system:

```shell
make build
make docker
```

To run coreos cluster of 5 virtual machines run by VirtualBox on your system:

```shell
cd coreos
make
make deploy
```

When you're finished, run:

```shell
make clean
```
