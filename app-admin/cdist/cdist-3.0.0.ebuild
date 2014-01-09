# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cdist/cdist-3.0.0.ebuild,v 1.1 2014/01/09 21:16:10 hwoarang Exp $

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3} )
inherit distutils-r1

DESCRIPTION="A usable configuration management system"
HOMEPAGE="http://www.nico.schottelius.org/software/cdist/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-text/asciidoc dev-libs/libxslt"
RDEPEND="${PYTHON_DEPS}"

DOCS="README"

src_prepare() {
	rm cdist/conf/.gitignore || die "rm failed"
	distutils-r1_src_prepare
}

src_install() {
	if use doc; then
		HTML_DOCS="docs/man/man1/*.html docs/man/man7/*.html"
	fi
	distutils-r1_src_install
	doman docs/man/man1/*.1 docs/man/man7/*.7
}
