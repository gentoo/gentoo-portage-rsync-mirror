# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.15-r1.ebuild,v 1.14 2014/11/01 11:45:19 swegener Exp $

EAPI=4

inherit perl-module libtool

# Keep for _rc compability
MY_P="${P/_/-}"

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
SRC_URI="http://irssi.org/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="ipv6 +perl selinux ssl socks5"

CDEPEND="sys-libs/ncurses
	>=dev-libs/glib-2.6.0
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-proxy/dante-1.1.18 )"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-irc )
	perl? ( !net-im/silc-client )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epunt_cxx
	elibtoolize  # for Darwin bundle
}

src_configure() {
	econf \
		--with-proxy \
		--with-ncurses="${EPREFIX}"/usr \
		--with-perl-lib=vendor \
		$(use_with perl) \
		$(use_with socks5 socks) \
		$(use_enable ssl) \
		$(use_enable ipv6)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir="${EPREFIX}"/usr/share/doc/${PF} \
		install

	use perl && fixlocalpod

	dodoc AUTHORS ChangeLog README TODO NEWS
}
