# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-xvmc/eselect-xvmc-0.3.ebuild,v 1.9 2012/08/27 17:33:27 armin76 Exp $

DESCRIPTION="Manages XvMC implementations"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-admin/eselect-1.0.10"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}"/${P}.eselect xvmc.eselect || die "newins failed"
}
