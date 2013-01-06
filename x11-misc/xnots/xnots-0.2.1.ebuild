# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnots/xnots-0.2.1.ebuild,v 1.5 2012/05/05 04:53:46 jdhore Exp $

EAPI="2"

inherit linux-info

DESCRIPTION="A desktop sticky note program for the unix geek"
HOMEPAGE="http://xnots.sourceforge.net"
SRC_URI="mirror://sourceforge/xnots/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="vim-syntax"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXrandr
	x11-libs/pango[X]"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/renderproto
	x11-proto/randrproto"

src_compile() {
	NO_DEBUG=1 emake || die
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr mandir=/usr/share/man install || die
	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins etc/xnots.vim
	fi
}

pkg_postinst() {
	if ! linux_config_exists || ! linux_chkconfig_present INOTIFY; then
		ewarn "Your kernel is compiled without INOTIFY support."
		ewarn "xNots requires INOTIFY support to run."
		ewarn "Please enable CONFIG_INOTIFY in your kernel config."
	fi
}
