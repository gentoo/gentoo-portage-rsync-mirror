# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bfast/bfast-0.6.5a.ebuild,v 1.1 2011/05/18 16:11:49 weaver Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Blat-like Fast Accurate Search Tool"
HOMEPAGE="https://sourceforge.net/projects/bfast/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="dev-perl/XML-Simple"

src_prepare() {
	sed -i -e 's/-m64//' \
		-e 's/CFLAGS="${default_CFLAGS} ${extended_CFLAGS}"/CFLAGS="${CFLAGS} ${default_CFLAGS} ${extended_CFLAGS}"/' \
		configure.ac || die
	eautoreconf
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README
}

src_test() {
	emake check || die
}
