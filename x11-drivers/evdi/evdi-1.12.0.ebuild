# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/DisplayLink/evdi/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DisplayLink/evdi.git"
fi

S="${S}/module"

DESCRIPTION="Kernel module for managing screens"
HOMEPAGE="https://github.com/DisplayLink/evdi"
LICENSE="GPL-2"
SLOT="0"

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND="sys-kernel/linux-headers"

PATCHES=(
	"${FILESDIR}/${PN}-fix-for-kernel-6.0.patch"
)

MODULE_NAMES="evdi(video:${S})"
CONFIG_CHECK="~FB_VIRTUAL ~I2C"

src_prepare() {
	default
	local KVER=$(cat "${KERNEL_DIR}/include/config/kernel.release")
	sed -i "1i KVER := ${KVER}" "${S}/Makefile"
}
