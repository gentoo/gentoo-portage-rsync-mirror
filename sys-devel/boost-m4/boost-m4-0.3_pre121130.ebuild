# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/boost-m4/boost-m4-0.3_pre121130.ebuild,v 1.2 2012/12/01 19:04:00 armin76 Exp $

EAPI=4

inherit vcs-snapshot

DESCRIPTION="Another set of autoconf macros for compiling against boost"
HOMEPAGE="http://github.com/tsuna/boost.m4"
#SRC_URI="${HOMEPAGE}/tarball/v${PV} -> ${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# boost.m4 has a buildsystem, but the distributer didn't use make dist
# so we'd have to eautoreconf to use it. For installing one file, this
# isn't worth it.
src_configure() { :; }

src_compile() { :; }

src_install() {
	insinto /usr/share/aclocal
	doins build-aux/boost.m4

	dodoc AUTHORS NEWS README THANKS
}
