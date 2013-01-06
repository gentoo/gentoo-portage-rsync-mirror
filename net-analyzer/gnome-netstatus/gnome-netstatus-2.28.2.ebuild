# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-netstatus/gnome-netstatus-2.28.2.ebuild,v 1.10 2012/05/04 06:08:10 jdhore Exp $

EAPI="3"

inherit eutils gnome2

DESCRIPTION="Network interface information applet"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.20:2
	dev-libs/glib:2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	gnome-base/gconf:2"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	app-text/scrollkeeper
	app-text/gnome-doc-utils"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"

pkg_setup() {
	if ! use debug; then
		G2CONF="${G2CONF} --enable-debug=minimum"
	fi
	G2CONF="${G2CONF}
		--disable-deprecations
		--disable-scrollkeeper
		--disable-schemas-install
		--disable-maintainer-mode"
}

src_prepare() {
	gnome2_src_prepare

	# Fix interface listing on all (known) arches; bug #183969
	epatch "${FILESDIR}"/${PN}-2.12.1-fix-iflist.patch
}
