# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-4.6.1-r1.ebuild,v 1.9 2012/06/06 20:33:49 ssuominen Exp $

EAPI=2
inherit autotools eutils toolchain-funcs versionator

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://alumnit.ca/wiki/?WvStreams"
SRC_URI="http://wvstreams.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="pam doc +ssl +dbus debug"

#Tests fail if openssl is not compiled with -DPURIFY. Gentoo's isn't. FAIL!
RESTRICT="test"

#QA Fail: xplc is compiled as a part of wvstreams.
#It'll take a larger patching effort to get it extracted, since upstream integrated it
#more tightly this time. Probably for the better since upstream xplc seems dead.

RDEPEND="sys-libs/readline
	sys-libs/zlib
	dbus? ( >=sys-apps/dbus-1.2.14 )
	dev-libs/openssl
	pam? ( sys-libs/pam )
	virtual/c++-tr1-functional"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

pkg_setup() {
	if has_version '>=sys-devel/gcc-4.1' && ! has_version '>=dev-libs/boost-1.34.1'
	then
		if ! version_is_at_least 4.1 "$(gcc-fullversion)"
		then
			eerror "This package requires the active gcc to be at least version 4.1"
			eerror "or >=dev-libs/boost-1.34.1 must be installed."
			die "Please activate >=sys-devel/gcc-4.1 with gcc-config."
		fi
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-parallel-make.patch \
		"${FILESDIR}"/${P}-openssl-1.0.0.patch \
		"${FILESDIR}"/${P}-glibc212.patch
	eautoreconf
	cd argp
	eautoreconf
}

src_configure() {
	export CXX="$(tc-getCXX)"

	econf \
		$(use_enable debug) \
		--disable-optimization \
		$(use_with dbus) \
		--with-openssl \
		$(use_with pam) \
		--without-tcl \
		--without-qt \
		--with-zlib \
		--without-valgrind
}

src_compile() {
	emake || die

	if use doc; then
		doxygen || die
	fi
}

src_test() {
	emake test || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README*

	if use doc; then
		#the list of files is too big for dohtml -r Docs/doxy-html/*
		cd Docs/doxy-html
		dohtml -r *
	fi
}
