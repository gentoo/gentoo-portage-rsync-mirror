# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ldaptor/ldaptor-0.0.43.ebuild,v 1.20 2013/09/12 22:29:23 mgorny Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5 *-jython 2.7-pypy-*"  # pypy fails several tests
DISTUTILS_SRC_TEST="trial"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

inherit distutils eutils

DESCRIPTION="set of LDAP utilities for use from the command line"
HOMEPAGE="http://www.inoi.fi/open/trac/ldaptor"
SRC_URI="mirror://debian/pool/main/l/ldaptor/${PN}_${PV}.orig.tar.gz
	doc? ( mirror://gentoo/${PN}-0.0.42-dia-pictures.tar.gz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="doc samba web"

DEPEND="dev-python/pyparsing
	>=dev-python/twisted-core-2
	dev-python/twisted-mail
	dev-python/twisted-names
	doc? (
		dev-python/epydoc
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	samba? ( dev-python/pycrypto )
	web? (
		>=dev-python/nevow-0.3
		dev-python/twisted-web
		dev-python/webut
	)"
RDEPEND="${DEPEND}"

DOCS="README TODO ldaptor.schema"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-zope_interface.patch"
	epatch "${FILESDIR}/${P}-usage-exception.patch"
	epatch "${FILESDIR}"/${PN}-prem_test.patch
	# Delete test with additional dependencies.
	if ! use web; then
		rm -f ldaptor/test/test_webui.py
	fi
}

src_compile() {
	distutils_src_compile

	if use doc; then
		cp "${WORKDIR}/ldaptor-pictures/"*.dia.png doc/
		pushd doc > /dev/null
		# skip the slides generation because it doesn't work
		sed -e "/\$(SLIDES:%\.xml=%\/index\.html) /d" -i Makefile
		# replace the docbook.xsl with something that exists
		stylesheet='xsl-stylesheets'
		sed -e "s#stylesheet/xsl/nwalsh#${stylesheet}#" -i Makefile
		emake || die "make failed"
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/ldaptor/test"
	}
	python_execute_function -q delete_tests

	if ! use web; then
		rm -f "${ED}"usr/bin/ldaptor-webui*
		delete_webui() {
			rm -fr "${ED}$(python_get_sitedir)/ldaptor/apps/webui"
		}
		python_execute_function -q delete_webui
	else
		copy_skin-default() {
			cp ldaptor/apps/webui/skin-default.html "${D}$(python_get_sitedir)/ldaptor/apps/webui"
		}
		python_execute_function -q copy_skin-default
	fi

	# Install examples.
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/api doc/ldap-intro doc/examples
		if use web; then
			doins -r doc/examples.webui
		fi
	fi
}
