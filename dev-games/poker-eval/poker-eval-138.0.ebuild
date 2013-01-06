# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/poker-eval/poker-eval-138.0.ebuild,v 1.4 2010/12/05 18:05:23 armin76 Exp $

EAPI=2
inherit eutils

DESCRIPTION="A fast C library for evaluating poker hands"
HOMEPAGE="http://pokersource.info/"
SRC_URI="http://download.gna.org/pokersource/sources/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--without-ccache \
		$(use_enable static-libs static) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO WHATS-HERE
	if ! use static-libs ; then
		find "${D}" -type f -name '*.la' -exec rm {} + \
			|| die "la removal failed"
	fi
}
