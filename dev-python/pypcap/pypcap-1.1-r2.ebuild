# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypcap/pypcap-1.1-r2.ebuild,v 1.1 2014/08/11 11:17:26 jer Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=true
inherit distutils-r1 eutils

DESCRIPTION="Simplified object-oriented Python extension module for libpcap"
HOMEPAGE="http://code.google.com/p/pypcap/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

RDEPEND="net-libs/libpcap"
DEPEND="
	${RDEPEND}
	>=dev-python/pyrex-0.9.5.1a
"

DOCS=( CHANGES README testsniff.py )

src_prepare() {
	# Work around broken exception handling (bug #318401).
	sed -i \
		-e "s|raise exc\[0\], exc\[1\], exc\[2\]|raise NotImplementedError|" \
		pcap.pyx || die

	epatch "${FILESDIR}/include_path.patch"

	# Check existence of shared library instead of static library.
	sed -i -e "s/'libpcap.a'/'libpcap.so'/" setup.py || die

	# Fails to find out of source built module
	sed -i -e '/^sys.path.insert/s|^|#|' test.py || die

	distutils-r1_src_prepare
}

src_configure() {
	# pcap.c was generated with pyrex-0.9.3
	# and <=pyrex-0.9.5.1a is incompatible with python-2.5.
	# So we regenerate it. Bug #180039
	pyrexc pcap.pyx || die
	"${EPYTHON}" setup.py config || die
}

python_test() {
	PYTHONPATH="${BUILD_DIR}/lib:${PYTHONPATH}" "${EPYTHON}" test.py || die
}
