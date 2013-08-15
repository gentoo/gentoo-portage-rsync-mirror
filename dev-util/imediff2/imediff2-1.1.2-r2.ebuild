# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/imediff2/imediff2-1.1.2-r2.ebuild,v 1.3 2013/08/15 03:44:36 patrick Exp $

EAPI="4"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="ncurses"

inherit python versionator

MY_P=${PN}_$(replace_version_separator 3 -)

DESCRIPTION="An interactive, user friendly 2-way merge tool in text mode."
HOMEPAGE="http://elonen.iki.fi/code/imediff/"
SRC_URI="mirror://debian/pool/main/i/${PN}/${MY_P}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python[ncurses]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs 2 imediff2
}

src_compile() {
	# Otherwise the docs get regenerated :)
	:
}

src_install() {
	dobin imediff2
	dodoc AUTHORS README
	doman imediff2.1
}
