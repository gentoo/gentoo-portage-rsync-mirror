# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openpgm/openpgm-5.2.122.ebuild,v 1.3 2014/03/04 20:12:04 ago Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools-utils python-any-r1

DESCRIPTION="Open source implementation of the Pragmatic General Multicast specification"
HOMEPAGE="http://code.google.com/p/openpgm"
SRC_URI="http://openpgm.googlecode.com/files/libpgm-${PV}~dfsg.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="static-libs"

DEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/libpgm-${PV}~dfsg/${PN}/pgm"

src_install() {
	DOCS=( "${S}"/../doc/. "${S}"/README )

	autotools-utils_src_install
}
