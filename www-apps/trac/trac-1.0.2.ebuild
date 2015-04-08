# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac/trac-1.0.2.ebuild,v 1.4 2014/12/31 16:25:35 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE='sqlite?'

DISTUTILS_SINGLE_IMPL=Yes

inherit distutils-r1 eutils user webapp

MY_PV=${PV/_beta/b}
MY_P=Trac-${MY_PV}

DESCRIPTION="Trac is a minimalistic web-based project management, wiki and bug/issue tracking system"
HOMEPAGE="http://trac.edgewall.com/ http://pypi.python.org/pypi/Trac"
SRC_URI="http://ftp.edgewall.com/pub/trac/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="cgi fastcgi i18n mysql postgres +sqlite subversion"
REQUIRED_USE="|| ( mysql postgres sqlite )"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/genshi[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	i18n? ( >=dev-python/Babel-0.9.5[${PYTHON_USEDEP}] )
	cgi? ( virtual/httpd-cgi )
	fastcgi? ( virtual/httpd-fastcgi )
	mysql? ( dev-python/mysql-python[${PYTHON_USEDEP}] )
	postgres? ( >=dev-python/psycopg-2[${PYTHON_USEDEP}] )
	sqlite? (
		>=dev-db/sqlite-3.3.4
	)
	subversion? ( dev-vcs/subversion[python,${PYTHON_USEDEP}] )
	"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

WEBAPP_MANUAL_SLOT="yes"

pkg_setup() {
	python-single-r1_pkg_setup
	webapp_pkg_setup

	enewgroup tracd
	enewuser tracd -1 -1 -1 tracd
}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

src_test() {
	local DISTUTILS_NO_PARALLEL_BUILD=1

	distutils-r1_src_test
}

python_test() {
	PYTHONPATH=. "${PYTHON}" trac/test.py || die "Tests fail with ${EPYTHON}"
}

python_test_all() {
	if use i18n; then
		make check
	fi
}

# the default src_compile just calls setup.py build
# currently, this switches i18n catalog compilation based on presence of Babel

src_install() {
	webapp_src_preinst
	distutils-r1_src_install

	# project environments might go in here
	keepdir /var/lib/trac

	# Use this as the egg-cache for tracd
	dodir /var/lib/trac/egg-cache
	keepdir /var/lib/trac/egg-cache
	fowners tracd:tracd /var/lib/trac/egg-cache

	# documentation
	dodoc -r contrib

	# tracd init script
	newconfd "${FILESDIR}"/tracd.confd tracd
	newinitd "${FILESDIR}"/tracd.initd tracd

	if use cgi; then
		cp contrib/cgi-bin/trac.cgi "${ED}${MY_CGIBINDIR}" || die
	fi
	if use fastcgi; then
		cp contrib/cgi-bin/trac.fcgi "${ED}${MY_CGIBINDIR}" || die
	fi

	for lang in en; do
		webapp_postinst_txt ${lang} "${FILESDIR}"/postinst-${lang}.txt
		webapp_postupgrade_txt ${lang} "${FILESDIR}"/postupgrade-${lang}.txt
	done

	webapp_src_install
}
