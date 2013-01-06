# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/eden/eden-5.3.ebuild,v 1.8 2010/06/23 21:00:32 mr_bones_ Exp $

inherit eutils multilib toolchain-funcs

MY_P="${PN}_V${PV}"
DESCRIPTION="A crystallographic real-space electron-density refinement and optimization program"
HOMEPAGE="http://www.gromacs.org/pipermail/eden-users"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="double-precision"
RDEPEND="=sci-libs/fftw-2*
	sci-libs/gsl"

DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"
SRC="${S}/source"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/makefile-fixes.patch

	sed -i \
		-e "s:^\(FFTW.*=\).*:\1 /usr:g" \
		-e "s:^\(LIB.*=.*\$(FFTW)/\).*:\1$(get_libdir):g" \
		-e "s:^\(BIN.*=\).*:\1 ${D}usr/bin:g" \
		-e "s:^\(CFLAGS.*=\).*:\1 ${CFLAGS}:g" \
		${SRC}/Makefile

	if ! use double-precision; then
		sed -i -e "s:^\(DOUBLESWITCH.*=\).*:\1 OFF:g" ${SRC}/Makefile
		EXE="seden"
	else
		EXE="deden"
	fi
}

src_compile() {
	cd ${SRC}
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	local EDENHOME="/usr/lib/eden"

	cd ${SRC}
	dodir /usr/bin
	make install || die "install failed"

	cd "${S}"
	exeinto ${EDENHOME}/python
	doexe python/*

	insinto ${EDENHOME}/help
	doins help/*

	insinto ${EDENHOME}/tools
	doins tools/*

	dodoc manual/UserManual.pdf

cat << EOF > "${T}"/eden
#!/bin/bash
export EDENHOME="${EDENHOME}"
${EXE} \$*
EOF

	dobin "${T}"/eden

cat << EOF > "${T}"/ieden
#!/bin/bash
export EDENHOME="${EDENHOME}"
\${EDENHOME}/python/eden.py
EOF

	dobin "${T}"/ieden
}
