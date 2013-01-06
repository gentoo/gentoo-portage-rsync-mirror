# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/siscone/siscone-2.0.5.ebuild,v 1.2 2012/07/25 06:57:29 mr_bones_ Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes
inherit autotools-utils

DESCRIPTION="Hadron Seedless Infrared-Safe Cone jet algorithm"
HOMEPAGE="http://siscone.hepforge.org/"
SRC_URI="http://www.hepforge.org/archive/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples static-libs"

RDEPEND=""
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-headers-dir.patch )

src_install() {
	autotools-utils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.{cpp,h}
		insinto /usr/share/doc/${PF}/examples/events
		doins examples/events/*.dat
	fi
}
