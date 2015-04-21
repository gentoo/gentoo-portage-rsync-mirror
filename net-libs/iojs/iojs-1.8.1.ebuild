# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/iojs/iojs-1.7.1.ebuild,v 1.1 2015/04/16 09:05:28 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

inherit flag-o-matic pax-utils python-single-r1 toolchain-funcs

DESCRIPTION="An npm compatible platform originally based on node.js"
HOMEPAGE="http://iojs.org/"
SRC_URI="http://iojs.org/dist/${MY_PV}/${MY_P}.tar.xz"

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"
IUSE="bundled-libs debug icu +npm snapshot +ssl"

RDEPEND="icu? ( dev-libs/icu )
	${PYTHON_DEPS}
	!bundled-libs? (
		>=net-libs/http-parser-2.3
		>=dev-libs/libuv-1.4.2
		>=dev-libs/openssl-1.0.1m[-bindist]
	)"
DEPEND="${RDEPEND}
	!!net-libs/nodejs"
S="${WORKDIR}/${MY_P}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_pretend() {
	if ! test-flag-CXX -std=c++11 ; then
		die "Your compiler doesn't support C++11. Use GCC 4.8, Clang 3.3 or newer."
	fi
}

src_prepare() {
	tc-export CC CXX PKG_CONFIG
	export V=1 # Verbose build
	export BUILDTYPE=Release

	# fix compilation on Darwin
	# http://code.google.com/p/gyp/issues/detail?id=260
	sed -i -e "/append('-arch/d" tools/gyp/pylib/gyp/xcode_emulation.py || die

	# make sure we use python2.* while using gyp
	sed -i -e "s/python/${EPYTHON}/" deps/npm/node_modules/node-gyp/gyp/gyp || die
	sed -i -e "s/|| 'python'/|| '${EPYTHON}'/" deps/npm/node_modules/node-gyp/lib/configure.js || die

	# less verbose install output (stating the same as portage, basically)
	sed -i -e "/print/d" tools/install.py || die

	# proper libdir, hat tip @ryanpcmcquen https://github.com/iojs/io.js/issues/504
	local LIBDIR=$(get_libdir)
	sed -i -e "s|lib/|${LIBDIR}/|g" tools/install.py || die
	sed -i -e "s/'lib'/'${LIBDIR}'/" lib/module.js || die
	sed -i -e "s|\"lib\"|\"${LIBDIR}\"|" deps/npm/lib/npm.js || die

	epatch "${FILESDIR}"/${P}-pkgconfig.patch

	# Avoid a test that I've only been able to reproduce from emerge. It doesnt
	# seem sandbox related either (invoking it from a sandbox works fine).
	# The issue is that no stdin handle is openened when asked for one.
	# It doesn't really belong upstream , so it'll just be removed until someone
	# with more gentoo-knowledge than me (jbergstroem) figures it out.
	rm test/parallel/test-stdout-close-unref.js || die

	# fix upstream bug regarding shared build logic (my own fault, jbergstroem)
	sed -i -e "s/== True/== 'true'/g" configure || die

	# debug builds. change install path, remove optimisations and override buildtype
	if use debug; then
		sed -i -e "s|out/Release/|out/Debug/|g" tools/install.py
		BUILDTYPE=Debug
	fi
}

src_configure() {
	local myconf=()
	local myarch=""
	use bundled-libs || myconf+=( --shared-openssl --shared-libuv --shared-http-parser --shared-zlib )
	use npm || myconf+=( --without-npm )
	use icu && myconf+=( --with-intl=system-icu )
	use snapshot && myconf+=( --with-snapshot )
	use ssl || myconf+=( --without-ssl )
	use debug && myconf+=( --debug )

	case ${ABI} in
		x86) myarch="ia32";;
		amd64) myarch="x64";;
		x32) myarch="x32";;
		arm) myarch="arm";;
		arm64) myarch="arm64";;
		*) die "Unrecognized ARCH ${ARCH}";;
	esac

	"${PYTHON}" configure \
		--prefix="${EPREFIX}"/usr \
		--dest-cpu=${myarch} \
		--without-dtrace \
		"${myconf[@]}" || die
}

src_compile() {
	emake -C out mksnapshot
	pax-mark m "out/${BUILDTYPE}/mksnapshot"
	emake -C out
}

src_install() {
	local LIBDIR="${ED}/usr/$(get_libdir)"
	emake install DESTDIR="${ED}"
	use npm && dodoc -r "${LIBDIR}"/node_modules/npm/html
	rm -rf "${LIBDIR}"/node_modules/npm/{doc,html} || die
	find "${LIBDIR}"/node_modules -type f -name "LICENSE" -delete

	pax-mark -m "${ED}"/usr/bin/iojs
}

src_test() {
	out/${BUILDTYPE}/cctest || die
	declare -xl TESTTYPE="${BUILDTYPE}"
	"${PYTHON}" tools/test.py --mode=${TESTTYPE} -J message parallel sequential || die
}
