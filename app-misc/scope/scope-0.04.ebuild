# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/scope/scope-0.04.ebuild,v 1.3 2008/12/30 20:14:54 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="Serial Line Analyser"
HOMEPAGE="http://www.gumbley.me.uk/scope.html"
SRC_URI="http://www.gumbley.me.uk/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	econf
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
