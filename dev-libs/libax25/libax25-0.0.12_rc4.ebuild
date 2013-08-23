# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libax25/libax25-0.0.12_rc4.ebuild,v 1.2 2013/08/23 16:37:16 ago Exp $

EAPI=5
inherit versionator

MY_P=${PN}-$(replace_version_separator 3 '-')

DESCRIPTION="AX.25 library for hamradio applications"
HOMEPAGE="http://www.linux-ax25.org/"
SRC_URI="http://www.linux-ax25.org/pub/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install installconf
	dodoc AUTHORS NEWS README
}
