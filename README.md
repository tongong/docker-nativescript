# docker-nativescript

This projects aims to provide an up-to-date (November 2022) dockerized version
of NativeScript and its dependencies.

- [NativeScript](https://www.nativescript.org/) (8.3.3)
- [Android SDK Tools](https://developer.android.com/) (33.0.0)
- [Android SDK Platform](https://developer.android.com/) (32)
- [Gradle](https://gradle.org/) (7.4)
- [NodeJS](https://nodejs.org/) (19.1.0)
- [Java](https://www.java.com/) (17.0.5)
- [Ubuntu](https://www.ubuntu.com/) (22.04)

This project is based on:
- https://github.com/kristophjunge/docker-nativescript
- https://v7.docs.nativescript.org/angular/start/ns-setup-linux

Testing was done exclusively with podman but it should work on docker as well.

## usage
Build the image in the directory of the Dockerfile:
```
podman build -t nativescript .
```

To conveniently use the container source the `bashrc.sc`. This introduces an
alias `dprefix` to run commands inside the container. For example:
```
dprefix bash
dprefix ns create my-project
dprefix ns run android
```

## live development
The `--privileged` flag allows the container to access your USB devices. This
enables live development. Be sure to stop the `adb` server of your host machine
to make `adb` work inside the container. Then live development should work
with `dprefix ns run android`.

## android emulator
This image does not include an emulator (and I do not know of a way to make the
Android emulator work inside a container).
