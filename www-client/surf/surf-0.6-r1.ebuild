# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/surf/surf-0.6-r1.ebuild,v 1.3 2013/10/04 14:21:09 jer Exp $

EAPI=5
inherit eutils savedconfig toolchain-funcs

DESCRIPTION="a simple web browser based on WebKit/GTK+"
HOMEPAGE="http://surf.suckless.org/"
SRC_URI="http://dl.suckless.org/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	dev-libs/glib
	net-libs/libsoup
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-libs/libX11
"
DEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="
	${COMMON_DEPEND}
	!sci-chemistry/surf
	x11-apps/xprop
	x11-misc/dmenu
"

pkg_setup() {
	if ! use savedconfig; then
		elog "The default config.h assumes you have"
		elog " net-misc/curl"
		elog " x11-terms/st"
		elog "installed to support the download function."
		elog "Without those, downloads will fail (gracefully)."
		elog "You can fix this by:"
		elog " 1) Installing these packages, or"
		elog " 2) Setting USE=savedconfig and changing config.h accordingly."
	fi
}

src_prepare() {
	epatch_user
	epatch "${FILESDIR}"/${P}-gentoo.patch
	restore_config config.h
	tc-export CC PKG_CONFIG
}

src_install() {
	emake DESTDIR="${D}" install
	save_config config.h
}

pkg_postinst() {
	ewarn "Please correct the permissions of your \$HOME/.surf/ directory"
	ewarn "and its contents to no longer be world readable (see bug #404983)"
}
