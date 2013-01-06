# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procinfo-ng/procinfo-ng-2.0.304.ebuild,v 1.5 2010/07/12 17:59:44 fauli Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Completely rewrite of the old system monitoring app procinfo."
HOMEPAGE="http://sourceforge.net/projects/procinfo-ng/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	!app-admin/procinfo"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
	# removing -s flag as portage does the stripping part and add support
	# for custom LDFLAGS. Plus correct for --as-needed
	sed -e 's:-s -lncurses:${LDFLAGS}:' \
		-i configure.in || die "sed configure.in failed"
	eautoreconf
}

src_compile() {
	emake LIBS="-lncurses" || die "compile failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
}
