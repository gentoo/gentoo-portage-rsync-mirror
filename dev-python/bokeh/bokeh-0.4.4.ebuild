# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bokeh/bokeh-0.4.4.ebuild,v 1.2 2014/07/07 07:56:48 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Statistical and interactive HTML plots for Python"
HOMEPAGE="http://bokeh.pydata.org/"
SRC_URI="https://github.com/ContinuumIO/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples test chaco"
# docs require napoleon sphinx extension which will be included in next sphinx release

RDEPEND="
	>=dev-python/flask-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-0.23[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.7[${PYTHON_USEDEP}]
	>=dev-python/markdown-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/markupsafe-0.18[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.11[${PYTHON_USEDEP}]
	>=dev-python/pygments-1.6[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]
	>=dev-python/pystache-0.5.3[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013b[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/redis-py-2.7.6[${PYTHON_USEDEP}]
	>=dev-python/requests-1.2.3[${PYTHON_USEDEP}]
	>=dev-python/six-1.5.2[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-0.9.1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/gevent-1.0[${PYTHON_USEDEP}]' python2_7)
	$(python_gen_cond_dep '>=dev-python/gevent-websocket-0.9.2[${PYTHON_USEDEP}]' python2_7)
	chaco? (
		$(python_gen_cond_dep '>=dev-python/traits-4.4[${PYTHON_USEDEP}]' python2_7)
		$(python_gen_cond_dep '>=dev-python/chaco-4.4[${PYTHON_USEDEP}]' python2_7)
	)

"
# testing server: needs websocket not in portage yet
#			>=dev-python/websocket[${PYTHON_USEDEP}]
# hdf5 backend: needs array management not in portage yet
DEPEND="
	test? (
		${RDEPEND}
		>=dev-python/nose-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/colorama-0.2.7[${PYTHON_USEDEP}]
	)
"
DOCS=( CHANGELOG QUICKSTART.md README.md )

DISTUTILS_NO_PARALLEL_BUILD=1

python_prepare_all() {
	# Fix test_references_by_ref_by_value from test_object.py
	local PATCHES=( "${FILESDIR}"/${P}-fix_test_object.patch )
	# Remove broken test case
	sed -i -e "s:MetaTest:_&:" bokeh/tests/test_bokeh_init.py || die

	if ! use chaco; then
		sed -i -e "/'bokeh.chaco_gg'/d" setup.py || die
	fi

	distutils-r1_python_prepare_all
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}

python_test() {
	cd "${BUILD_DIR}"/lib || die
	# exclude server tests for now
	nosetests -v \
		-e multiuser_auth_test \
		-e usermodel_test \
		|| die
}

pkg_postinst() {
	elog "websockets work only with python2_7"
	local chaco_msg="chaco useflag doesn't affect python targets other than python2_7"
	if use chaco; then
		if use python_targets_python2_7; then
			elog "${chaco_msg}"
		else
			ewarn "${chaco_msg}"
		fi
	fi
}
