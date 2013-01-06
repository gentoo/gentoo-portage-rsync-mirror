# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/the_silver_searcher/the_silver_searcher-0.8.ebuild,v 1.3 2012/10/17 03:32:25 phajdan.jr Exp $

EAPI=4
inherit autotools

DESCRIPTION="A code-searching tool similar to ack, but faster"
HOMEPAGE="http://github.com/ggreer/the_silver_searcher"
SRC_URI="mirror://github/ggreer/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/libpcre"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

DOCS="README.md"

src_prepare() {
	eautoreconf
}
