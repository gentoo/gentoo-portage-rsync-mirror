# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tklib/tklib-0.5.ebuild,v 1.3 2013/06/06 08:04:42 jlec Exp $

DESCRIPTION="Collection of utility modules for Tk, and a companion to Tcllib"
HOMEPAGE="http://www.tcl.tk/software/tklib"
SRC_URI="mirror://sourceforge/project/tcllib/${PN}/${PV}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
IUSE="doc"

RDEPEND="
	dev-lang/tk
	dev-tcltk/tcllib"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	if use doc; then
		emake DESTDIR="${D}" doc || die
		dohtml doc/html/* || die
	fi
	dodoc ChangeLog DESCRIPTION.txt README* || die
	mv "${ED}"/usr/share/man/mann/datefield{,-${PN}}.n || die
}
