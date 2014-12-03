# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-gmic/gimp-gmic-1.6.0.2.ebuild,v 1.1 2014/12/03 08:06:17 radhermit Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="G'MIC GIMP plugin"
HOMEPAGE="http://gmic.sourceforge.net/gimp.shtml"
SRC_URI="mirror://sourceforge/gmic/gmic_${PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=media-gfx/gimp-2.4.0
	media-libs/libpng:0=
	sci-libs/fftw:3.0[threads]
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/gmic-${PV}/src

src_prepare() {
	epatch "${FILESDIR}"/gmic-${PV}-makefile.patch
}

src_compile() {
	emake CC="$(tc-getCXX)" CFLAGS="${CXXFLAGS}" OPT_CFLAGS= DEBUG_CFLAGS= gimp
}

src_install() {
	emake DESTDIR="${D}" install-gimp
	dodoc ../README
}

pkg_postinst() {
	elog "The G'MIC plugin is accessible from the menu:"
	elog "Filters -> G'MIC"
}
