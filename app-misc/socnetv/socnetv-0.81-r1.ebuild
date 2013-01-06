# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/socnetv/socnetv-0.81-r1.ebuild,v 1.4 2011/01/25 12:19:37 fauli Exp $

EAPI="2"

inherit eutils qt4-r2 toolchain-funcs

MY_PN="SocNetV"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Qt Social Network Visualizer"
HOMEPAGE="http://socnetv.sourceforge.net/"
SRC_URI="mirror://sourceforge/socnetv/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="x11-libs/qt-gui:4
		x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

src_prepare() {
	qt4-r2_src_prepare
	sed -i "s/@make/@+make/" Makefile.in \
		|| die "Fix parallel build"
}

src_compile() {
	emake CXX="$(tc-getCXX)" CXXFLAGS="${LDFLAGS} ${CXXFLAGS}" \
		LFLAGS="${LDFLAGS}"
}

src_install() {
	dobin socnetv || die "dobin failed"
	doicon src/images/socnetv.png || die "doicon failed"
	make_desktop_entry  ${PN} SocNetV ${PN} 'Science' \
		|| die "make_desktop_entry failed"
	insinto /usr/share/${PN}/examples || die "insinto failed"
	doins nets/* || die "doins failed"
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
	if use doc; then
		dohtml -r "${S}"/manual/* || die "dohtml failed"
	fi
	doman "${S}/man/${PN}.1.gz" || die "doman failed"
}
