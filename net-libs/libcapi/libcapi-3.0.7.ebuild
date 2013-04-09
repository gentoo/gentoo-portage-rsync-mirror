# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapi/libcapi-3.0.7.ebuild,v 1.1 2013/04/09 06:43:21 pinkbyte Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="CAPI library used by AVM products"
HOMEPAGE="http://www.tabos.org/ffgtk"
SRC_URI="http://www.tabos.org/ffgtk/download/libcapi20-${PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/capi20"

PATCHES=( "${FILESDIR}/${P}-remove-libcapi20dyn.patch" )
