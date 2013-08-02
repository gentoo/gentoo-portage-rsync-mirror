# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-6.01.ebuild,v 1.25 2013/08/02 13:52:45 jer Exp $

EAPI="4"

inherit eutils flag-o-matic python toolchain-funcs

MY_P=${P/_beta/BETA}

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://nmap.org/"
SRC_URI="
	http://nmap.org/dist/${MY_P}.tar.bz2
	http://dev.gentoo.org/~jer/nmap-logo-64.png
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="gtk lua ncat ndiff nmap-update nping ssl"

NMAP_PYTHON_DEPEND="
|| (
	dev-lang/python:2.7[sqlite]
	dev-lang/python:2.6[sqlite]
	dev-lang/python:2.5[sqlite]
)
"
DEPEND="
	dev-libs/apr
	dev-libs/libpcre
	net-libs/libpcap
	gtk? (
		>=x11-libs/gtk+-2.6:2
		>=dev-python/pygtk-2.6
		${NMAP_PYTHON_DEPEND}
	)
	lua? ( >=dev-lang/lua-5.1.4-r1[deprecated] )
	ndiff? ( ${NMAP_PYTHON_DEPEND} )
	nmap-update? ( dev-libs/apr dev-vcs/subversion )
	ssl? ( dev-libs/openssl )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use gtk || use ndiff; then
		python_set_active_version 2
	fi
}

src_unpack() {
	unpack ${MY_P}.tar.bz2
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.75-nolua.patch
	epatch "${FILESDIR}"/${PN}-5.10_beta1-string.patch
	epatch "${FILESDIR}"/${PN}-5.21-python.patch
	epatch "${FILESDIR}"/${PN}-5.51-su-to-zenmap-fix.patch
	sed -i -e 's/-m 755 -s ncat/-m 755 ncat/' ncat/Makefile.in

	# bug #416987
	epatch "${FILESDIR}"/${P}-make.patch

	# Fix desktop files wrt bug #432714
	sed -i \
		-e '/^Encoding/d' \
		-e 's|^Categories=.*|Categories=Network;System;Security;|g' \
		zenmap/install_scripts/unix/zenmap-root.desktop \
		zenmap/install_scripts/unix/zenmap.desktop || die
}

src_configure() {
	# The bundled libdnet is incompatible with the version available in the
	# tree, so we cannot use the system library here.
	econf \
		$(use_with gtk zenmap) \
		$(use_with lua liblua) \
		$(use_with ncat) \
		$(use_with ndiff) \
		$(use_with nmap-update) \
		$(use_with nping) \
		$(use_with ssl openssl) \
		--with-libdnet=included
}

src_compile() {
	emake \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB)
}

src_install() {
	LC_ALL=C emake -j1 \
		DESTDIR="${D}" \
		STRIP=: \
		nmapdatadir="${EPREFIX}"/usr/share/nmap \
		install
	if use nmap-update;then
		LC_ALL=C emake -j1 \
			-C nmap-update \
			DESTDIR="${D}" \
			STRIP=: \
			nmapdatadir="${EPREFIX}"/usr/share/nmap \
			install
	fi

	dodoc CHANGELOG HACKING docs/README docs/*.txt

	use gtk && doicon "${DISTDIR}/nmap-logo-64.png"
}
