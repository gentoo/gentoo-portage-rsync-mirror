# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libecwj2/libecwj2-3.3-r1.ebuild,v 1.6 2012/08/03 19:42:46 bicatali Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="Library for both the ECW and the ISO JPEG 2000 image file formats"
SRC_URI="mirror://gentoo/${P}-2006-09-06.zip"
HOMEPAGE="http://www.ermapper.com/ProductView.aspx?t=28"

LICENSE="ECWPL"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs"

RDEPEND="=media-libs/lcms-1*"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	epatch "${FILESDIR}"/${P}-nolcms.patch
	rm -rf Source/C/libjpeg Source/C/NCSEcw/lcms
	# bug 328075
	sed -i -e "s:includeHEADERS_INSTALL:INSTALL_HEADER:" \
		Source/NCSBuildGnu/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	dodir /usr/include
	default
	use doc && dodoc SDK.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
