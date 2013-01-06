# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lupy/lupy-0.2.1-r1.ebuild,v 1.6 2010/07/03 22:46:32 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Lupy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Lupy is a is a full-text indexer and search engine written in Python."
HOMEPAGE="http://divmod.org/projects/lupy http://pypi.python.org/pypi/Lupy"
SRC_URI="mirror://sourceforge/lupy/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~s390 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="changelog.txt releasenotes.txt"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
