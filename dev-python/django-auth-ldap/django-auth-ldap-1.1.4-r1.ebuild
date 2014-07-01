# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-auth-ldap/django-auth-ldap-1.1.4-r1.ebuild,v 1.3 2014/07/01 04:52:03 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Django LDAP authentication backend"
HOMEPAGE="http://pypi.python.org/pypi/django-auth-ldap http://bitbucket.org/psagers/django-auth-ldap/"
SRC_URI="mirror://bitbucket.org/psagers/django-auth-ldap/get/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="django_auth_ldap"

RDEPEND=">=dev-python/django-1.3.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/python-ldap[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/docs.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	pushd test > /dev/null || die
	set -- django-admin.py test django_auth_ldap --settings=test.settings
	echo "$@"
	"$@" || die "Tests failed with ${EPYTHON}"
	popd > /dev/null || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
