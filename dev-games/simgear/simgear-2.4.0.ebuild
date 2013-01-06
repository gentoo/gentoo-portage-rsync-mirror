# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/simgear/simgear-2.4.0.ebuild,v 1.5 2012/07/10 04:52:20 xmw Exp $

EAPI=4

inherit autotools-utils eutils

DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="http://mirrors.ibiblio.org/pub/mirrors/simgear/ftp/Source/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug"

RESTRICT="test"

RDEPEND=">=dev-games/openscenegraph-3.0.1
	>=dev-libs/boost-1.37
	dev-vcs/subversion
	media-libs/freealut
	media-libs/openal
	>=media-libs/plib-1.8.5"
DEPEND="${RDEPEND}"

DOCS=(AUTHORS NEWS TODO)

src_prepare() {
	epatch "${FILESDIR}"/${P}-boost148.patch
}

src_configure() {
	myeconfargs=(
		--with-jpeg-factory
		$(use_with debug logging)
	)

	autotools-utils_src_configure
}
