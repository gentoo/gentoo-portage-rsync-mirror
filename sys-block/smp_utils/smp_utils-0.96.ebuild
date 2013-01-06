# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/smp_utils/smp_utils-0.96.ebuild,v 1.2 2012/02/23 07:22:06 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Utilities for SAS management protocol (SMP)"
HOMEPAGE="http://sg.danny.cz/sg/smp_utils.html"
SRC_URI="http://sg.danny.cz/sg/p/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch

	sed -i \
		-e '/^INSTDIR=/s:/bin:/sbin:' \
		-e 's:$(DESTDIR)/:$(DESTDIR):' \
		-e 's:install -s :install :' \
		Makefile */Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc AUTHORS ChangeLog COVERAGE CREDITS README
}
