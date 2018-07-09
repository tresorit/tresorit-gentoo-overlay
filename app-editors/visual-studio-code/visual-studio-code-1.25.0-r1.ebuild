# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://vscode-update.azurewebsites.net/${PV}"
SRC_URI="amd64? ( ${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz )
	x86? ( ${BASE_URI}/linux-ia32/stable -> ${P}-x86.tar.gz )"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=gnome-base/gconf-3.2.6-r4:2
>=media-libs/libpng-1.2.46:0
>=x11-libs/cairo-1.14.12:0
>=x11-libs/gtk+-2.24.31-r1:2
>=x11-libs/libXtst-1.2.3:0"

RDEPEND="${DEPEND}
>=app-crypt/libsecret-0.18.5:0[crypt]
>=net-print/cups-2.1.4:0
>=x11-libs/libnotify-0.7.7:0
>=x11-libs/libXScrnSaver-1.2.2-r1:0"

QA_PRESTRIPPED="opt/${PN}/code"
QA_PREBUILT="opt/${PN}/code"

pkg_setup() {
	if use amd64; then
		S="${WORKDIR}/VSCode-linux-x64"
	elif use x86; then
		S="${WORKDIR}/VSCode-linux-ia32"
	else
		# shouldn't be possible with -* special keyword
		die
	fi
}

src_install() {
	dodir "/opt"
	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}" "${D}/opt/${PN}" || die "Failed to copy files"
	dosym "${EPREFIX}/opt/${PN}/bin/code" "/usr/bin/code"
	make_desktop_entry "code" "Visual Studio Code" "${PN}" "Development;IDE"
	doicon "${S}/resources/app/resources/linux/code.png"
	insinto "/usr/share/licenses/${PN}"
	newins "resources/app/LICENSE.txt" "LICENSE"
}
