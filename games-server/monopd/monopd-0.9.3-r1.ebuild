# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/monopd/monopd-0.9.3-r1.ebuild,v 1.5 2011/12/15 17:53:14 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="server for atlantik games"
HOMEPAGE="http://unixcode.org/monopd/"
SRC_URI="http://unixcode.org/downloads/monopd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=net-libs/libcapsinetwork-0.3.0"
DEPEND="${RDEPEND}
	>=sys-libs/libmath++-0.0.3"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch #218833
	epatch "${FILESDIR}"/${P}-dosfix.patch
	# make the example config better (bug #206740)
	sed -i \
		-e '/gatorhost/s/=.*/=monopd-gator.kde.org/' \
		conf/monopd.conf-dist \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc doc/api/gameboard API AUTHORS ChangeLog NEWS README* TODO
	doinitd "${FILESDIR}"/monopd || die
	prepgamesdirs
}
