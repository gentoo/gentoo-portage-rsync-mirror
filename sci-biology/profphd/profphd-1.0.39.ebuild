# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/profphd/profphd-1.0.39.ebuild,v 1.2 2013/03/21 09:02:15 jlec Exp $

EAPI=5

DESCRIPTION="Secondary structure and solvent accessibility predictor"
HOMEPAGE="https://rostlab.org/owiki/index.php/PROFphd_-_Secondary_Structure,_Solvent_Accessibility_and_Transmembrane_Helices_Prediction"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.orig.tar.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_prepare() {
	sed \
		-e '/ln -s/s:prof$:profphd:g' \
		-i src/prof/Makefile || die
}

src_compile() {
	emake prefix="${EPREFIX}/usr"
}

src_install() {
	emake prefix="${EPREFIX}/usr" DESTDIR="${D}" install
}
