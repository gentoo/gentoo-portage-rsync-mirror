# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/glances/glances-1.4.2.1.ebuild,v 1.1 2012/10/06 09:24:36 jlec Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="CLI curses based monitoring tool"
HOMEPAGE="
	https://github.com/nicolargo/glances/blob/master/README.md
	http://pypi.python.org/pypi/Glances"
SRC_URI="https://github.com/downloads/nicolargo/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="html"

DEPEND=""
RDEPEND="
	>=dev-python/psutil-0.4.1
	html? ( dev-python/jinja )"

src_prepare() {
	sed \
		-e "s:share/doc/glances:share/doc/${PF}:g" \
		-e "/COPYING/d" -i setup.py || die
	distutils_src_prepare
}
