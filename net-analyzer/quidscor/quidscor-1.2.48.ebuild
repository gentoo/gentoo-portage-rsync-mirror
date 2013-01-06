# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/quidscor/quidscor-1.2.48.ebuild,v 1.8 2011/01/15 23:59:27 mr_bones_ Exp $

inherit eutils

DESCRIPTION="IDS/VA Correlation engine"
HOMEPAGE="http://quidscor.sourceforge.net/"
SRC_URI="mirror://sourceforge/quidscor/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4
	>=net-misc/curl-7.10
	>=net-analyzer/snort-2.0"

src_unpack() {
	unpack ${A}
	sed -i '/^CFLAGS=/s: -g : :' ${S}/Makefile || die
	#yes, the fix below is as pathetic as it seems
	echo "#define FALSE 0" >> ${S}/libqg/libqg.h
	echo "#define TRUE 1" >> ${S}/libqg/libqg.h
	epatch "${FILESDIR}"/${P}-strip.patch
}

src_compile() {
	emake EXTRA_CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake PREFIX=/usr STAGING_PREFIX=${D} install || die
	dodoc ChangeLog FAQ MANIFEST README TODO
	# fix ugly install
	cd ${D}/usr
	mv etc ..
	rm -rf doc
}
