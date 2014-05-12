# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/newton/newton-1.53.ebuild,v 1.7 2014/05/12 13:20:15 kensington Exp $

EAPI=2
inherit eutils

DESCRIPTION="an integrated solution for real time simulation of physics environments"
HOMEPAGE="http://newtondynamics.com/"
SRC_URI="http://www.newtondynamics.com/downloads/${PN}Linux-${PV}.tar.gz"

LICENSE="newton"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="doc? (
		virtual/opengl
		media-libs/freeglut
	)"

S=${WORKDIR}/newtonSDK

src_prepare() {
	if use doc; then
		cd samples
		rm -rf gl
		sed -i \
			-e "s:-I ../gl:-I /usr/include/GL:" \
			tutorial_05_UsingJoints/makefile \
			tutorial_09_SimpleVehicle/makefile \
			tutorial_04_IntroductionToMaterials/makefile \
			tutorial_10_CustomJoints/makefile \
			tutorial_01_GettingStarted/makefile \
			tutorial_02_UsingCallbacks/makefile \
			tutorial_08_HeightFieldCollision/makefile \
			tutorial_07_CharaterController/makefile \
			tutorial_06_UtilityFuntionality/makefile \
			tutorial_03_UsingCollisionTree/makefile \
			|| die "failed fixing sample makefiles"
		sed -i \
			-e "/^FLAGS =/s:-g -O0:${CFLAGS}:" \
			makefile \
			|| die "sed makefile failed"
		epatch "${FILESDIR}"/${P}-glut.patch
	fi
}

src_compile() {
	if use doc; then
		cd samples
		emake || die "emake samples failed"
		rm -f */*.elf */*.o
	fi
}

src_install() {
	dolib.a sdk/libNewton.a || die "dolib.a failed"
	insinto /usr/include
	doins sdk/Newton.h || die "doins failed"

	if use doc; then
		insinto /usr/share/${PN}
		doins -r samples/* || die "doins samples failed"

		exeinto /usr/share/${PN}/bin
		doexe samples/bin/tutorial_* || die "doexe failed"
	fi

	dodoc doc/*
}
