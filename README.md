# SciFortran Checkout

A composite GitHub Action that installs the dependencies and a published
[SciFortran](https://github.com/SciFortran/SciFortran) binary release on
`ubuntu-24.04` (x86_64) or `macos-15` (arm64). It does not compile SciFortran.

```yaml
permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-24.04
    steps:
      - uses: actions/checkout@v4
      - id: scifor
        uses: SciFortran/checkout@main
      # Add this project's own configure/build steps here.
```

The action chooses the newest published `scifor-*` prerelease by default.
Set `with: release: scifor-4.23.13-1234abcd` to install a specific release.
The `release` input chooses the binary package; the `@main` reference chooses
the version of this action. For a reproducible build, pin this action to a
commit SHA and provide an explicit `release` tag.

Later steps in the same job receive `PKG_CONFIG_PATH`, `SFROOT`,
`SCIFOR_ROOT`, `SCIFOR_RELEASE`, `LIBRARY_PATH`, `LD_LIBRARY_PATH`,
`INCLUDE_PATH`, `FC=mpif90`, `GLOB_INC` and `GLOB_LIB`. This is the
release-package equivalent of loading the SciFortran environment module.
The action also exposes `release` and `root` outputs. These environment
variables do not cross job boundaries; call the action in each job that
needs SciFortran.
The package contains `libscifor.a`, Fortran module files and `scifor.pc`.
Fortran `.mod` files require a compatible compiler and MPI setup.

The action reads public releases from `SciFortran/SciFortran` using the
caller's `github.token`; `contents: read` is sufficient. An optional `token`
input overrides it.
