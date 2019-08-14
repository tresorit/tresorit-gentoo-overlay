# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker

DESCRIPTION="Microsoft ODBC Driver 17 for SQL Server"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-linux-2017"
SRC_URI="https://packages.microsoft.com/debian/9/prod/pool/main/m/msodbcsql17/msodbcsql17_17.4.1.1-1_amd64.deb"

LICENSE="msodbcsql17"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/util-linux
	dev-db/unixODBC
	virtual/krb5"
BDEPEND=""

S=${WORKDIR}

QA_PREBUILT="*"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	dodoc -r usr/share/doc
	doins -r opt
}
