# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaacs/libaacs-0.7.0-r1.ebuild,v 1.2 2014/05/16 03:50:07 mrueg Exp $

EAPI=5

inherit autotools-multilib

DESCRIPTION="Open implementation of the Advanced Access Content System (AACS) specification"
HOMEPAGE="http://www.videolan.org/developers/libaacs.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/libaacs/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd"
IUSE="static-libs"

RDEPEND="dev-libs/libgcrypt:0[${MULTILIB_USEDEP}]
	dev-libs/libgpg-error[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc"

DOCS=( ChangeLog KEYDB.cfg README.txt )

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		--disable-optimizations
	)
	autotools-multilib_src_configure
}
