# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/surf/surf-9999.ebuild,v 1.1 2013/09/12 15:33:09 jer Exp $

EAPI=5
inherit eutils git-2 savedconfig toolchain-funcs

DESCRIPTION="a simple web browser based on WebKit/GTK+"
HOMEPAGE="http://surf.suckless.org/"
EGIT_REPO_URI="git://git.suckless.org/surf"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-libs/glib
	net-libs/libsoup
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-libs/libX11
"
RDEPEND="
	!sci-chemistry/surf
	x11-apps/xprop
	x11-misc/dmenu
	${DEPEND}
"

pkg_setup() {
	if ! use savedconfig; then
		elog "The default config.h assumes you have"
		elog " net-misc/curl"
		elog " x11-terms/st"
		elog "installed to support the download function."
		elog "Without those, downloads will fail (gracefully)."
		elog "You can fix this by:"
		elog "1) Installing these packages, or"
		elog "2) Setting USE=savedconfig and changing config.h accordingly."
	fi
}

src_prepare() {
	epatch_user
	sed -i \
		-e 's|{|(|g;s|}|)|g' \
		-e 's|\t@|\t|g;s|echo|@&|g' \
		-e 's|^LIBS.*|LIBS = $(GTKLIB) -lgthread-2.0|g' \
		-e 's|^LDFLAGS.*|LDFLAGS += $(LIBS)|g' \
		-e 's|^CC.*|CC ?= gcc|g' \
		-e 's|^CFLAGS.*|CFLAGS += -std=c99 -pedantic -Wall $(INCS) $(CPPFLAGS)|g' \
		config.mk Makefile || die
	restore_config config.h
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	save_config config.h
}
