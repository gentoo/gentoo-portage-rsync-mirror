# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-familyguy/fortune-mod-familyguy-0.2.ebuild,v 1.5 2010/12/12 17:30:45 grobian Exp $

DESCRIPTION="Quotes from the TV-Series -Family Guy-"
HOMEPAGE="http://jon.oberheide.org/familyguy/"
SRC_URI="http://jon.oberheide.org/familyguy/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins familyguy familyguy.dat || die
}
