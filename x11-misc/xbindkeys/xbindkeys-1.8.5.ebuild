# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbindkeys/xbindkeys-1.8.5.ebuild,v 1.1 2011/03/23 16:20:44 jer Exp $

EAPI="2"

inherit eutils

IUSE="guile tk"

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://www.nongnu.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/xbindkeys/xbindkeys.html"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"
SLOT="0"

RDEPEND="x11-libs/libX11
	guile? ( >=dev-scheme/guile-1.8.4[deprecated] )
	tk? ( dev-lang/tk )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_configure() {
	econf \
		$(use_enable tk) \
		$(use_enable guile)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
