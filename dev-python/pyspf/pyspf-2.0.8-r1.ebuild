# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyspf/pyspf-2.0.8-r1.ebuild,v 1.1 2014/03/21 04:28:39 idella4 Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_REQ_USE="ipv6"		# Required for tests
inherit distutils-r1

DESCRIPTION="Python implementation of the Sender Policy Framework (SPF) protocol"
HOMEPAGE="http://pypi.python.org/pypi/pyspf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# >=python-3.3 comes with the built-in ipaddress module
PY23_USEDEP=$(python_gen_usedep 'python2*' python3_2)
PY2_USEDEP=$(python_gen_usedep 'python2*')
PY3_USEDEP=$(python_gen_usedep 'python3*')
RDEPEND="dev-python/authres[${PYTHON_USEDEP}]
	$(python_gen_cond_dep "dev-python/ipaddr[${PY23_USEDEP}]" 'python2*' python3_2)
	$(python_gen_cond_dep "dev-python/pydns:2[${PY2_USEDEP}]" 'python2*')
	$(python_gen_cond_dep "dev-python/pydns:3[${PY3_USEDEP=}]" python3*)"

DEPEND="test? ( ${RDEPEND}
	dev-python/pyyaml[${PYTHON_USEDEP}] )"

python_test() {
	# if a 'run' makes it to the end and there are test failures, this will always return 0.
	# A patch is planned for submitting upstream.  This state won't occur in most cases.
	pushd test &> /dev/null
	"${PYTHON}" testspf.py || die
	popd &> /dev/null
}
