# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/rngstreams/rngstreams-1.0.1.ebuild,v 1.7 2012/07/06 23:47:04 bicatali Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Multiple independent streams of pseudo-random numbers"
HOMEPAGE="http://statmath.wu.ac.at/software/RngStreams/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs"

src_install() {
	autotools-utils_src_install
	use doc && dohtml -r doc/rngstreams.html/* && dodoc doc/${PN}.pdf
	if use examples; then
		rm examples/Makefile*
		insinto /ust/share/doc/${PF}
		doins -r examples
	fi
}
