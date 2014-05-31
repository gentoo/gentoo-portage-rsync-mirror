# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-9999.ebuild,v 1.10 2014/05/31 10:59:56 swegener Exp $

EAPI=5

inherit autotools perl-module git-r3

EGIT_REPO_URI="git://git.irssi.org/irssi"

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ipv6 +perl ssl socks5 +proxy"

RDEPEND="sys-libs/ncurses
	>=dev-libs/glib-2.6.0
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-proxy/dante-1.1.18 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/autoconf-2.58
	dev-lang/perl
	|| (
		www-client/lynx
		www-client/elinks
	)"
RDEPEND="${RDEPEND}
	perl? ( !net-im/silc-client )"

src_prepare() {
	TZ=UTC git log > "${S}"/ChangeLog || die
	sed -i -e /^autoreconf/d autogen.sh || die
	NOCONFIGURE=1 ./autogen.sh || die

	eautoreconf
}

src_configure() {
	econf \
		--with-ncurses="${EPREFIX}"/usr \
		--with-perl-lib=vendor \
		--enable-static \
		$(use_with proxy) \
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

	prune_libtool_files --modules

	dodoc AUTHORS ChangeLog README TODO NEWS
}
