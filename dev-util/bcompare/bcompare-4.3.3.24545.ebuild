EAPI=7

inherit xdg-utils

DESCRIPTION="Compare, merge files and folders using simple, powerful commands."
HOMEPAGE="https://www.scootersoftware.com"
SRC_URI="https://www.scootersoftware.com/${P}.x86_64.tar.gz"

LICENSE="bcompare"
SLOT="0"
KEYWORDS="amd64"
IUSE="caja kde konq nautilus nemo thunar"
QA_PREBUILT="*"

DEPEND=""
RDEPEND="
	app-arch/bzip2
	dev-libs/expat
	dev-libs/glib
	dev-libs/libbsd
	dev-libs/libpcre
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	sys-apps/util-linux
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXrender
	"
BDEPEND=""

src_install()
{
	mkdir -p "${D}/"usr/lib/beyondcompare
	cp "${S}/"{BCompare,BCompare.mad,lib7z.so,libQt4Pas.so.5,libunrar.so,libQtCore.so.4,libQtGui.so.4,libQtNetwork.so.4} "${D}/"usr/lib/beyondcompare/

	mkdir -p "${D}/"usr/bin
	cat <<-EOF >"${D}"/usr/bin/bcompare || die
		#!/bin/sh
		LD_LIBRARY_PATH="/usr/lib/beyondcompare" \\
		exec /usr/lib/beyondcompare/BCompare "\$@"
	EOF
	fperms +x /usr/bin/bcompare

	mkdir -p "${D}/"usr/share/applications
	cp "${S}/"bcompare.desktop "${D}/"usr/share/applications/

	mkdir -p "${D}/"usr/share/doc/${PF}
	cp "${S}/"help/* "${D}/"usr/share/doc/${PF}/

	mkdir -p "${D}/"usr/share/mime/packages
	cp "${S}/"bcompare.xml "${D}/"usr/share/mime/packages/

	mkdir -p "${D}/"usr/share/pixmaps
	cp "${S}/"{bcompare.png,bcomparefull32.png,bcomparehalf32.png} "${D}/"usr/share/pixmaps/

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=\"/usr/lib/beyondcompare\"" >> ${T}/20${PN}
	doins "${T}/20${PN}"

	if use caja; then
		mkdir -p "${D}/"usr/lib/caja/extensions-3.0
		cp "${S}/"ext/bcompare-ext-caja.amd64.so "${D}/"usr/lib/caja/extensions-3.0/
	fi

	if use kde; then
		mkdir -p "${D}/"usr/lib/kde4
		cp "${S}/"ext/bcompare_ext_kde.amd64.so "${D}/"usr/lib/kde4/
	fi

	if use konq; then
		mkdir -p "${D}/"usr/lib/kde4
		cp "${S}/"ext/bcompare_ext_konq.amd64.so "${D}/"usr/lib/kde4/
	fi

	if use nautilus; then
		mkdir -p "${D}/"usr/lib/nautilus/extensions-3.0
		cp "${S}/"ext/bcompare-ext-nautilus.amd64.so "${D}/"usr/lib/nautilus/extensions-3.0/
	fi

	if use nemo; then
		mkdir -p "${D}/"usr/lib/nemo/extensions-3.0
		cp "${S}/"ext/bcompare-ext-nemo.amd64.so "${D}/"usr/lib/nemo/extensions-3.0/
	fi

	if use thunar; then
		mkdir -p "${D}/"usr/lib/thunarx-2
		cp "${S}/"ext/bcompare-ext-thunarx.amd64.so "${D}/"usr/lib/thunarx-2/
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
