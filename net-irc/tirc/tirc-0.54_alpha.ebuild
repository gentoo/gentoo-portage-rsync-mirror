# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/tirc/tirc-0.54_alpha.ebuild,v 1.3 2013/03/30 14:43:52 ulm Exp $

MY_P=${P/_alpha/a}-patched

DESCRIPTION="Token's IRC client"
HOMEPAGE="http://home.mayn.de/jean-luc/alt/tirc/"
SRC_URI="http://home.mayn.de/jean-luc/alt/tirc/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="debug"

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${PN}-alpha

src_compile() {
	econf \
		--with-all \
		$(use_enable debug) \
		|| die "econf failed"
	emake depend || die "emake depend failed"
	emake tirc || die "emake tirc failed"
}

src_install() {
	dobin tirc || die "dobin failed"
	doman tirc.1 || die "doman failed"
	dodoc COMMENT Changelog FAQ Notes README doc/* || die "dodoc failed"
}
