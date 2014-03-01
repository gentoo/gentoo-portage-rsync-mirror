# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaacs/libaacs-0.5.0.ebuild,v 1.7 2014/03/01 22:36:39 mgorny Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Open implementation of the Advanced Access Content System (AACS) specification"
HOMEPAGE="http://www.videolan.org/developers/libaacs.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/libaacs/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~amd64-fbsd"
IUSE="static-libs"

RDEPEND="dev-libs/libgcrypt:0
	dev-libs/libgpg-error"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog KEYDB.cfg README.txt )
PATCHES=( "${FILESDIR}/bison_2.6.patch" )

src_configure() {
	local myeconfargs=(
		--disable-optimizations
	)
	autotools-utils_src_configure
}
