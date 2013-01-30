# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/deltup/deltup-0.4.5.ebuild,v 1.1 2013/01/30 06:04:16 patrick Exp $

EAPI=5

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Delta-Update - patch system for updating source-archives."
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="http://deltup.org/e107_files/downloads//${P}.tar.gz
		http://www.bzip.org/1.0.2/bzip2-1.0.2.tar.gz
		http://www.bzip.org/1.0.3/bzip2-1.0.3.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/openssl
	sys-libs/zlib
	>=app-arch/bzip2-1.0.0"
RDEPEND="${DEPEND}
	|| ( dev-util/bdelta =dev-util/xdelta-1* )
	>=app-arch/bzip2-1.0.4"

src_prepare () {
	cd "${WORKDIR}"/bzip2-1.0.2
	epatch "${FILESDIR}"/bzip2-1.0.2-makefile-CFLAGS.patch
	cd "${WORKDIR}"/bzip2-1.0.3
	epatch "${FILESDIR}"/bzip2-1.0.3-makefile-CFLAGS.patch
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.4.4-gcc47.patch
	epatch "${FILESDIR}"/${PN}-0.4.4-zlib-1.2.5.2.patch
}

src_compile () {
	emake CXX=$(tc-getCXX) || die "emake getdelta failed"

	cd "${WORKDIR}"/bzip2-1.0.2
	local makeopts="
		CC=$(tc-getCC)
		AR=$(tc-getAR)
		RANLIB=$(tc-getRANLIB)"
	append-flags -static
	emake ${makeopts} bzip2 || die "emake bzip2 failed"
	mv bzip2 bzip2_1.0.2

	cd "${WORKDIR}"/bzip2-1.0.3
	append-flags -static
	emake ${makeopts} bzip2 || die "emake bzip2 failed"
	mv bzip2 bzip2_1.0.3
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog
	doman deltup.1
	dobin "${WORKDIR}"/bzip2-1.0.2/bzip2_1.0.2
	dobin "${WORKDIR}"/bzip2-1.0.3/bzip2_1.0.3
}
