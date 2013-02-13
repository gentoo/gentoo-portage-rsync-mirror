# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/rkward/rkward-0.6.0.ebuild,v 1.1 2013/02/13 21:55:41 bicatali Exp $

EAPI=5

KDE_DOC_DIRS="doc"
KDE_HANDBOOK="optional"
KDE_LINGUAS="ca cs da de el es fr it lt pl tr zh_CN"

inherit kde4-base

DESCRIPTION="IDE for the R-project"
HOMEPAGE="http://rkward.sourceforge.net/"
SRC_URI="mirror://sourceforge/rkward/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=dev-lang/R-2.15.2-r2
	|| (	<kde-base/kdelibs-4.6.50
		( $(add_kdebase_dep katepart) ) )
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install
	# avoid file collisions
	rm "${ED}"/usr/$(get_libdir)/R/library/R.css || die
	rm "${ED}"/usr/share/apps/katepart/syntax/r.xml || die
}
