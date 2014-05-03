# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/rudiments/rudiments-0.46.ebuild,v 1.1 2014/05/03 22:40:26 pinkbyte Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="C++ class library for daemons, clients and servers"
HOMEPAGE="http://rudiments.sourceforge.net/"
SRC_URI="mirror://sourceforge/rudiments/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug pcre ssl static-libs"

DEPEND="pcre? ( dev-libs/libpcre )
	ssl? ( dev-libs/openssl:0 )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-buildsystem.patch" )

src_configure() {
	local myeconfargs=(
		--docdir="/usr/share/doc/${PF}/html" \
		$(use debug && "--enable-debug") \
		$(use_enable pcre) \
		$(use_enable ssl)
	)
	autotools-utils_src_configure
}
