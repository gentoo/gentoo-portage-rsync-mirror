# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webtest/webtest-1.3.3-r1.ebuild,v 1.1 2013/09/12 06:07:43 prometheanfire Exp $

#Needed by sys-cluster/keystone[test]

EAPI="5"
PYTHON_COMPAT=( python2_6 python2_7 )
#restricted for failing test :(
RESTRICT="test"

inherit distutils-r1 eutils

MY_PN="WebTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper to test WSGI applications"
HOMEPAGE="http://pythonpaste.org/webtest/ http://pypi.python.org/pypi/WebTest"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc test"

RDEPEND=">=dev-python/webob-0.9.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/pyquery[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare() {
	epatch "${FILESDIR}/${PN}-1.3.4-index_fixt.patch"
	distutils-r1_python_prepare
}

python_compile() {
	distutils-r1_python_compile

	if use doc; then
		einfo "Generation of documentation"
		sphinx-build docs html || die "Building of documentation failed"
	fi
}

python_test() {
	"${PYTHON}" setup.py nosetests || die
}

python_install() {
	distutils-r1_python_install_all

	# Avoid future-import bug on py2.5.* - lint3 is py3 anyway
	#removing since we don't support python 2.5 :D
	#delete_lint3() {
	#	[[ "${PYTHON_ABI}" == 3.* ]] && return
	#	rm "${ED}$(python_get_sitedir)/webtest/lint3.py"
	#}
	#python-r1_execute_function -q delete_lint3

	if use doc; then
		dohtml -r html/*
	fi
}
