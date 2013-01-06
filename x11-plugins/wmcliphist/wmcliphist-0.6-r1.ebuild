# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcliphist/wmcliphist-0.6-r1.ebuild,v 1.7 2012/05/05 05:12:01 jdhore Exp $

EAPI="1"

inherit eutils toolchain-funcs

DESCRIPTION="Dockable clipboard history application for Window Maker"
HOMEPAGE="http://linux.nawebu.cz/wmcliphist"
SRC_URI="http://linux.nawebu.cz/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-fix-docking.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc ChangeLog README
	newdoc .${PN}rc ${PN}rc.sample
}
