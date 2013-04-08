# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaacs/libaacs-0.6.0.ebuild,v 1.1 2013/04/08 05:18:38 radhermit Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="Open implementation of the Advanced Access Content System (AACS) specification"
HOMEPAGE="http://www.videolan.org/developers/libaacs.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/libaacs/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd"
IUSE="static-libs"

RDEPEND="dev-libs/libgcrypt
	dev-libs/libgpg-error"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog KEYDB.cfg README.txt )

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		--disable-optimizations
	)
	autotools-utils_src_configure
}
