# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcliphist/wmcliphist-1.0.ebuild,v 1.1 2012/08/27 09:26:54 voyageur Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Dockable clipboard history application for Window Maker"
HOMEPAGE="http://linux.nawebu.cz/wmcliphist"
SRC_URI="http://linux.nawebu.cz/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	dobin ${PN}
	dodoc ChangeLog README
	newdoc ${PN}rc ${PN}rc.sample
}
