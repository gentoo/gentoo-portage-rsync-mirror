# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/glimmer/glimmer-3.02-r1.ebuild,v 1.4 2010/01/03 14:17:04 pacho Exp $

EAPI="2"

inherit eutils

MY_PV=${PV//./}

DESCRIPTION="An HMM-based microbial gene finding system from TIGR"
HOMEPAGE="http://www.cbcb.umd.edu/software/glimmer/"
SRC_URI="http://www.cbcb.umd.edu/software/${PN}/${PN}${MY_PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="app-shells/tcsh
	!app-crypt/pkcrack
	!media-libs/libextractor"

S="${WORKDIR}/${PN}${PV}"

src_prepare() {
	sed -i -e 's|\(set awkpath =\).*|\1 /usr/share/'${PN}'/scripts|' \
		-e 's|\(set glimmerpath =\).*|\1 /usr/bin|' scripts/* || die "failed to rewrite paths"
	# Fix Makefile to die on failure
	sed -i 's/$(MAKE) $(TGT)/$(MAKE) $(TGT) || exit 1/' src/c_make.gen || die
	# GCC 4.3 include fix
	sed -i 's/include  <string>/include  <string.h>/' src/Common/delcher.hh || die
	epatch "${FILESDIR}/${PN}-${PV}-glibc210.patch"
}

src_compile() {
	emake -C src || die
}

src_install() {
	rm bin/test
	dobin bin/* || die

	dodir /usr/share/${PN}/scripts
	insinto /usr/share/${PN}/scripts
	doins scripts/* || die

	dodoc glim302notes.pdf
}
