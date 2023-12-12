# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=$(ver_rs 3 '-')
MY_PV_WITHOUT_PATCH=$(ver_cut 1-3)
MY_PV_FOR_LINK=${MY_PV_WITHOUT_PATCH//./}

DESCRIPTION="VMware Open Virtualization Format Tool"
HOMEPAGE="https://www.vmware.com/support/developer/ovf/"
SRC_URI="VMware-ovftool-${MY_PV}-lin.x86_64.bundle"

LICENSE="vmware"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror fetch strip"

QA_PREBUILT=""

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please download ${A} from https://my.vmware.com/group/vmware/downloads/get-download?downloadGroup=OVFTOOL${MY_PV_FOR_LINK}"
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
