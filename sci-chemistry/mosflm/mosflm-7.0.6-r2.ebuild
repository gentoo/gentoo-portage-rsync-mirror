# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mosflm/mosflm-7.0.6-r2.ebuild,v 1.12 2012/10/19 10:03:53 jlec Exp $

EAPI="3"

inherit eutils fortran-2 toolchain-funcs versionator

MY_PV="$(delete_all_version_separators)"
MY_P="${PN}${MY_PV}"

DESCRIPTION="A program for integrating single crystal diffraction data from area detectors"
HOMEPAGE="http://www.mrc-lmb.cam.ac.uk/harry/mosflm/"
SRC_URI="${HOMEPAGE}ver${MY_PV}/build-it-yourself/${MY_P}.tgz"

SLOT="0"
LICENSE="ccp4"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	app-shells/tcsh
	virtual/jpeg
	sci-libs/ccp4-libs
	sys-libs/ncurses
	x11-libs/libxdl_view"
DEPEND="${RDEPEND}"
# Needs older version as current, perhaps we can fix that next release
#	sci-libs/cbflib

S="${WORKDIR}/${MY_P}"

src_prepare() {
# See DEPEND
#	sed -e "s:../cbf/lib/libcbf.a:${EPREFIX}/usr/$(get_libdir)/libcbf.a:g" \
	sed -e "s:../jpg/libjpeg.a:-ljpeg:g" \
		-i ${PN}/Makefile || die

	epatch \
		"${FILESDIR}/${PV}"-Makefile.patch \
		"${FILESDIR}/${PV}"-parallel.patch \
		"${FILESDIR}/${PV}"-impl-dec.patch
	rm test.f || die
}

src_compile() {
	emake \
		MOSHOME="${S}" \
		DPS="${S}" \
		FC=$(tc-getFC) \
		FLINK=$(tc-getFC) \
		CC=$(tc-getCC) \
		AR_FLAGS=vru \
		MOSLIBS='-lccp4f -lccp4c -lxdl_view -lcurses -lXt -lmmdb -lccif -lstdc++' \
		MCFLAGS="-O0 -fno-second-underscore" \
		MOSFLAGS="${FFLAGS} -fno-second-underscore" \
		FFLAGS="${FFLAGS:- -O2}" \
		CFLAGS="${CFLAGS}" \
		MOSCFLAGS="${CFLAGS}" \
		LFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	exeinto /usr/libexec/ccp4/bin/
	doexe bin/ipmosflm || die
	dosym ../libexec/ccp4/bin/ip${PN} /usr/bin/ip${PN}
}
