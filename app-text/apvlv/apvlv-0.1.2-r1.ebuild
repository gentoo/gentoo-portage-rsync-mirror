# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/apvlv/apvlv-0.1.2-r1.ebuild,v 1.6 2012/08/08 16:57:17 dilfridge Exp $

EAPI=4

inherit eutils cmake-utils

MY_P="${P}-Source"
DESCRIPTION="Alf's PDF Viewer Like Vim"
HOMEPAGE="http://naihe2010.github.com/apvlv/"
SRC_URI="mirror://github/naihe2010/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug djvu"

RDEPEND=">=x11-libs/gtk+-2.10.4:2
	>=app-text/poppler-0.18[cairo,xpdf-headers(+)]
	djvu? ( app-text/djvu )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# bug #349979
	EPATCH_OPTS="-l" epatch \
		"${FILESDIR}"/${PN}-0.1.0-poppler-0.16.patch \
		"${FILESDIR}"/${PN}-0.1.2-poppler-0.18.patch

	# Remove prefixes so it works with the cmake-utils eclass
	sed -i -e "s:APVLV_::" CMakeLists.txt src/CMakeLists.txt || die

	# Don't install tex file
	sed -i -e "s:Startup.tex::" CMakeLists.txt || die
}

src_configure() {
	mycmakeargs=(
		-DSYSCONFDIR=/etc/${PN}
		-DDOCDIR=/usr/share/${PN}
		-DMANDIR=/usr/share/man
		-DWITH_UMD=OFF
		$(cmake-utils_use_enable debug)
		$(cmake-utils_use_with djvu)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS NEWS README THANKS TODO
	newicon icons/pdf.png ${PN}.png
	make_desktop_entry ${PN} "Alf's PDF Viewer Like Vim" ${PN} "Office;Viewer"
}
