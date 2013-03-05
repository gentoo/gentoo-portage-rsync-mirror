# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dwb/dwb-9999.ebuild,v 1.5 2013/03/05 09:38:49 radhermit Exp $

EAPI=5

inherit mercurial toolchain-funcs

EHG_REPO_URI="https://bitbucket.org/portix/dwb"

DESCRIPTION="Dynamic web browser based on WebKit and GTK+"
HOMEPAGE="http://portix.bitbucket.org/dwb/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="examples gtk3"

RDEPEND=">=net-libs/libsoup-2.32:2.4
	dev-libs/json-c
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
