# Intro

The next generation of my dotfiles.

# Installation

```
$ git clone git@bitbucket.org:vyorkin/dotfiles.git ~/.dotfiles --recursive
$ cd ~/.dotfiles
$ make
```

# Setup

If you use iTerm2, enable "Applications in terminal may access system clipboard"

Some of the installed software requires additional setup, so examine the Brewfile and run `brew info someting` and `brew cask info something` to find out your post-installation steps.
I've tried hard to do this for you, so you may not require to do anyting at all, but I probably missed smth.
Optionally you may want to install [karabiner elements](https://github.com/tekezo/Karabiner-Elements).
Here are some things you should do manually.

#### Arch

I use [pacmanity](https://github.com/DerekTBrown/pacmanity) to
keep a list of installed packages in a gist & bulk-install them on a new machine.

#### Elixir & Phoenix

Phoenix should be installed manually:

```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
```

My emacs config for [alchemist](https://github.com/tonini/alchemist.el) relies on
[elixir sources](https://github.com/elixir-lang/elixir.git) available at the following path: `~/projects/github/elixir`.

##### OpenSSL

Start the periodic task to sync OSX Keychain certs to Homebrew installed OpenSSL & LibreSSL:

```
brew services start openssl-osx-ca
```

##### Haskell

Global packages:

```
stack install hindent stylish-haskell hlint hoogle
```

```
stack install weeder --resolver=nightly
```

```
stack install hasktags haskdogs fast-tags present
```

```
stack install happy alex cpphs hpack pandoc summoner
```

Dhall:

```
stack install dhall-json dhall
```

Build the hoogle search index:

```
stack hoogle -- generate --local
```

ghc-mod:

It is used inside HIE, so there is no need to install it separately.
Note that `ghc-mod` doesn't support newer versions of GHC.
So you could use the `ghc-mod-5.9.0.0` + `lts-10.8` or even downgrade to `lts-9.21` and use `ghc-mod-5.8.0.0`.
The first gist is [here](https://gist.github.com/vyorkin/f495fd515255b0ac26bc1c31d1a84236),
the second one is [here](https://gist.github.com/vyorkin/7d260d9195e85ce805c78d31aeea38f3).

The config path: `~/.stack/global-project/stack.yaml`

More info:

* https://stackoverflow.com/questions/50948485/stack-install-ghc-mod-fails-with-dependencies-conflicts-on-osx-10-13-4
* https://github.com/DanielG/ghc-mod/issues/900#issuecomment-372979078
* https://github.com/DanielG/ghc-mod/issues/940

Don't:

```
stack install ghc-mod
```

Other stuff (which may maybe tricky to install):

```
stack install pointfree pointfull codex
```

#### Scala

* [sbt & ensime installation guide](http://ensime.org/build_tools/sbt/)
* [coursier](https://github.com/coursier/coursier#quick-start)

#### OCaml, Opam, Merlin, Tuareg

Do you want OPAM to modify ~/.zshrc and ~/.ocamlinit? - the answer is N.
This is because I use 'x' alias instead, see helpers/functions/env.

For more info see [merlin + vim setup instructions](https://github.com/ocaml/merlin/wiki/vim-from-scratch).

#### Reason

You may want to install [the Reason toolchain](https://github.com/reasonml/reason-cli).

#### Emacs and Irony mode

[Mac OS X issues and workaround](https://github.com/Sarcasm/irony-mode/wiki/Mac-OS-X-issues-and-workaround)

#### Gist

Setup the [gist mode](https://github.com/defunkt/gist.el):

```bash
git config --global github.user <your-github-user-name>
git config --global github.oauth-token <your-personal-access-token-with-gist-scope>
```

#### HTOP

I use [fork with VIM keybindings](https://github.com/KoffeinFlummi/htop-vim).
You should compile and install it manually, see the [INSTALL file](https://github.com/KoffeinFlummi/htop-vim/blob/master/INSTALL) for
detailed instructions.

#### GCC & bitutils

On Mac OS X I use GNU GCC and GNU bitutils for cross compilation,
so in my zshrc I have these binaries added to my PATH env variable.
I put GCC binaries here `/usr/local/i386elfgcc/bin` and here `/usr/local/x8664pcelfgcc/bin`.
See [this page](https://github.com/cfenollosa/os-tutorial/tree/master/11-kernel-crosscompiler)
for a detailed instructions on how to setup development environment for cross compilation.

#### Rust

Common crates that I use:

* [rusty-tags](https://github.com/dan-t/rusty-tags)
* [rustfmt](https://github.com/rust-lang-nursery/rustfmt)
* [racer](https://github.com/phildawes/racer)

#### Coq

* [emacs company-coq](https://github.com/cpitclaudel/company-coq#proof-general) install Proof General manually

#### Nix

Clone https://github.com/Gabriel439/nixfmt, and:

```
stack build
stack install
```

#### Tmux

Run `C-SPC-I` in tmux session to install plugins.

#### jenv & JDKs

[Add your JDKs to jenv](http://davidcai.github.io/blog/posts/install-multiple-jdk-on-mac/) (use your JDK versions):

```
$ jenv add /Library/Java/JavaVirtualMachines/jdkx.x.x_xx.jdk/Contents/Home
```

#### Sufring keys for Chrome

[my settings gist](https://gist.github.com/vyorkin/c5d9cfa63da9811ed0062c5f1440f754)

#### PGP/GPG, keybase, signing git commits

Read on [pstadler/keybase-gpg-github](https://github.com/pstadler/keybase-gpg-github) on how to set everything up.

#### Non-free software

I don't really use every single app listed below:

* MindNode
* 2Do
* SnippetsLab
* DayOne
* Typinator
* Pixave
* Pdf Expert
* Timing
* Airmail 3
* Fantastical
* Bartender
* Focus
* Reeder 3
* Dropzone
* PopClip
* Next Meeting
* Xccello
* DaisyDisk
* MonthlyCal
* Spotify
* Spotifree
* Sketch
* Adobe Photoshop, Illustrator, etc
* BeardedSpice
* LittleSnitch
* Texpad
* Anki
* Paw
* Default Folder

#### Safari extensions

[Here](https://github.com/learn-anything/safari-extensions) you'll find anyting you need.

## Optional

* [Bash-Snippets](https://github.com/alexanderepstein/Bash-Snippets.git)
* [Hexitor](https://github.com/briansteffens/hexitor)

# Troubleshooting

Don't worry, be happy

# TODO

* consider using [targets.el](https://github.com/noctuid/targets.el) - extension of evil text objects, when it'll become stable enough
