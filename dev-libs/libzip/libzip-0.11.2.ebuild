# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzip/libzip-0.11.2.ebuild,v 1.6 2015/01/01 11:20:29 ago Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="Library for manipulating zip archives"
HOMEPAGE="http://www.nih.at/libzip/"
SRC_URI="http://www.nih.at/libzip/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/xz-utils
"

DOCS=( AUTHORS NEWS README THANKS )

PATCHES=(
	"${FILESDIR}/${PN}-0.11.2-headers.patch"
	"${FILESDIR}/${PN}-0.11-fix_pkgconfig.patch"
)
