# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.4.12.ebuild,v 1.1 2013/06/03 06:18:37 patrick Exp $

EAPI=5

# pypy: bug #458558 (wrong linker options due to not respecting CC)
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 multilib

DESCRIPTION="Various LDAP-related Python modules"
HOMEPAGE="http://www.python-ldap.org http://pypi.python.org/pypi/python-ldap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="doc examples sasl ssl"

# If you need support for openldap-2.3.x, please use python-ldap-2.3.9.
# python team: Please do not remove python-ldap-2.3.9 from the tree.
RDEPEND=">=net-nds/openldap-2.4
	dev-python/pyasn1[${PYTHON_USEDEP}]
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_prepare_all() {
	sed -e "s:^library_dirs =.*:library_dirs = /usr/$(get_libdir) /usr/$(get_libdir)/sasl2:" \
		-e "s:^include_dirs =.*:include_dirs = ${EPREFIX}/usr/include ${EPREFIX}/usr/include/sasl:" \
		-i setup.cfg || die "error fixing setup.cfg"

	local mylibs="ldap"
	if use sasl; then
		use ssl && mylibs="ldap_r"
		mylibs="${mylibs} sasl2"
	else
		sed -e 's/HAVE_SASL//g' -i setup.cfg || die
	fi
	use ssl && mylibs="${mylibs} ssl crypto"
	use elibc_glibc && mylibs="${mylibs} resolv"

	sed -e "s:^libs = .*:libs = lber ${mylibs}:" \
		-i setup.cfg || die "error setting up libs in setup.cfg"

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		cd Doc || die
		sphinx-build -b html -d _build/doctrees . _build/html || die
	fi
}

python_test() {
	# XXX: the tests supposedly can start local slapd
	# but it requires some manual config, it seems.

	"${PYTHON}" Tests/t_ldapurl.py || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( Doc/_build/html/. )

	distutils-r1_python_install_all

	if use examples; then
		dodoc -r Demo
		docompress -x /usr/share/doc/${FP}/Demo
	fi
}
