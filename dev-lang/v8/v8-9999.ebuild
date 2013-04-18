# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-9999.ebuild,v 1.43 2013/04/18 03:58:18 phajdan.jr Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit chromium eutils multilib multiprocessing pax-utils python-any-r1 \
	subversion toolchain-funcs

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
ESVN_REPO_URI="http://v8.googlecode.com/svn/trunk"
LICENSE="BSD"

SLOT="0"
KEYWORDS=""
IUSE="readline neon"

RDEPEND="readline? ( sys-libs/readline:0 )"
DEPEND="${PYTHON_DEPS}
	${RDEPEND}"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	make dependencies || die
}

src_configure() {
	tc-export AR CC CXX RANLIB
	export LINK=${CXX}

	local myconf=""

	subversion_wc_info
	soname_version="${PV}.${ESVN_WC_REVISION}"

	# Always build v8 as a shared library with proper SONAME.
	myconf+=" -Dcomponent=shared_library -Dsoname_version=${soname_version}"

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*) myconf+=" -Dv8_target_arch=ia32" ;;
		x86_64-*)
			if [[ $ABI = x86 ]] ; then
				myconf+=" -Dv8_target_arch=ia32"
			else
				myconf+=" -Dv8_target_arch=x64"
			fi ;;
		arm*-*)
			myconf+=" -Dv8_target_arch=arm -Darm_fpu="
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
		*) die "Unrecognized CHOST: ${CHOST}"
	esac

	myconf+=" $(gyp_use readline console readline dumb)"

	# Make sure that -Werror doesn't get added to CFLAGS by the build system.
	# Depending on GCC version the warnings are different and we don't
	# want the build to fail because of that.
	myconf+=" -Dwerror="

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
	emake "${makeargs[@]}" mksnapshot
	pax-mark m out/Release/mksnapshot

	# Build everything else.
	emake "${makeargs[@]}"
	pax-mark m out/Release/{cctest,d8}
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

	dodoc AUTHORS ChangeLog || die
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
