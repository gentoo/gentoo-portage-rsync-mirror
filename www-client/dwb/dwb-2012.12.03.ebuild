# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dwb/dwb-2012.12.03.ebuild,v 1.1 2013/01/02 20:55:55 radhermit Exp $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="Dynamic web browser based on WebKit and GTK+"
HOMEPAGE="http://portix.bitbucket.org/dwb/"
SRC_URI="mirror://bitbucket/portix/dwb/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples gtk3"

RDEPEND=">=net-libs/libsoup-2.32:2.4
	!gtk3? (
		>=net-libs/webkit-gtk-1.8.0:2
		x11-libs/gtk+:2
	)
	gtk3? (
		>=net-libs/webkit-gtk-1.8.0:3
		x11-libs/gtk+:3
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2012.10.28-verbose-build.patch
	sed -i "/^CFLAGS += -\(pipe\|g\|O2\)/d" config.mk || die
}

src_compile() {
	local myconf
	use gtk3 && myconf+=" GTK=3"

	emake CC="$(tc-getCC)" ${myconf}
}

src_install() {
	default

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
