# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypcap/pypcap-1.1-r1.ebuild,v 1.8 2012/04/02 10:21:13 naota Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Simplified object-oriented Python extension module for libpcap"
HOMEPAGE="http://code.google.com/p/pypcap/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	>=dev-python/pyrex-0.9.5.1a"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="CHANGES"

src_prepare() {
	# Work around broken exception handling (bug #318401).
	sed -e "s/raise exc\[0\], exc\[1\], exc\[2\]/raise NotImplementedError/" -i pcap.pyx || die "sed failed"

	epatch "${FILESDIR}/include_path.patch"

	# Check existence of shared library instead of static library.
	sed -e "s/'libpcap.a'/'libpcap.so'/" -i setup.py || die "sed failed"

	distutils_src_prepare
}

src_configure() {
	configuration() {
		# pcap.c was generated with pyrex-0.9.3
		# and <=pyrex-0.9.5.1a is incompatible with python-2.5.
		# So we regenerate it. Bug #180039
		pyrexc pcap.pyx || die "pyrexc failed"
		"$(PYTHON)" setup.py config
	}
	python_execute_function -s configuration
}

src_test() {
	testing() {
		# PYTHONPATH is set correctly in the test itself
		"$(PYTHON)" test.py
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins testsniff.py || die "doins failed"
	fi
}
