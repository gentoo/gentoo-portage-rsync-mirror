# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.4.10.ebuild,v 1.9 2012/12/27 09:24:39 armin76 Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils multilib

DESCRIPTION="Various LDAP-related Python modules"
HOMEPAGE="http://www.python-ldap.org http://pypi.python.org/pypi/python-ldap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-solaris"
IUSE="doc examples sasl ssl"

# If you need support for openldap-2.3.x, please use python-ldap-2.3.9.
# python team: Please do not remove python-ldap-2.3.9 from the tree.
RDEPEND=">=net-nds/openldap-2.4
	dev-python/pyasn1
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

DOCS="CHANGES README"
PYTHON_MODNAME="dsml.py ldapurl.py ldif.py ldap"

src_prepare() {
	local rpath=
	# sloppy logic, maybe better check if compiler links with GNU-ld
	[[ ${CHOST} != *-darwin* ]] && rpath="-Wl,-rpath=${EPREFIX}/usr/$(get_libdir)/sasl2"
	# Note: we can't add /usr/lib and /usr/lib/sasl2 to library_dirs due to a bug in py2.4
	sed -e "s:^library_dirs =.*:library_dirs =:" \
		-e "s:^include_dirs =.*:include_dirs = ${EPREFIX}/usr/include ${EPREFIX}/usr/include/sasl:" \
		-e "s:\(extra_compile_args =\).*:\1\nextra_link_args = ${rpath}:" \
		-i setup.cfg || die "error fixing setup.cfg"

	local mylibs="ldap"
	if use sasl; then
		use ssl && mylibs="ldap_r"
		mylibs="${mylibs} sasl2"
	else
		sed -e 's/HAVE_SASL//g' -i setup.cfg || die
	fi
	use ssl && mylibs="${mylibs} ssl crypto"

	sed -e "s:^libs = .*:libs = lber resolv ${mylibs}:" \
		-e "s:^compile.*:compile = 0:" \
		-e "s:^optimize.*:optimize = 0:" \
		-i setup.cfg || die "error setting up libs in setup.cfg"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		pushd Doc &> /dev/null
		PYTHONPATH="$(ls -d ../build-$(PYTHON -f --ABI)/lib*)" \
			sphinx-build -b html -d	_build/doctrees . _build/html
		popd Doc &> /dev/null
	fi
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r Demo
	fi

	if use doc; then
		dohtml -r Doc/_build/html/
	fi
}
