# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nodejs/nodejs-0.11.2.ebuild,v 1.1 2013/05/21 05:23:40 patrick Exp $

EAPI=5

# has known failures. sigh.
RESTRICT="test"

PYTHON_COMPAT=( python2_{6,7} )

inherit python-any-r1 pax-utils

DESCRIPTION="Evented IO for V8 Javascript"
HOMEPAGE="http://nodejs.org/"
SRC_URI="http://nodejs.org/dist/v${PV}/node-v${PV}.tar.gz"

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/node-v${PV}

src_prepare() {
	# fix compilation on Darwin
	# http://code.google.com/p/gyp/issues/detail?id=260
	sed -i -e "/append('-arch/d" tools/gyp/pylib/gyp/xcode_emulation.py || die

	# make sure we use python2.* while using gyp
	sed -i -e  "s/python/python2/" deps/npm/node_modules/node-gyp/gyp/gyp || die

	# less verbose install output (stating the same as portage, basically)
	sed -i -e "/print/d" tools/install.py || die
}

src_configure() {
	# Use target arch detection logic, see v8-3.18 ebuilds
	case ${CHOST} in
		i?86-*)
			myarch="ia32"
			myconf+=" -Dv8_target_arch=ia32" ;;
		x86_64-*)
			if [[ $ABI = x86 ]] ; then
				myarch="ia32"
			else
				myarch="x64"
			fi ;;
		arm*-*)
			myarch="arm"
			;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac

	"${PYTHON}" configure --prefix="${EPREFIX}"/usr \
		--openssl-use-sys --shared-zlib --without-dtrace || die
}

src_compile() {
	emake out/Makefile
	emake -C out "mksnapshot.${myarch}"
	pax-mark m "out/Release/mksnapshot.${myarch}"
	emake
}

src_install() {
	"${PYTHON}" tools/install.py install "${D}" /usr

	dohtml -r "${ED}"/usr/lib/node_modules/npm/html/*
	rm -rf "${ED}"/usr/lib/node_modules/npm/doc "${ED}"/usr/lib/node_modules/npm/html
	rm -rf "${ED}"/usr/lib/dtrace

	pax-mark -m "${ED}"/usr/bin/node
}

src_test() {
	"${PYTHON}" tools/test.py --mode=release simple message || die
}
