# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/powiedz/powiedz-1.0-r1.ebuild,v 1.2 2009/11/06 22:28:26 ssuominen Exp $

inherit eutils

DESCRIPTION="Polish speech synthesizer based on rsynth"
HOMEPAGE="http://kadu.net/index.php?page=download&lang=en"
SRC_URI="http://kadu.net/download/additions/powiedz-1.0.tgz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-dsp-handle-fix.patch
}

src_compile() {
	emake -f Makefile_plain LDLIBS="-lm" CFLAGS="${CFLAGS}" DEFS="" || die "make failed"
}

src_install() {
	dobin powiedz
	domenu "${FILESDIR}"/${PN}.desktop
}
