# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kiwi/kiwi-1.9.26.ebuild,v 1.5 2012/02/24 08:02:35 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython 2.7-pypy-*"

inherit distutils versionator

DESCRIPTION="Kiwi is a pure Python framework and set of enhanced PyGTK widgets"
HOMEPAGE="http://www.async.com.br/projects/kiwi/"
SRC_URI="http://download.gnome.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="examples"

DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}"

src_prepare() {
	distutils_src_prepare
	sed -e "s:share/doc/kiwi:share/doc/${PF}:g" -i setup.py || die "sed failed"
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
