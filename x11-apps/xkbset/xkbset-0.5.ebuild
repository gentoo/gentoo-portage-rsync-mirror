# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbset/xkbset-0.5.ebuild,v 1.1 2009/12/28 19:38:44 truedfx Exp $

inherit base

DESCRIPTION="Manage xkb features such as MouseKeys, AccessX, StickyKeys, BounceKeys and SlowKeys"
HOMEPAGE="http://www.math.missouri.edu/~stephen/software/"
SRC_URI="http://www.math.missouri.edu/~stephen/software/xkbset/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tk"

CDEPEND="x11-libs/libX11"
DEPEND="${CDEPEND}
	dev-lang/perl"
RDEPEND="${CDEPEND}
	tk? ( dev-lang/perl
		dev-perl/perl-tk )"

PATCHES=(
	"${FILESDIR}"/${P}-ldflags.patch
)

src_compile() {
	emake INC_PATH= LIB_PATH= || die
}

src_install() {
	dobin xkbset
	use tk && dobin xkbset-gui
	doman xkbset.1
	dodoc README TODO
}
