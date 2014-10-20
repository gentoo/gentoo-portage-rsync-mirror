# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openctm/openctm-1.0.3.ebuild,v 1.6 2014/10/20 08:02:33 jlec Exp $

EAPI=5

inherit eutils multilib versionator flag-o-matic

MY_PF=OpenCTM-${PV}

DESCRIPTION="OpenCTM - the Open Compressed Triangle Mesh."
HOMEPAGE="http://openctm.sourceforge.net"
SRC_URI="mirror://debian/pool/main/o/${PN}/${PN}_${PV}+dfsg1.orig.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/tinyxml
	media-libs/freeglut
	media-libs/glew
	media-libs/pnglite
	virtual/opengl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PF}"

src_prepare() {
	epatch \
		"${FILESDIR}"/openctm-fix-makefiles.patch \
		"${FILESDIR}"/openctm-no-strip.patch
	mv Makefile.linux Makefile || die
	sed \
		-e "s:@GENTOO_LIBDIR@:$(get_libdir):g" \
		-i Makefile || die
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX)
}
