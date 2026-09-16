# get_scifor

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
        uses: SciFortran/get_scifor@main
      - run: |
          echo "Using $SCIFOR_RELEASE"
          make
```

The action chooses the newest published `scifor-*` prerelease by default.
Set `with: release: scifor-4.23.13-1234abcd` to install a specific release.
The `release` input chooses the binary package; the `@main` reference chooses
the version of this action. For a reproducible build, pin this action to a
commit SHA and provide an explicit `release` tag.

Later steps receive `PKG_CONFIG_PATH`, `GLOB_INC`, `GLOB_LIB`, `SCIFOR_ROOT`
and `SCIFOR_RELEASE`. The action also exposes `release` and `root` outputs.
The package contains `libscifor.a`, Fortran module files and `scifor.pc`.
Fortran `.mod` files require a compatible compiler and MPI setup.

The action reads public releases from `SciFortran/SciFortran` using the
caller's `github.token`; `contents: read` is sufficient. An optional `token`
input overrides it.
