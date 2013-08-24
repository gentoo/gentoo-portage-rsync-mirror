# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libax25/libax25-0.0.12_rc4.ebuild,v 1.3 2013/08/24 09:38:47 tomjbe Exp $

EAPI=5
inherit autotools-utils versionator

MY_P=${PN}-$(replace_version_separator 3 '-')

DESCRIPTION="AX.25 library for hamradio applications"
HOMEPAGE="http://www.linux-ax25.org/"
SRC_URI="http://www.linux-ax25.org/pub/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="static-libs"

S=${WORKDIR}/${MY_P}

AUTOTOOLS_IN_SOURCE_BUILD=1

src_install() {
	autotools-utils_src_install installconf
}
