# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/czmq/czmq-1.2.0-r1.ebuild,v 1.3 2013/12/24 10:50:09 ultrabug Exp $

EAPI=5
inherit autotools

DESCRIPTION="CZMQ - High-level C Binding for ZeroMQ"
HOMEPAGE="http://czmq.zeromq.org"
SRC_URI="http://download.zeromq.org/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm hppa ~x86"
IUSE="doc static-libs"

RDEPEND=""
DEPEND="doc? (
			app-text/asciidoc
			app-text/xmlto
		)
		>=net-libs/zeromq-2.1
		<net-libs/zeromq-4"

DOCS=( NEWS README AUTHORS ChangeLog )

src_prepare() {
	sed -i -e 's|-Werror||g' configure.in || die
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default

	doman doc/*.[1-9]

	# remove useless .la files
	find "${D}" -name '*.la' -delete

	# remove useless .a (only for non static compilation)
	use static-libs || find "${D}" -name '*.a' -delete
}
