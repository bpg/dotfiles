# Dotfiles

My [dotfiles](https://wiki.archlinux.org/title/Dotfiles) for `macOS`.

Inspired by https://github.com/Allaman/dots

## Bootstrap

[bootstrap](./bootstrap.sh) is an all-in-one script to download [chezmoi](https://www.chezmoi.io/) and [age](https://github.com/FiloSottile/age) 
and initialize chezmoi with this repository.

```sh
wget -q https://raw.githubusercontent.com/Allaman/dots/main/bootstrap.sh -O /tmp/bootstrap.sh
chmod +x /tmp/bootstrap.sh
bash -c /tmp/./bootstrap.sh
```
