# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/json-c/json-c-0.9-r1.ebuild,v 1.8 2012/09/30 18:14:18 armin76 Exp $

EAPI="4"

DESCRIPTION="A JSON implementation in C"
HOMEPAGE="http://oss.metaparadigm.com/json-c/"
SRC_URI="http://oss.metaparadigm.com/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="static-libs"

DOCS=( README )

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	dohtml README.html || die "dohtml failed"
	use static-libs || { find "${ED}" -name '*.la' -exec rm {} + || die; }
}
