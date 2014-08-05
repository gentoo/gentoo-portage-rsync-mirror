# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/fio/fio-2.1.5.ebuild,v 1.2 2014/08/05 01:16:05 robbat2 Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )
inherit eutils flag-o-matic python-r1 toolchain-funcs

MY_PV="${PV/_rc/-rc}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Jens Axboe's Flexible IO tester"
HOMEPAGE="http://brick.kernel.dk/snaps/"
SRC_URI="http://brick.kernel.dk/snaps/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="gtk"

DEPEND="dev-libs/libaio
	gtk? ( x11-libs/gtk+:2 )"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	chmod g-w "${T}"
	sed -i '/^DEBUGFLAGS/s, -D_FORTIFY_SOURCE=2,,g' Makefile || die
	epatch_user
}

src_configure() {
	# not a real configure script
	./configure \
		--extra-cflags="${CFLAGS}" --cc="$(tc-getCC)" \
		$(use gtk && echo "--enable-gfio") || die 'configure failed'
}

src_compile() {
	append-flags -W
	emake V=1 OPTFLAGS=
}

src_install() {
	emake install DESTDIR="${D}" prefix="/usr" mandir="/usr/share/man"
	python_replicate_script "${ED}/usr/bin/fio2gnuplot"
	dodoc README REPORTING-BUGS HOWTO
	docinto examples
	dodoc examples/*
	doman fio.1
}
