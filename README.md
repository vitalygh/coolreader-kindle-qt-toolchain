## How to build Cool Reader 3 for Kindle 4NT

```sh
git clone https://github.com/vitalygh/coolreader-kindle-qt-toolchain.git
cd coolreader-kindle-qt-toolchain
./build.sh
```

You can replace specified fork with your own repositary in build-coolreader.sh
```sh
libdir=coolreader-kindle-qt
liburl=https://github.com/vitalygh/$libdir
```

For rebuilding app after making changes, remove ```/final``` and ```/libs/cr3-bin```, then run ```build.sh``` again

#### Dependencies

Lubuntu 22.04
```sh
build-essentials pkg-config
```

Arch Linux
```sh
git wget make gcc
```

Gentoo
```sh
dev-vcs/git
```
