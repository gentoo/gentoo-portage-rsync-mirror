# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnsres/libdnsres-0.1a-r2.ebuild,v 1.4 2013/03/09 18:10:22 ago Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

DESCRIPTION="A non-blocking DNS resolver library"
HOMEPAGE="http://www.monkey.org/~provos/libdnsres/"
SRC_URI="http://www.monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-libs/libevent"
RDEPEND="${DEPEND}"

DOCS=( README )
PATCHES=( "${FILESDIR}/${P}-autotools.patch" )
