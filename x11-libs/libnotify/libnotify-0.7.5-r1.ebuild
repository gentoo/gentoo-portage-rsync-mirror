# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libnotify/libnotify-0.7.5-r1.ebuild,v 1.1 2013/03/19 16:17:27 ssuominen Exp $

EAPI=5
inherit autotools gnome.org

DESCRIPTION="A library for sending desktop notifications"
HOMEPAGE="http://git.gnome.org/browse/libnotify"
SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~ssuominen/introspection-1.34.2.m4.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc +introspection test"

RDEPEND="app-admin/eselect-notify-send
	>=dev-libs/glib-2.26
	x11-libs/gdk-pixbuf:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.14 )
	test? ( x11-libs/gtk+:3 )"
PDEPEND="virtual/notification-daemon"

DOCS=( AUTHORS ChangeLog NEWS )

src_prepare() {
	sed -i -e 's:noinst_PROG:check_PROG:' tests/Makefile.am || die

	if ! use test; then
		sed -i -e '/PKG_CHECK_MODULES(TESTS/d' configure.ac || die
	fi

	if ! has_version dev-libs/gobject-introspection; then
		mv -f "${WORKDIR}"/introspection-1.34.2.m4 m4/introspection.m4 || die
	fi

	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable introspection)
}

src_install() {
	default
	prune_libtool_files

	mv "${ED}"/usr/bin/{,libnotify-}notify-send #379941
}

pkg_postinst() {
	eselect notify-send update ifunset
}

pkg_postrm() {
	eselect notify-send update ifunset
}
