# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libexttextcat/libexttextcat-3.3.1.ebuild,v 1.3 2012/07/31 14:13:46 scarabeus Exp $

EAPI=4

DESCRIPTION="Library implementing N-gram-based text categorization"
HOMEPAGE="http://software.wise-guys.nl/libtextcat/"
SRC_URI="http://dev-www.libreoffice.org/src/${PN}/${P}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--disable-werror \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
