# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/engauge/engauge-4.1-r1.ebuild,v 1.5 2012/10/07 11:54:41 pacho Exp $

EAPI=4
inherit versionator qt4-r2 eutils

DESCRIPTION="Convert an image file showing a graph or map into numbers"
HOMEPAGE="http://digitizer.sourceforge.net/"
SRC_URI="mirror://sourceforge/digitizer/digit-src-$(replace_version_separator . _).tar.gz -> ${P}.tar.gz
	http://dev.gentoo.org/~calchan/distfiles/${P}_qt4.patch.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="x11-libs/qt-qt3support:4
	sci-libs/fftw:3.0
	x11-libs/libXft"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${DISTDIR}"/${P}_qt4.patch.xz

	# Some Debian patches to fix compilation problems
	epatch "${FILESDIR}/${PN}-5.1-gcc47.patch"
	epatch "${FILESDIR}/${PN}-5.1-qreal-double.patch"

	# Some patching and using the DEBIAN_PACKAGE ifdef is necessary to make sure the
	# documentation is looked for in the proper directory
	sed -i -e "s:/usr/share/doc/engauge-digitizer-doc:${ROOT}/usr/share/doc/${PF}:" \
		src/digitmain.cpp || die "sed failed"
	sed -i -e '/unix {/a DEFINES += DEBIAN_PACKAGE' \
		digitizer.pro || die "sed failed"
}

src_configure() {
	eqmake4 digitizer.pro
}

src_install() {
	dobin bin/engauge
	newicon src/img/lo32-app-digitizer.png "${PN}.png"
	make_desktop_entry engauge "Engauge Digitizer" ${PN} Graphics
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r usermanual
	fi
	if use examples; then
		doins -r samples
	fi
}
