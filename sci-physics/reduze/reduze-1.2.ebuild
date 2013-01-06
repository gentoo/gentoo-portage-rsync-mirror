# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/reduze/reduze-1.2.ebuild,v 1.2 2011/01/17 15:03:22 grozin Exp $
EAPI="3"
DESCRIPTION="A program for reducing Feynman integrals"
HOMEPAGE="http://krone.physik.unizh.ch/~cedric/reduze/"
IUSE=""
SRC_URI="http://krone.physik.unizh.ch/~cedric/${PN}/download/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=">=sci-mathematics/ginac-1.4.1"
DEPEND="${RDEPEND}"

src_test() {
	emake check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
}
