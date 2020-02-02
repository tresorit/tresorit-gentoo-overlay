# Portage overlay for Tresorit Core development

[![Build Status](https://api.travis-ci.org/tresorit/tresorit-gentoo-overlay.svg?branch=master)](https://travis-ci.org/tresorit/tresorit-gentoo-overlay)

This is a [Portage overlay][overlay] to install Tresorit Core development related applications.

## Install

### With repos.conf

1. Copy `tresorit.conf` from this repository into `/etc/portage/repos.conf/` to use the new [portage sync capabilities][portagesync].
1. Edit `location` in the config file if you wish to specify where the repository should be cloned.

### With layman

1. Make sure you have [layman][layman] installed.
2. Run `sudo layman -f -o https://raw.githubusercontent.com/tresorit/tresorit-gentoo-overlay/master/repositories.xml -a tresorit`.

## Packages provided

* `qcachegrind`
* ...

[overlay]: https://wiki.gentoo.org/wiki/Overlay
[portagesync]: https://wiki.gentoo.org/wiki/Project:Portage/Sync
[layman]: http://wiki.gentoo.org/wiki/Layman
