# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-3.17.15.3.ebuild,v 1.3 2013/04/09 17:31:52 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils multilib multiprocessing pax-utils python-any-r1 toolchain-funcs versionator

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
SRC_URI="https://commondatastorage.googleapis.com/chromium-browser-official/${P}.tar.bz2"
LICENSE="BSD"

soname_version="${PV}"
SLOT="0/${soname_version}"
KEYWORDS="~amd64 ~arm ~x86 ~x86-fbsd ~x64-macos ~x86-macos"
IUSE="readline"

RDEPEND="readline? ( sys-libs/readline:0 )"
DEPEND="${PYTHON_DEPS}
	${RDEPEND}"

src_configure() {
	tc-export AR CC CXX RANLIB
	export LINK=${CXX}

	local hardfp=off

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*) myarch=ia32 ;;
		x86_64-*)
			if [[ $ABI = x86 ]] ; then
				myarch=ia32
			else
				myarch=x64
			fi ;;
		arm*-hardfloat-*)
			hardfp=on
			myarch=arm ;;
		arm*-*) myarch=arm ;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac
	mytarget=${myarch}.release

	if use readline; then
		console=readline
	else
		console=dumb
	fi

	# Generate the real Makefile.
	emake V=1 \
		library=shared \
		werror=no \
		soname_version=${soname_version} \
		snapshot=on \
		hardfp=${hardfp} \
		console=${console} \
		out/Makefile.${myarch}
}

src_compile() {
	local makeargs=(
		-C out
		-f Makefile.${myarch}
		V=1
		BUILDTYPE=Release
		builddir="${S}/out/${mytarget}"
	)

	# Build mksnapshot so we can pax-mark it.
	emake "${makeargs[@]}" mksnapshot
	pax-mark m out/${mytarget}/mksnapshot

	# Build everything else.
	emake "${makeargs[@]}"
	pax-mark m out/${mytarget}/{cctest,d8}
}

src_test() {
	tools/test-wrapper-gypbuild.py \
		-j$(makeopts_jobs) \
		--arch-and-mode=${mytarget} \
		--no-presubmit \
		--progress=dots || die
}

src_install() {
	insinto /usr
	doins -r include

	if [[ ${CHOST} == *-darwin* ]] ; then
		# buildsystem is too horrific to get this built correctly
		mkdir -p out/${mytarget}/lib.target || die
		mv out/${mytarget}/libv8.so.${soname_version} \
			out/${mytarget}/lib.target/libv8$(get_libname ${soname_version}) || die
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libv8$(get_libname) \
			out/${mytarget}/lib.target/libv8$(get_libname ${soname_version}) \
			|| die
		install_name_tool \
			-change \
			/usr/local/lib/libv8.so.${soname_version} \
			"${EPREFIX}"/usr/$(get_libdir)/libv8$(get_libname) \
			out/${mytarget}/d8 || die
	fi

	dobin out/${mytarget}/d8
	pax-mark m "${ED}usr/bin/d8"

	dolib out/${mytarget}/lib.target/libv8$(get_libname ${soname_version})
	dosym libv8$(get_libname ${soname_version}) /usr/$(get_libdir)/libv8$(get_libname)

	dodoc AUTHORS ChangeLog || die
}
