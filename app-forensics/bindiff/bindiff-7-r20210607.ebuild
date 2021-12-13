# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker

DESCRIPTION="zynamics BinDiff"
HOMEPAGE="https://www.zynamics.com/index.html"
SRC_URI="https://storage.googleapis.com/bindiff-releases/updated-20210607/bindiff_7_amd64.deb"

LICENSE="zynamics"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S=${WORKDIR}
QA_PREBUILT="*"

src_install() {
	dodoc -r usr/share/doc
	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/bin/bindiff
	dosym "../../opt/${PN}/bin/bindiff" usr/bin/bindiff
	fperms +x /opt/${PN}/bin/binexport2dump
	dosym "../../opt/${PN}/bin/binexport2dump" usr/bin/binexport2dump
}
