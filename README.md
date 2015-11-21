#leroy-geek-nz

Personal website of Leroy Hopson: [leroy.geek.nz](http://leroy.geek.nz).

## Overview
This website uses [haskell](https://haskell.org) for the backend (specifically [scotty](https://github.com/scotty-web/scotty))
and [elm](https://elm-lang.org) for the frontend.
Source code for the backend can be found in `src/backend`, while source code for the frontend is in `src`.
The backend is managed using [stack](https://github.com/commercialhaskell/stack) and [cabal](https://www.haskell.org/cabal).

## Quick Start
From the projects root directory:
```
./run.sh
```

## Nix

Deployment of the website is managed by [NixOps](https://nixos.org/nixops/).
There are several nix files:

- `backend.nix`
The nix expression for the haskell backend which is managed entirely using cabal.
This nix expression is generated automatically using [cabal2nix](https://github.com/NixOS/cabal2nix).

- `default.nix`
The nix expression for the websites dependencies.
When imported into a container it will build the backend,
compile elm modules, and copy over any assets.

- `configuration.nix`
The nix expression for the nixos container that the website will run in.
It depends on `default.nix` and defines a systemd service for running
the server. The container can be run using [nixos-shell](https://github.com/chrisfarms/nixos-shell).

- `nix/network.nix`
The nix expression for the network of machines required to run the website.
In this case, only a single machine is required. This machine runs the
container defined in `configuration.nix`.

- `nix/staging.nix`
The nix expression for a staging deployment.
This deployment will run the website in a virtual machine.

- `nix/production.nix`
The nix expression for a production deployment.
