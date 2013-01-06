# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/twolame/twolame-0.3.12.ebuild,v 1.13 2012/05/05 08:54:56 mgorny Exp $

EAPI=3
inherit libtool

DESCRIPTION="TwoLAME is an optimised MPEG Audio Layer 2 (MP2) encoder"
HOMEPAGE="http://www.twolame.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND=">=media-libs/libsndfile-1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i -e '/CFLAGS/s:-O3::' configure || die

	if [[ ${CHOST} == *solaris* ]]; then
		# libsndfile doesn't like -std=c99 on Solaris
		sed -i -e '/CFLAGS/s:-std=c99::' configure || die
	fi

	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" pkgdocdir="${EPREFIX}/usr/share/doc/${PF}" \
		install || die

	dodoc AUTHORS ChangeLog README TODO
	prepalldocs

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
