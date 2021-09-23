# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker

DESCRIPTION="Microsoft SQL Server tools"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-linux-ver15"
SRC_URI="https://packages.microsoft.com/debian/10/prod/pool/main/m/mssql-tools/mssql-tools_17.8.1.1-1_amd64.deb"

LICENSE="mssql-tools"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	dev-db/unixODBC"

S=${WORKDIR}
QA_PREBUILT="*"

src_install() {
	dodoc -r usr/share/doc
	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/bin/bcp
	dosym "../../opt/${PN}/bin/bcp" usr/bin/bcp
	fperms +x /opt/${PN}/bin/sqlcmd
	dosym "../../opt/${PN}/bin/sqlcmd" usr/bin/sqlcmd
}
