# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-bofh-excuses/fortune-mod-bofh-excuses-1.2.ebuild,v 1.13 2010/12/12 18:28:14 grobian Exp $

DESCRIPTION="Excuses from Bastard Operator from Hell"
HOMEPAGE="http://www.stlim.net/staticpages/index.php?page=20020814005536450"
SRC_URI="http://www.stlim.net/downloads/fortune-bofh-excuses-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${PN/mod-/}

src_install() {
	insinto /usr/share/fortune
	doins bofh-excuses.dat bofh-excuses || die
}
