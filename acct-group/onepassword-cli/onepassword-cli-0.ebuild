# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-group

DESCRIPTION="Group for the 1Password password manager"
LICENSE="GPL-2"
# Needs to be higher than 1000, from previous issues.
ACCT_GROUP_ID=1011
