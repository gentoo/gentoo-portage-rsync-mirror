# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autogen/autogen-5.11.5.ebuild,v 1.5 2011/03/20 12:37:57 armin76 Exp $

EAPI="3"

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://gnu/${PN}/rel${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

# autogen doesn't build with lower versions of guile on ia64
DEPEND=">=dev-scheme/guile-1.8[deprecated]
	dev-libs/libxml2"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS NOTES README THANKS TODO
	rm "${ED}"/usr/share/autogen/libopts-*.tar.gz || die
}
