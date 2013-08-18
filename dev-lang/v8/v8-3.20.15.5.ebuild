# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-3.20.15.5.ebuild,v 1.2 2013/08/18 03:12:49 steev Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit chromium eutils multilib multiprocessing pax-utils python-any-r1 \
	toolchain-funcs versionator

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
SRC_URI="https://commondatastorage.googleapis.com/chromium-browser-official/${P}.tar.bz2"
LICENSE="BSD"

soname_version="${PV}"
SLOT="0/${soname_version}"
KEYWORDS="~amd64 ~arm ~x86 ~x86-fbsd ~x64-macos ~x86-macos"
IUSE="icu neon readline"

RDEPEND="icu? ( dev-libs/icu:= )
	readline? ( sys-libs/readline:0 )"
DEPEND="${PYTHON_DEPS}
	${RDEPEND}"

src_prepare() {
	# Make sure no bundled libraries are used.
	find third_party -type f \! -iname '*.gyp*' -delete || die
}

src_configure() {
	tc-export AR CC CXX RANLIB
	export LINK=${CXX}

	local myconf=""

	# Always build v8 as a shared library with proper SONAME.
	myconf+=" -Dcomponent=shared_library -Dsoname_version=${soname_version}"

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*)
			myarch="ia32"
			myconf+=" -Dv8_target_arch=ia32" ;;
		x86_64-*)
			if [[ $ABI = x86 ]] ; then
				myarch="ia32"
				myconf+=" -Dv8_target_arch=ia32"
			else
				myarch="x64"
				myconf+=" -Dv8_target_arch=x64"
			fi ;;
		arm*-*)
			myarch="arm"
			myconf+=" -Dv8_target_arch=arm -Darm_fpu=default"
			if [[ ${CHOST} == *-hardfloat-* ]] ; then
				myconf+=" -Dv8_use_arm_eabi_hardfloat=true"
			else
				myconf+=" -Dv8_use_arm_eabi_hardfloat=false"
			fi
			if [[ ${CHOST} == armv7*-* ]] ; then
				myconf+=" -Darmv7=1"
			else
				myconf+=" -Darmv7=0"
			fi
			myconf+=" $(gyp_use neon arm_neon)" ;;
		mips*)
			if [[ ${CHOST} == mips*el* ]] ; then
				myarch="mipsel"
				myconf+=" -Dv8_target_arch=mipsel"
			else
				die "big-endian MIPS is not yet supported"
			fi
			if [[ ${CHOST} == *softfloat* ]] ; then
				myconf+=" -Dv8_use_mips_abi_hardfloat=false"
			else
				myconf+=" -Dv8_use_mips_abi_hardfloat=true"
			fi
			if [[ ${CHOST} == *loongson* ]] ; then
				myconf+=" -Dmips_arch_variant=loongson"
			elif [[ ${CHOST} == mips*64* ]] ; then
				die "generic MIPS 64bit is not yet supported"
			elif [[ ${CHOST} == mips*r2* ]] ; then
				myconf+=" -Dmips_arch_variant=mips32r2"
			else
				myconf+=" -Dmips_arch_variant=mips32"
			fi
			;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac

	myconf+="
		$(gyp_use icu v8_enable_i18n_support)
		$(gyp_use readline console readline dumb)"

	myconf+="
		-Duse_system_icu=1"

	# Make sure that -Werror doesn't get added to CFLAGS by the build system.
	# Depending on GCC version the warnings are different and we don't
	# want the build to fail because of that.
	myconf+=" -Dwerror="

	# gyp does this only for linux, but we always want to use "out" dir, or
	# all else below fails due to not finding "out" dir
	myconf+=" --generator-output=out"
	# gyp defaults to whatever makes the most sense on the platform at hand,
	# but we want to build using Makefiles, so force that
	myconf+=" -f make"

	EGYP_CHROMIUM_COMMAND=build/gyp_v8 egyp_chromium ${myconf} || die
}

src_compile() {
	local makeargs=(
		-C out
		builddir="${S}/out/Release"
		V=1
		BUILDTYPE=Release
	)

	# Build mksnapshot so we can pax-mark it.
	emake "${makeargs[@]}" mksnapshot.${myarch}
	pax-mark m out/Release/mksnapshot.${myarch}

	# Build everything else.
	emake "${makeargs[@]}"
	pax-mark m out/Release/{cctest,d8,preparser}
}

src_test() {
	LD_LIBRARY_PATH=out/Release/lib.target tools/run-tests.py \
		-j$(makeopts_jobs) \
		--no-presubmit \
		--outdir=out \
		--buildbot \
		--arch=native \
		--mode=Release \
		--progress=dots || die
}

src_install() {
	insinto /usr
	doins -r include

	if [[ ${CHOST} == *-darwin* ]] ; then
		# buildsystem is too horrific to get this built correctly
		mkdir -p out/Release/lib.target || die
		mv out/Release/libv8.so.${soname_version} \
			out/Release/lib.target/libv8$(get_libname ${soname_version}) || die
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libv8$(get_libname) \
			out/Release/lib.target/libv8$(get_libname ${soname_version}) \
			|| die
		install_name_tool \
			-change \
			/usr/local/lib/libv8.so.${soname_version} \
			"${EPREFIX}"/usr/$(get_libdir)/libv8$(get_libname) \
			out/Release/d8 || die
	fi

	dobin out/Release/d8
	pax-mark m "${ED}usr/bin/d8"

	dolib out/Release/lib.target/libv8$(get_libname ${soname_version})
	dosym libv8$(get_libname ${soname_version}) /usr/$(get_libdir)/libv8$(get_libname)

	dodoc AUTHORS ChangeLog
}

# TODO: remove functions below after they are removed from chromium.eclass'
# EXPORT_FUNCTIONS .

pkg_preinst() {
	return
}

pkg_postinst() {
	return
}

pkg_postrm() {
	return
}
