EAPI=6

inherit xdg-utils

DESCRIPTION="Compare, merge files and folders using simple, powerful commands."
HOMEPAGE="http://www.scootersoftware.com"
SRC_URI="http://www.scootersoftware.com/${P}.x86_64.tar.gz"

LICENSE="bcompare"
SLOT="0"
KEYWORDS="amd64"
IUSE="caja kde konq nautilus nemo thunar"

DEPEND="dev-util/patchelf"
RDEPEND="
	app-arch/bzip2
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	sys-libs/zlib
	x11-libs/libX11
	"

src_install()
{
	mkdir -p "${D}/"usr/lib/beyondcompare
	cp "${S}/"{bcmount.sh,bcmount32,bcmount64,BCompare,BCompare.mad,lib7z.so,libQt4Pas.so.5} "${D}/"usr/lib/beyondcompare/
	patchelf --set-rpath '$ORIGIN/' "${D}/"usr/lib/beyondcompare/BCompare

	mkdir -p "${D}/"usr/bin
	ln -s /usr/lib/beyondcompare/BCompare "${D}/"usr/bin/bcompare

	mkdir -p "${D}/"usr/share/applications
	cp "${S}/"bcompare.desktop "${D}/"usr/share/applications/

	mkdir -p "${D}/"usr/share/doc/beyondcompare
	cp "${S}/"help/* "${D}/"usr/share/doc/beyondcompare/

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
