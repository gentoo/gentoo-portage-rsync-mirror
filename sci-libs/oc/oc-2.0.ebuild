# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/oc/oc-2.0.ebuild,v 1.1 2012/08/04 20:08:03 bicatali Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="Network Data Access Protocol client C library"
HOMEPAGE="http://opendap.org/"
SRC_URI="http://opendap.org/pub/OC/source/${P}.tar.gz"

LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc static-libs"

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

# tests need network
#PROPERTIES=network

src_install() {
	autotools-utils_src_install
	use doc && dohtml *.html
}
