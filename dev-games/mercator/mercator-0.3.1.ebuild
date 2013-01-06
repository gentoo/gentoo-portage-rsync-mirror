# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/mercator/mercator-0.3.1.ebuild,v 1.3 2012/12/26 01:24:50 jdhore Exp $

EAPI=2
inherit base

DESCRIPTION="WorldForge library primarily aimed at terrain."
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/mercator"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="doc"
SLOT="0"

RDEPEND=">=dev-games/wfmath-1"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_compile() {
	base_src_compile
	use doc && base_src_compile docs
}

src_install() {
	use doc && HTML_DOCS=( doc/html/* )
	base_src_install
	find "${D}" -type f -name '*.la' -exec rm {} + || die
}
