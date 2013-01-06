# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autogen/autogen-5.9.7.ebuild,v 1.9 2010/05/12 20:04:37 ranger Exp $

inherit eutils

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

# autogen doesn't build with lower versions of guile on ia64
DEPEND=">=dev-scheme/guile-1.6.6
	dev-libs/libxml2"

pkg_setup() {
	has_version '>=dev-scheme/guile-1.8' || return 0
	if ! built_with_use --missing false dev-scheme/guile deprecated threads ; then
		eerror "You need to build dev-scheme/guile with USE='deprecated threads'"
		die "re-emerge dev-scheme/guile with USE='deprecated threads'"
	fi
}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS NOTES README THANKS TODO
	rm -f "${D}"/usr/share/autogen/libopts-*.tar.gz
}
