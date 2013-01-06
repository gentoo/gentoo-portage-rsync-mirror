# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/tin/tin-2.0.0.ebuild,v 1.7 2012/06/17 18:40:55 armin76 Exp $

EAPI="4"

inherit eutils toolchain-funcs versionator

DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
HOMEPAGE="http://www.tin.org/"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="cancel-locks debug doc +etiquette evil forgery gpg idn ipv6 mime nls sasl socks5 spell unicode"

RDEPEND="
	dev-libs/libpcre
	dev-libs/uulib
	gpg? ( app-crypt/gnupg )
	idn? ( net-dns/libidn )
	mime? ( net-mail/metamail )
	net-misc/urlview
	nls? ( sys-devel/gettext )
	sasl? ( virtual/gsasl )
	socks5? ( net-proxy/dante )
	sys-libs/ncurses[unicode?]
	unicode? ( dev-libs/icu )
"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	# Do not strip
	sed -i src/Makefile.in -e '388s|-s ||g' || die "sed src/Makefile.in failed"
}

src_configure() {
	if use evil || use cancel-locks; then
		sed -i -e"s/# -DEVIL_INSIDE/-DEVIL_INSIDE/" src/Makefile.in
	fi

	if use forgery
	then
		sed -i -e"s/^CPPFLAGS.*/& -DFORGERY/" src/Makefile.in
	fi

	local screen="ncurses"
	use unicode && screen="ncursesw"

	use etiquette || myconf="${myconf} --disable-etiquette"

	tc-export CC

	econf \
		--with-pcre=/usr \
		--enable-nntp-only \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--with-screen=${screen} \
		--with-nntp-default-server="${TIN_DEFAULT_SERVER:-${NNTPSERVER:-news.gmane.org}}" \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_enable gpg pgp-gpg) \
		$(use_enable nls) \
		$(use_enable cancel-locks) \
		$(use_with mime metamail /usr) \
		$(use_with spell ispell /usr) \
		$(use_with socks5 socks) $(use_with socks5) \
		${myconf}
}

src_compile() {
	emake build
}

src_install() {
	default

	# File collision?
	rm -f "${ED}"/usr/share/man/man5/{mbox,mmdf}.5

	dodoc doc/{CHANGES{,.old},CREDITS,TODO,WHATSNEW}
	use doc && dodoc doc/{*.sample,*.txt}
	insinto /etc/tin
	doins doc/tin.defaults
}
