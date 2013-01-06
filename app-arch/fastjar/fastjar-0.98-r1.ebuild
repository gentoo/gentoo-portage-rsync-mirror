# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/fastjar/fastjar-0.98-r1.ebuild,v 1.5 2010/07/19 01:14:13 josejx Exp $

EAPI=2

inherit eutils

DESCRIPTION="A jar program written in C"
HOMEPAGE="https://savannah.nongnu.org/projects/fastjar"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

IUSE=""

# bug #188542
RDEPEND="!<=dev-java/kaffe-1.1.7-r5"
DEPEND=""

src_prepare() {
	# bug #325557
	epatch "${FILESDIR}/0.98-traversal.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
