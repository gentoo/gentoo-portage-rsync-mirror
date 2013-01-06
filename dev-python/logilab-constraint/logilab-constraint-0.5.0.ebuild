# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-constraint/logilab-constraint-0.5.0.ebuild,v 1.3 2012/08/27 15:23:30 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A finite domain constraints solver written in 100% pure Python"
HOMEPAGE="http://www.logilab.org/project/logilab-constraint"
SRC_URI="ftp://ftp.logilab.org/pub/constraint/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="examples"

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/logilab-common"

DOCS="doc/CONTRIBUTORS"
PYTHON_MODNAME="logilab/constraint"

src_install() {
	distutils_src_install

	delete_unneeded_files() {
		# Avoid collisions with dev-python/logilab-common.
		rm -f "${ED}$(python_get_sitedir)/logilab/__init__.py"
	}
	python_execute_function -q delete_unneeded_files

	if use examples; then
		dohtml doc/documentation.html
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
