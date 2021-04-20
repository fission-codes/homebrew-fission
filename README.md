# homebrew-fission

Homebrew tap formula for [@fission-suite](https://github.com/fission-suite) tools.

## Installation

The Fission CLI is currently available via homebrew on Intel macs and Linux. 

```sh
brew install fission-suite/fission/fission-cli
```

### M1 (Apple Silicon) Macs

A native `arm64` version of the fission CLI is not yet available. When support is ready in the haskell compiler, we will ship native binaries. In the meantime, the fission CLI runs under "Rosetta 2" emulation. To get this working:

1. Ensure Rosetta 2 is installed: `softwareupdate --install-rosetta`
2. Install the `x86_64` version of homebrew: `arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"` 
  (this will install a separate version of homebrew in `/usr/local` for x86_64 tools)
3. Install the fission cli via: `arch -x86_64 /usr/local/bin/brew install fission-suite/fission/fission-cli`

The fission CLI will now be available at `/usr/local/bin/fission`

*Note* For convenience you may want to add something like `alias ibrew='arch -x86_64 /usr/local/bin/brew'` to your shell configuration for managing intel formulae using `ibrew COMMAND` (e.g. `ibrew install fission-suite/fission/fission-cli`). 