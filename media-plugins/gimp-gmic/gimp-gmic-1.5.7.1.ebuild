# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-gmic/gimp-gmic-1.5.7.1.ebuild,v 1.2 2013/09/21 15:50:16 radhermit Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="G'MIC GIMP plugin"
HOMEPAGE="http://gmic.sourceforge.net/gimp.shtml"
SRC_URI="mirror://sourceforge/gmic/gmic_${PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-gfx/gimp-2.4.0
	media-libs/libpng:0=
	sci-libs/fftw:3.0[threads]
	sys-libs/zlib"
DEPEND="${RDEPEND}"

S=${WORKDIR}/gmic-${PV}/src

src_prepare() {
	epatch "${FILESDIR}"/gmic-1.5.7.1-makefile.patch
}

src_compile() {
	emake CC="$(tc-getCXX)" CFLAGS="${CXXFLAGS}" gimp
}

src_install() {
	exeinto $(gimptool-2.0 --gimpplugindir)/plug-ins
	doexe gmic_gimp
	dodoc ../README
}

pkg_postinst() {
	elog "The G'MIC plugin is accessible from the menu:"
	elog "Filters -> G'MIC"
}
