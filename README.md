# Portage overlay for Tresorit Core development

This is a [Portage overlay][overlay] to install Tresorit Core development related applications.

## Install

1. Make sure you have [layman][layman] installed.
2. Download *repositories.xml*
3. Run `sudo cp repositories.xml /etc/layman/overlays && layman -S && layman -a tresorit`.
4. You can now emerge packages from the overlay and eix-sync will refresh the repository.

## Packages provided

* `astyle`
* ...

[overlay]: https://wiki.gentoo.org/wiki/Overlay
[layman]: http://wiki.gentoo.org/wiki/Layman


