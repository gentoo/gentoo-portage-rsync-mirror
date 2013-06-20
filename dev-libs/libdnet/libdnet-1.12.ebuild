# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.12.ebuild,v 1.8 2013/06/20 15:46:40 jer Exp $

EAPI=5

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
PYTHON_DEPEND="python? 2"
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )
DISTUTILS_SINGLE_IMPL=true

inherit autotools distutils-r1 eutils

DESCRIPTION="simplified, portable interface to several low-level networking routines"
HOMEPAGE="http://code.google.com/p/libdnet/"
SRC_URI="http://libdnet.googlecode.com/files/${P}.tgz
	ipv6? ( http://fragroute-ipv6.googlecode.com/files/${P}.ipv6-1.patch.gz )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6 python static-libs test"

#DEPEND="test? ( dev-libs/check )"
RESTRICT="test"

DOCS=( README THANKS TODO )

src_prepare() {
	# Useless copy
	rm -r trunk/ || die

	sed -i \
		-e 's/libcheck.a/libcheck.so/g' \
		-e 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' \
		configure.in || die
	sed -i -e 's|-L@libdir@ ||g' dnet-config.in || die
	use ipv6 && epatch "${WORKDIR}/${P}.ipv6-1.patch"
	eautoreconf
	use python && distutils-r1_src_prepare
}

src_configure() {
	econf \
		$(use_with python) \
		$(use_enable static-libs static)
}

src_compile() {
	default
	if use python; then
		cd python
		distutils-r1_src_compile
	fi
}

src_install() {
	default
	if use python; then
		cd python
		distutils-r1_src_compile
	fi
	prune_libtool_files
}
