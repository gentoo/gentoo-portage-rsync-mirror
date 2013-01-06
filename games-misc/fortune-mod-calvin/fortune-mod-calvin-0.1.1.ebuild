# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-calvin/fortune-mod-calvin-0.1.1.ebuild,v 1.14 2010/12/12 18:23:23 grobian Exp $

DESCRIPTION="Quotes from Calvin and Hobbes Comic Books"
HOMEPAGE="http://www.netmeister.org/misc.html"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"

LICENSE="fairuse"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins calvin calvin.dat || die
}
