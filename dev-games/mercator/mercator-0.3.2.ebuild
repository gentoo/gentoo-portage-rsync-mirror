# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/mercator/mercator-0.3.2.ebuild,v 1.3 2013/01/13 11:38:19 ago Exp $

EAPI=2
inherit base eutils

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
	prune_libtool_files
}
