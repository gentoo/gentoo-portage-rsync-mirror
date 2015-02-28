# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-constraint/logilab-constraint-0.5.0-r1.ebuild,v 1.3 2015/02/28 15:11:34 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A finite domain constraints solver written in 100% pure Python"
HOMEPAGE="http://www.logilab.org/project/logilab-constraint"
SRC_URI="ftp://ftp.logilab.org/pub/constraint/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="doc examples"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/logilab-common[${PYTHON_USEDEP}]"

DOCS=( doc/CONTRIBUTORS )

python_install() {
	# Avoid collisions with dev-python/logilab-common.
	distutils-r1_python_install
	rm -f "${D}$(python_get_sitedir)/logilab/__init__.py" || die
}

python_install_all() {
	use doc && dohtml doc/documentation.html
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
