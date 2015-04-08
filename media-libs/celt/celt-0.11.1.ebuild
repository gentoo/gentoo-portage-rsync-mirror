# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/celt/celt-0.11.1.ebuild,v 1.7 2014/08/10 21:08:08 slyfox Exp $

EAPI="2"

DESCRIPTION="CELT is a very low delay audio codec designed for high-quality communications"
HOMEPAGE="http://www.celt-codec.org/"
SRC_URI="http://downloads.us.xiph.org/releases/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ogg static-libs"

DEPEND="ogg? ( media-libs/libogg )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with ogg ogg /usr)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README TODO || die "dodoc failed."

	use static-libs || find "${D}" -name '*.la' -delete
}
