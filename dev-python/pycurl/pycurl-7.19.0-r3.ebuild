# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycurl/pycurl-7.19.0-r3.ebuild,v 1.7 2013/08/29 19:52:31 ago Exp $

EAPI=5

# The selftests fail with pypy, and urlgrabber segfaults for me.
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="python binding for curl/libcurl"
HOMEPAGE="http://pycurl.sourceforge.net/ http://pypi.python.org/pypi/pycurl"
SRC_URI="http://pycurl.sourceforge.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
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

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${P}-linking-v2.patch"
		"${FILESDIR}/${P}-python3.patch"
	)

	sed -e "/data_files=/d" -i setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" tests/test_internals.py -q || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local HTML_DOCS=( doc/. )

	distutils-r1_python_install_all

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
