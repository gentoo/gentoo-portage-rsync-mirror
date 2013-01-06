# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lockrun/lockrun-2.ebuild,v 1.7 2010/08/11 01:00:23 jer Exp $

inherit toolchain-funcs

DESCRIPTION="Lockrun - runs cronjobs with overrun protection"
HOMEPAGE="http://www.unixwiz.net/tools/lockrun.html"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

RESTRICT="test"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp "${FILESDIR}"/lockrun.c "${S}"/lockrun.c
}

src_compile() {
	emake CC=$(tc-getCC) ${PN} || die "make failed"
}

src_install () {
	dobin ${PN}
}
