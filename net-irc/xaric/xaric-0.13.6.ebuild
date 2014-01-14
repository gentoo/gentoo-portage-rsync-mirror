# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xaric/xaric-0.13.6.ebuild,v 1.1 2014/01/14 06:38:02 patrick Exp $

EAPI=2
inherit eutils

DESCRIPTION="An IRC client similar to ircII, BitchX, or ircII EPIC"
HOMEPAGE="http://xaric.org/"
SRC_URI="http://xaric.org/software/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	dev-libs/openssl"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	doicon xaric.xpm
}
