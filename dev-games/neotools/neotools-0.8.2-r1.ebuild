# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neotools/neotools-0.8.2-r1.ebuild,v 1.3 2010/10/15 12:34:29 ranger Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Various development tools for NeoEngine"
HOMEPAGE="http://www.neoengine.org/"
SRC_URI="mirror://sourceforge/neoengine/neotools-${PV}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=dev-games/neoengine-${PV}
	app-arch/bzip2"

S=${WORKDIR}/neotools

src_prepare() {
	sed -i \
		-e 's/BUILD_STATIC/BUILD_DYNAMIC/g' \
		-e 's/_static//g' \
		nscemake/Makefile.am \
		|| die "sed failed"
	sed -i \
		-e 's:"bzip2/bzlib.h":<bzlib.h>:' \
		npacmake/main.cpp \
		|| die "sed failed"
	sed -i \
		-e '/npacmake_SOURCES/s/main.cpp.*/main.cpp/' \
		-e '/npacmake_LDADD/s/$/ -lbz2/' \
		npacmake/Makefile.am \
		|| die "sed failed"
	sed -i \
		-e 's/ -Werror//' \
		configure.in \
		|| die "sed failed"

	epatch "${FILESDIR}"/${P}-errno.patch \
		"${FILESDIR}"/${P}-gcc43.patch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog*
}
