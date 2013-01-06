# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/newton/newton-2.00.ebuild,v 1.3 2010/09/17 11:01:42 scarabeus Exp $

inherit eutils multilib

DESCRIPTION="an integrated solution for real time simulation of physics environments"
HOMEPAGE="http://www.physicsengine.com/"
SRC_URI="amd64? (
		http://www.newtondynamics.com/downloads/${PN}Linux-64-${PV}.tar.gz
	)
	x86? (
		http://www.newtondynamics.com/downloads/${PN}Linux-32-${PV}.tar.gz
	)"

LICENSE="newton"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
QA_TEXTRELS="usr/$(get_libdir)/libNewton.so.2.0.0"

DEPEND="doc? (
		virtual/opengl
		media-libs/freeglut
	)"

S=${WORKDIR}/newtonSDK

src_install() {
	dolib.a sdk/libNewton.a || die "dolib.a failed"
	mv sdk/libNewton.so sdk/libNewton.so.2.0.0 || die
	dolib sdk/libNewton.so.2.0.0 || die
	dosym libNewton.so.2.0.0 /usr/$(get_libdir)/libNewton.so.2
	dosym libNewton.so.2.0.0 /usr/$(get_libdir)/libNewton.so
	insinto /usr/include
	doins sdk/Newton.h || die "doins failed"

	dodoc doc/*
}
