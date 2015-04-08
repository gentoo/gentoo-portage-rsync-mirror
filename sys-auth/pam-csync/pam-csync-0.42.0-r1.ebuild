# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam-csync/pam-csync-0.42.0-r1.ebuild,v 1.2 2014/02/07 08:55:08 voyageur Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="PAM module to provide roaming home directories for a user session"
HOMEPAGE="http://www.csync.org/"
SRC_URI="http://www.csync.org/files/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/iniparser-3.1
	>=net-misc/ocsync-0.60.0
	virtual/pam
"
DEPEND="${DEPEND}
	app-text/asciidoc
"

S="${WORKDIR}/${P/-/_}"

PATCHES=( "${FILESDIR}/${P}-ocsync.patch" )
