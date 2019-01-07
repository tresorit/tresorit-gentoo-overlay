EAPI=6

DESCRIPTION="Compare, merge files and folders using simple, powerful commands."
HOMEPAGE="https://www.scootersoftware.com"
SRC_URI="https://www.scootersoftware.com/${P}_amd64.deb"

LICENSE="bcompare"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="app-emulation/docker"

src_unpack()
{
	# pretend as it was unpacked
	mkdir ${S}
}

src_install()
{
	mkdir -p "${D}/"usr/lib/beyondcompare
	cp "${FILESDIR}/"Dockerfile "${D}/"usr/lib/beyondcompare/
	cp "${DISTDIR}/${A}" "${D}/"usr/lib/beyondcompare/bcompare.deb

	mkdir -p "${D}/"usr/bin
	cp "${FILESDIR}/"bcompare "${D}/"usr/bin/
	sed -i s/"BCOMPARE_VERSION"/"${PV}"/g "${D}/"usr/bin/bcompare
}

pkg_prerm()
{
	docker rmi docker-bcompare
}
