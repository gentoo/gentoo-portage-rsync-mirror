# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/apertium/apertium-3.2.0.ebuild,v 1.3 2012/05/04 07:50:52 jdhore Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Shallow-transfer machine Translation engine and toolbox"
HOMEPAGE="http://apertium.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	dev-libs/libxslt
	dev-libs/libpcre[cxx]
	>=sci-misc/lttoolbox-3.2
	virtual/libiconv"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PV}-flags.patch
	"${FILESDIR}"/${PV}-datadir.patch
	)

MAKEOPTS+=" -j1"
