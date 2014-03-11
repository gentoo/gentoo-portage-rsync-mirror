# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gentoo-functions/gentoo-functions-0.1.ebuild,v 1.1 2014/03/11 21:55:41 williamh Exp $

EAPI=5

DESCRIPTION="base shell functions required by all gentoo systems"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /lib/gentoo
	insinto /lib/gentoo
	newins "${FILESDIR}"/${P}.sh functions.sh
}
