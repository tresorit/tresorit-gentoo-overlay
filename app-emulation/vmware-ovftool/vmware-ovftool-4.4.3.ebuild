# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="VMware-ovftool-${PV}-18663434"

DESCRIPTION="VMware Open Virtualization Format Tool"
HOMEPAGE="https://www.vmware.com/support/developer/ovf/"
SRC_URI="${MY_P}-lin.x86_64.bundle"

LICENSE="vmware"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror fetch strip"

QA_PREBUILT=""

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please download ${A} from https://my.vmware.com/group/vmware/downloads/get-download?downloadGroup=OVFTOOL${PV//./}"
	einfo "The archive should then be placed into your DISTDIR directory."
}

src_unpack() {
	addpredict /var/log/vmware-installer
	bash `readlink "${DISTDIR}/${A}"` -x "${S}/extract" || die
}

src_install() {
	cd extract/vmware-ovftool
	insinto "/opt/${PN}"
	doins -r *
	fperms +x /opt/${PN}/ovftool{,.bin}
	dosym "/opt/${PN}/ovftool" "usr/bin/ovftool"
}
