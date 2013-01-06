# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/dslib/dslib-2.1.2.ebuild,v 1.1 2012/11/30 09:34:35 scarabeus Exp $

EAPI=4

PYTHON_DEPEND="*"

inherit distutils

DESCRIPTION="Library to access Czech eGov system \"Datove schranky\""
HOMEPAGE="http://labs.nic.cz/page/969/datovka/"
SRC_URI="http://www.nic.cz/public_media/datove_schranky/releases/datovka-2.1.2/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	dev-python/pyasn1
	dev-python/pyopenssl
	dev-python/sudsds
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 "${WORKDIR}"
}
