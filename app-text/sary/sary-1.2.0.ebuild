# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sary/sary-1.2.0.ebuild,v 1.18 2012/05/04 03:33:16 jdhore Exp $

EAPI=3

DESCRIPTION="Sary: suffix array library and tools"
HOMEPAGE="http://sary.sourceforge.net/"
SRC_URI="http://sary.sourceforge.net/${P}.tar.gz"
IUSE=""

LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
SLOT="0"
RESTRICT="test"

RDEPEND=">=dev-libs/glib-2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {

	make DESTDIR="${D}" \
		docsdir="${EPREFIX}"/usr/share/doc/${PF}/html \
		install || die

	dodoc [A-Z][A-Z]* ChangeLog

}
