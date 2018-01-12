# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker

DESCRIPTION="Musixmatch"
HOMEPAGE="https://www.musixmatch.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	wget -U "Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/57.0" -O $P.deb https://download-app.musixmatch.com/
	unpack_deb $P.deb
}

src_install() {
	doins -r .
	fperms +x /opt/Musixmatch/musixmatch
	dosym /opt/Musixmatch/musixmatch usr/bin/musixmatch
}
