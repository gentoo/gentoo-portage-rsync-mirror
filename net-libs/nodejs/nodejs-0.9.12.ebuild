# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nodejs/nodejs-0.9.12.ebuild,v 1.1 2013/03/07 04:11:23 patrick Exp $

EAPI=5

# a few tests fail. Should be fixed in 0.10
RESTRICT="test"

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit python-any-r1 pax-utils

DESCRIPTION="Evented IO for V8 Javascript"
HOMEPAGE="http://nodejs.org/"
SRC_URI="http://nodejs.org/dist/v${PV}/node-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"
IUSE="test"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
	virtual/python-json
	test? ( net-misc/curl )"

S=${WORKDIR}/node-v${PV}

src_prepare() {
	# fix compilation on Darwin
	# http://code.google.com/p/gyp/issues/detail?id=260
	sed -i -e "/append('-arch/d" tools/gyp/pylib/gyp/xcode_emulation.py || die

	# make sure we use python2.* while using gyp
	sed -i -e "s/python/python2/" deps/npm/node_modules/node-gyp/gyp/gyp || die

	# less verbose install output (stating the same as portage, basically)
	sed -i -e "/print/d" tools/install.py || die
}

src_configure() {
	"${PYTHON}" configure --prefix="${EPREFIX}"/usr --openssl-use-sys --shared-zlib || die
}

src_compile() {
	emake || die
}

src_install() {
	"${PYTHON}" tools/install.py install "${ED}"

	dohtml -r "${ED}"/usr/lib/node_modules/npm/html/*
	rm -rf "${ED}"/usr/lib/node_modules/npm/doc "${ED}"/usr/lib/node_modules/npm/html
	rm -rf "${ED}"/usr/lib/dtrace

	pax-mark -m "${ED}"/usr/bin/node
}

src_test() {
	"${PYTHON}" tools/test.py --mode=release simple message || die
}
