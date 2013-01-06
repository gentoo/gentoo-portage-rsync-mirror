# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-2.11.ebuild,v 1.10 2012/09/06 01:40:05 blueness Exp $

EAPI=2
DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://www.qstat.org/"
SRC_URI="mirror://sourceforge/qstat/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ppc ppc64 x86"
IUSE="debug"

DEPEND="!sys-cluster/torque"

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dosym qstat /usr/bin/quakestat

	dodoc CHANGES.txt COMPILE.txt template/README.txt
	dohtml template/*.html qstatdoc.html
}
