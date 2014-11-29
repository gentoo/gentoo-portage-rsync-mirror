# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-2.11.ebuild,v 1.11 2014/11/28 17:18:34 mr_bones_ Exp $

EAPI=5
DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://sourceforge.net/projects/qstat/"
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
	DOCS="CHANGES.txt COMPILE.txt template/README.txt" default
	dosym qstat /usr/bin/quakestat
	dohtml template/*.html qstatdoc.html
}
