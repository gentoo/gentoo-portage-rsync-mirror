# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.5.2.ebuild,v 1.1 2013/04/27 22:40:18 radhermit Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/libgcrypt/${P}.tar.bz2
	ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1 MIT"
SLOT="0/11" # subslot = soname major version
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="caps static-libs"

RDEPEND="caps? ( sys-libs/libcap )
	>=dev-libs/libgpg-error-1.8"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.0-uscore.patch
	epatch "${FILESDIR}"/${PN}-multilib-syspath.patch

	epatch_user
	eautoreconf
}

src_configure() {
	# --disable-padlock-support for bug #201917
	# --disable-asm: http://trac.videolan.org/vlc/ticket/620
	# --disable-asm: causes bus-errors on sparc64-solaris
	econf \
		--disable-padlock-support \
		--disable-dependency-tracking \
		--enable-noexecstack \
		--disable-O-flag-munging \
		$(use_enable static-libs static) \
		$(use_with caps capabilities) \
		$([[ ${CHOST} == *86*-darwin* ]] && echo "--disable-asm") \
		$([[ ${CHOST} == sparcv9-*-solaris* ]] && echo "--disable-asm")
}

src_install() {
	default
	prune_libtool_files
}
