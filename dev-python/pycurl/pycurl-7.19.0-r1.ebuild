# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycurl/pycurl-7.19.0-r1.ebuild,v 1.9 2012/09/29 18:44:44 armin76 Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
# The selftests fail with pypy, and urlgrabber segfaults for me.
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"

inherit distutils eutils

DESCRIPTION="python binding for curl/libcurl"
HOMEPAGE="http://pycurl.sourceforge.net/ http://pypi.python.org/pypi/pycurl"
SRC_URI="http://pycurl.sourceforge.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="curl_ssl_gnutls curl_ssl_nss +curl_ssl_openssl examples ssl"

# Depend on a curl with curl_ssl_* USE flags.
# libcurl must not be using an ssl backend we do not support.
# If the libcurl ssl backend changes pycurl should be recompiled.
# If curl uses gnutls, depend on at least gnutls 2.11.0 so that pycurl
# does not need to initialize gcrypt threading and we do not need to
# explicitly link to libgcrypt.
DEPEND=">=net-misc/curl-7.25.0-r1[ssl=]
	ssl? (
		net-misc/curl[curl_ssl_gnutls=,curl_ssl_nss=,curl_ssl_openssl=,-curl_ssl_axtls,-curl_ssl_cyassl,-curl_ssl_polarssl]
		curl_ssl_gnutls? ( >=net-libs/gnutls-2.11.0 )
	)"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="curl"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-linking-v2.patch"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" tests/test_internals.py -q
	}
	python_execute_function testing
}

src_install() {
	sed -e "/data_files=/d" -i setup.py || die "sed in setup.py failed"

	distutils_src_install

	dohtml -r doc/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples tests
	fi
}
