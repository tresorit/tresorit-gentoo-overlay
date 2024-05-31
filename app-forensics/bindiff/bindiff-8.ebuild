# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker

DESCRIPTION="Comparison tool for binary files"
HOMEPAGE="https://github.com/google/bindiff/"
SRC_URI="https://github.com/google/bindiff/releases/download/v${PV}/bindiff_${PV}_amd64.deb"

S=${WORKDIR}
QA_PREBUILT="*"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

src_install() {
	dodoc -r usr/share/doc
	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/bin/bindiff
	dosym "../../opt/${PN}/bin/bindiff" usr/bin/bindiff
	fperms +x /opt/${PN}/bin/binexport2dump
	dosym "../../opt/${PN}/bin/binexport2dump" usr/bin/binexport2dump
}
