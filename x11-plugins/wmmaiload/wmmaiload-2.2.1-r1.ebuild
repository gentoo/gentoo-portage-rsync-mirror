# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmaiload/wmmaiload-2.2.1-r1.ebuild,v 1.9 2012/05/05 05:12:03 jdhore Exp $

EAPI="1"

inherit eutils toolchain-funcs

DESCRIPTION="dockapp that monitors one or more mailboxes."
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk.patch
	epatch "${FILESDIR}"/${P}-checkthread.patch
}

src_compile() {
	./configure -p /usr || die "configure failed."
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		DEBUG_LDFLAGS="" LDFLAGS="${LDFLAGS}" \
		DEBUG_CFLAGS="" || die "emake failed."
}

src_install () {
	dobin ${PN}/${PN} ${PN}-config/${PN}-config
	doman doc/*.1
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO doc/sample.${PN}rc
}
