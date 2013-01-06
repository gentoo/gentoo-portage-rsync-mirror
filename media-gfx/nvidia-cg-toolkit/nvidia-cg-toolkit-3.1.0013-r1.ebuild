# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-3.1.0013-r1.ebuild,v 1.2 2012/11/16 09:57:25 jlec Exp $

EAPI=5

inherit multilib prefix versionator

MY_PV="$(get_version_component_range 1-2)"
MY_DATE="April2012"

DESCRIPTION="NVIDIA's C graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
X86_URI="http://developer.download.nvidia.com/cg/Cg_${MY_PV}/Cg-${MY_PV}_${MY_DATE}_x86.tgz"
SRC_URI="
	amd64? (
		http://developer.download.nvidia.com/cg/Cg_${MY_PV}/Cg-${MY_PV}_${MY_DATE}_x86_64.tgz
		multilib? ( ${X86_URI} )
		)
	x86? ( ${X86_URI} )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples multilib"

RESTRICT="strip"

RDEPEND="
	media-libs/freeglut
	multilib? ( amd64? ( app-emulation/emul-linux-x86-xlibs ) )
	x86? ( virtual/libstdc++:3.3 )"
DEPEND=""

S=${WORKDIR}

DEST=/opt/${PN}

QA_PREBUILT="${DEST}/*"

src_unpack() {
	local i
	if use multilib && use amd64; then
		mkdir {32,64}bit || die
		for i in $A; do
			if [[ "$i" =~ .*x86_64.* ]]; then
				pushd 64bit > /dev/null
				unpack "$i"
				popd > /dev/null
			else
				pushd 32bit > /dev/null
				unpack "$i"
				popd > /dev/null
			fi
		done
	else
		default
	fi
}

install_pkgconfig() {
	# Two args: .pc file + abi
	local suffix
	use amd64 && use multilib && [[ $2 == x86 ]] && suffix="-32"
	insinto /usr/$(get_libdir)/pkgconfig
	sed \
		-e "s:GENTOO_LIBDIR:$(ABI=$2 get_libdir):g" \
		-e "s:DESCRIPTION:${DESCRIPTION}:g" \
		-e "s:VERSION:${PV}:g" \
		-e "s|HOMEPAGE|${HOMEPAGE}|g" \
		-e "s:SUFFIX:${suffix}:g" \
		"${FILESDIR}/${1}.in" > "${T}/${1/.pc/${suffix}.pc}" || die
		eprefixify "${T}/${1/.pc/${suffix}.pc}"
	doins "${T}/${1/.pc/${suffix}.pc}"
}

src_install() {
	local ldpath
	into ${DEST}
	if use multilib && use amd64; then
		cd 64bit
	fi

	dobin usr/bin/{cgc,cgfxcat,cginfo}

	if use x86; then
		dolib usr/lib/*
		ldpath="${EPREFIX}${DEST}/$(get_libdir)"
		install_pkgconfig nvidia-cg-toolkit.pc x86
		install_pkgconfig nvidia-cg-toolkit-gl.pc x86
	elif use amd64; then
		dolib usr/lib64/*
		ldpath="${EPREFIX}${DEST}/$(get_libdir)"
		install_pkgconfig nvidia-cg-toolkit.pc amd64
		install_pkgconfig nvidia-cg-toolkit-gl.pc amd64
		if use multilib; then
			ldpath+=":${EPREFIX}${DEST}/lib32"
			pushd ../32bit > /dev/null
			ABI="x86" dolib usr/lib/*
			popd > /dev/null
			install_pkgconfig nvidia-cg-toolkit.pc x86
			install_pkgconfig nvidia-cg-toolkit-gl.pc x86
		fi
	fi

	sed \
		-e "s|ELDPATH|${ldpath}|g" \
		"${FILESDIR}"/80cgc-opt-3 > "${T}"/80cgc-opt || die
	eprefixify "${T}"/80cgc-opt
	doenvd "${T}"/80cgc-opt

	insinto ${DEST}/include
	doins -r usr/include/Cg

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
	find usr/local/Cg/{docs,examples,README} -delete
}

pkg_postinst() {
	if [[ ${REPLACING_VERSIONS} < 2.1.0016 ]]; then
		einfo "Starting with ${CATEGORY}/${PN}-2.1.0016, ${PN} is installed in"
		einfo "${DEST}. Packages might have to add something like:"
		einfo "  append-cppflags -I${DEST}/include"
	fi
}
