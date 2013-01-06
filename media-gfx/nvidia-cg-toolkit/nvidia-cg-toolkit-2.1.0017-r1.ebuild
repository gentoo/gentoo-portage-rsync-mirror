# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-2.1.0017-r1.ebuild,v 1.3 2013/01/01 16:24:42 hasufell Exp $

EAPI=5

inherit multilib prefix versionator

MY_PV="$(get_version_component_range 1-2)"
MY_DATE="February2009"

DESCRIPTION="NVIDIA's C graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="
	x86? ( http://developer.download.nvidia.com/cg/Cg_${MY_PV}/${PV}/Cg-${MY_PV}_${MY_DATE}_x86.tgz )
	amd64? ( http://developer.download.nvidia.com/cg/Cg_${MY_PV}/${PV}/Cg-${MY_PV}_${MY_DATE}_x86_64.tgz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RESTRICT="strip"

RDEPEND="media-libs/freeglut"
DEPEND=""

S=${WORKDIR}

DEST=/opt/${PN}

QA_PREBUILT="${DEST}/*"

src_install() {
	local ldpath=${DEST}/lib

	into ${DEST}
	dobin usr/bin/cgc
	dosym ${DEST}/bin/cgc /opt/bin/cgc

	exeinto ${DEST}/lib
	if use x86 ; then
		doexe usr/lib/*
	elif use amd64 ; then
		doexe usr/lib64/*
	fi

	sed \
		-e "s|ELDPATH|${ldpath}|g" \
		"${FILESDIR}"/80cgc-opt-2 > "${T}"/80cgc-opt || die
	eprefixify "${T}"/80cgc-opt
	doenvd "${T}"/80cgc-opt

	insinto ${DEST}/include
	doins -r usr/include/Cg

	doman usr/share/man/man3/*

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
