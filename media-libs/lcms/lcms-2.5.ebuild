# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-2.5.ebuild,v 1.3 2013/11/11 13:35:29 jer Exp $

EAPI=5
AUTOTOOLS_PRUNE_LIBTOOL_FILES="modules"
inherit autotools-utils

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="mirror://sourceforge/${PN}/lcms2-${PV}.tar.gz"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc jpeg static-libs test tiff zlib"

RDEPEND="jpeg? ( virtual/jpeg:0 )
	tiff? ( media-libs/tiff:0= )
	zlib? ( sys-libs/zlib:= )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/lcms2-${PV}

src_configure() {
	local myeconfargs=(
		$(use_with jpeg)
		$(use_with tiff)
		$(use_with zlib)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use doc; then
		docinto pdf
		dodoc doc/*.pdf
	fi
}
