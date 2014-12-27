# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-3.1.0013-r3.ebuild,v 1.2 2014/12/27 19:26:45 ago Exp $

EAPI=5

MULTILIB_COMPAT=( abi_x86_{32,64} )
inherit multilib multilib-minimal prefix versionator

MY_PV="$(get_version_component_range 1-2)"
MY_DATE="April2012"

DESCRIPTION="NVIDIA's C graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="
	abi_x86_32? (
		http://developer.download.nvidia.com/cg/Cg_${MY_PV}/Cg-${MY_PV}_${MY_DATE}_x86.tgz
	)
	abi_x86_64? (
		http://developer.download.nvidia.com/cg/Cg_${MY_PV}/Cg-${MY_PV}_${MY_DATE}_x86_64.tgz
	)"

LICENSE="NVIDIA-r1"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples multilib"

REQUIRED_USE="amd64? ( multilib? ( abi_x86_32 ) )"
RESTRICT="strip"

RDEPEND="
	media-libs/freeglut
	amd64? ( abi_x86_32? (
		|| (
			app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
			>=media-libs/freeglut-2.8.1[abi_x86_32(-)]
		)
	) )
	x86? ( virtual/libstdc++:3.3 )"
DEPEND=""

S=${WORKDIR}

DEST=/opt/${PN}

QA_PREBUILT="${DEST}/*"

src_unpack() {
	multilib_src_unpack() {
		mkdir -p "${BUILD_DIR}" || die
		cd "${BUILD_DIR}" || die

		local i
		for i in ${A}; do
			if [[ ${i} == *x86_64* && ${ABI} == amd64 ]]; then
				unpack "${i}"
			elif [[ ${i} != *x86_64* && ${ABI} != amd64 ]]; then
				unpack "${i}"
			fi
		done
	}

	multilib_foreach_abi multilib_src_unpack
}

install_pkgconfig() {
	# One arg: .pc file
	insinto /usr/$(get_libdir)/pkgconfig
	sed \
		-e "s:GENTOO_LIBDIR:$(get_libdir):g" \
		-e "s:DESCRIPTION:${DESCRIPTION}:g" \
		-e "s:VERSION:${PV}:g" \
		-e "s|HOMEPAGE|${HOMEPAGE}|g" \
		-e "s:SUFFIX::g" \
		"${FILESDIR}/${1}.in" > "${T}/${1}" || die
		eprefixify "${T}/${1}"
	doins "${T}/${1}"
}

src_install() {
	local LDPATH=()

	multilib-minimal_src_install
}

multilib_src_install() {
	LDPATH+=( "${EPREFIX}${DEST}/$(get_libdir)" )
	into ${DEST}

	if [[ ${ABI} == amd64 ]]; then
		dolib usr/lib64/*
	else
		dolib usr/lib/*
	fi
	install_pkgconfig nvidia-cg-toolkit.pc
	install_pkgconfig nvidia-cg-toolkit-gl.pc

	insinto ${DEST}/include
	doins -r usr/include/Cg

	if multilib_is_native_abi; then
		dobin usr/bin/{cgc,cgfxcat,cginfo}

		insinto ${DEST}
		dodoc usr/local/Cg/README
		if use doc; then
			dodoc usr/local/Cg/docs/*.{txt,pdf}
			dohtml -r usr/local/Cg/docs/html/*
		fi
		if use examples; then
			insinto /usr/share/${PN}
			doins -r usr/local/Cg/examples
		fi
	fi
}

multilib_src_install_all() {
	local ldpath=${LDPATH[*]}

	sed \
		-e "s|ELDPATH|${ldpath// /:}|g" \
		"${FILESDIR}"/80cgc-opt-2 > "${T}"/80cgc-opt || die
	eprefixify "${T}"/80cgc-opt
	doenvd "${T}"/80cgc-opt
}

pkg_postinst() {
	if [[ ${REPLACING_VERSIONS} < 2.1.0016 ]]; then
		einfo "Starting with ${CATEGORY}/${PN}-2.1.0016, ${PN} is installed in"
		einfo "${DEST}. Packages might have to add something like:"
		einfo "  append-cppflags -I${DEST}/include"
	fi
}
