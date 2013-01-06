# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ddd/ddd-3.3.12-r1.ebuild,v 1.9 2012/10/24 19:09:45 ulm Exp $

EAPI=1

inherit eutils

DESCRIPTION="Graphical openmotif front-end for command-line debuggers"
HOMEPAGE="http://www.gnu.org/software/ddd"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3 LGPL-3 FDL-1.1"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=sys-devel/gdb-6.5
	>=x11-libs/motif-2.3:0
	x11-libs/libX11
	x11-libs/libXp"

RDEPEND="${DEPEND}
	sci-visualization/gnuplot
	x11-apps/xfontsel"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_compile() {
	econf || die

	cd "${S}"/ddd
	emake version.h build.h host.h root.h configinfo.C Ddd.ad.h || die "Failed to build headers"

	cd "${S}"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS CREDITS INSTALL NEWS PROBLEMS README TIPS TODO
	cp -R "${S}"/doc/* "${D}"/usr/share/doc/${PF}

	doicon "${S}"/icons/ddd.xpm
}
