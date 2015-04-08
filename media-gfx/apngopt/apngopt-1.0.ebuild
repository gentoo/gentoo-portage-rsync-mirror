# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/apngopt/apngopt-1.0.ebuild,v 1.4 2012/05/05 07:00:23 jdhore Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="optimize APNG images"
HOMEPAGE="http://sourceforge.net/projects/apng/"
SRC_URI="mirror://sourceforge/apng/APNG_Optimizer/${PV}/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-arch/unzip"

S=${WORKDIR}

src_compile() {
	emake CC="$(tc-getCC)" LDLIBS="$($(tc-getPKG_CONFIG) --libs zlib)" ${PN} || die
}

src_install() {
	dobin ${PN} || die
	dodoc readme.txt
}
