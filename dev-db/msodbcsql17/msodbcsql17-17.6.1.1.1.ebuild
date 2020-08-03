# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker

DESCRIPTION="Microsoft ODBC Driver 17 for SQL Server"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-linux-2017"
SRC_URI="https://packages.microsoft.com/debian/10/prod/pool/main/m/msodbcsql17/msodbcsql17_17.6.1.1-1_amd64.deb"

LICENSE="msodbcsql17"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-db/unixODBC"
RDEPEND="${DEPEND}
	sys-apps/util-linux
	virtual/krb5"
BDEPEND=""

S=${WORKDIR}

QA_PREBUILT="*"

DRIVER_NAME="ODBC Driver 17 for SQL Server"
ODBCINST_INI="/opt/microsoft/msodbcsql17/etc/odbcinst.ini"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	dodoc -r usr/share/doc
	doins -r opt
}

pkg_postinst() {
	ebegin "Installing ${DRIVER_NAME}"
	/usr/bin/odbcinst -i -d -f "${ODBCINST_INI}"
	rc=$?
	eend $rc
	[ $rc -ne 0 ] && die
}

pkg_prerm() {
	ebegin "Uninstalling ${DRIVER_NAME}"
	/usr/bin/odbcinst -u -d -n "${DRIVER_NAME}"
	rc=$?
	eend $rc
	[ $rc -ne 0 ] && die
}
