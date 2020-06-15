# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Musixmatch"
HOMEPAGE="https://www.musixmatch.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S="${WORKDIR}"
QA_PREBUILT="*"

src_unpack() {
	if has network-sandbox ${FEATURES}; then
		ewarn "This will probably fail, try to emerge this with FEATURES=\"-network-sandbox\""
	fi

	wget -U "Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/57.0" -O $P.deb https://download-app.musixmatch.com/
	unpack_deb $P.deb
}

src_install() {
	dodir "/opt"
	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}/opt/Musixmatch" "${D}/opt/${PN}" || die "Failed to copy files"
	dosym "${EPREFIX}/opt/${PN}/musixmatch" "/usr/bin/musixmatch"
}
