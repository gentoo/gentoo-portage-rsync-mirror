# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libbrahe/libbrahe-1.1.0-r1.ebuild,v 1.4 2013/07/22 20:35:41 ago Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

DESCRIPTION="A Heterogenous C Library of Numeric Functions"
HOMEPAGE="http://www.coyotegulch.com/products/brahe/"
SRC_URI="http://www.coyotegulch.com/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86 ~amd64-linux ~x86-linux"

IUSE="static-libs"

DOCS=( AUTHORS ChangeLog NEWS )
PATCHES=( "${FILESDIR}/${PV}-missing_libs.patch" )
