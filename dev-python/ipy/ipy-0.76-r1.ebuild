# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipy/ipy-0.76-r1.ebuild,v 1.2 2013/04/06 14:39:31 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2} pypy2_0 )

inherit distutils-r1

MY_PN="IPy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Class and tools for handling of IPv4 and IPv6 addresses and networks"
HOMEPAGE="https://github.com/haypo/python-ipy/wiki http://pypi.python.org/pypi/IPy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS=( ChangeLog README )

python_test() {
	"${PYTHON}" test/test_IPy.py || die
	# doctests for py3 unaltered read py2 files from "${S}" causing total failure
	if [[ ${EPYTHON} == python3* ]]; then
		cd "${BUILD_DIR}/lib" || die
		cp -r "${S}"/{README,test_doc.py} . || die
		mkdir test && cp -r "${S}"/test/test.rst test/ || die
		"${PYTHON}" test_doc.py || die
		# If left these files are wrongly installed; tidy up
		rm -f ./{README,test_doc.py,test/test.rst} && rmdir test || die
	else
		"${PYTHON}" test_doc.py || die
	fi
	einfo "tests passed under ${EPYTHON}"
}
