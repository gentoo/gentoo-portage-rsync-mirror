# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libical/libical-0.43.ebuild,v 1.9 2009/11/05 20:23:50 maekke Exp $

DESCRIPTION="a implementation of basic iCAL protocols from citadel, previously known as aurore."
HOMEPAGE="http://www.citadel.org"
SRC_URI="http://easyinstall.citadel.org/${P}.tar.gz"
RESTRICT="test"

LICENSE="|| ( MPL-1.1 LGPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

src_compile() {
	# Fix 66377
	LDFLAGS="${LDFLAGS} -lpthread" econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TEST THANKS TODO doc/*.txt
}
