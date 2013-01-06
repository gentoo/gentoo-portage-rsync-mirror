# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pyrpub/pyrpub-2.1.1.ebuild,v 1.11 2011/03/06 00:52:35 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="pyrite-publisher-${PV}"

DESCRIPTION="content conversion tool for Palm"
HOMEPAGE="http://www.pyrite.org/publisher/"
SRC_URI="http://www.pyrite.org/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="ChangeLog NEWS README* doc/*.pdb"
PYTHON_MODNAME="PyritePublisher"

src_install () {
	distutils_src_install
	doman doc/*.1
	dohtml -r doc/pyrite-publisher
}
