# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/surl/surl-0.7.0-r1.ebuild,v 1.1 2010/04/26 09:00:26 wired Exp $

EAPI=3
PYTHON_DEPEND=2

inherit distutils

DESCRIPTION="URL shortening command line application that supports various sites."
HOMEPAGE="http://launchpad.net/surl"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV%.*}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	distutils_src_install

	dodoc AUTHORS.txt || die "doc install failed"
}
