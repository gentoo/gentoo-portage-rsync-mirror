# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librelp/librelp-1.2.7.ebuild,v 1.2 2014/08/10 20:37:44 slyfox Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="An easy to use library for the RELP protocol"
HOMEPAGE="http://www.librelp.com/"
SRC_URI="http://download.rsyslog.com/${PN}/${P}.tar.gz"

LICENSE="GPL-3 doc? ( FDL-1.3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~sparc ~x86"
IUSE="debug doc +ssl static-libs"

RDEPEND="
	ssl? ( >=net-libs/gnutls-2.12.23-r1 )
"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS ChangeLog )

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
		$(use_enable ssl tls)
	)

	autotools-utils_src_configure
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# We don't need the *.la files - do we?
	find "${ED}"/usr/ -name '*.la' -delete

	if use doc; then
		dohtml doc/relp.html
	fi
}
