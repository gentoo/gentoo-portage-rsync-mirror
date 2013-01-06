# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-glib/telepathy-glib-0.18.1.ebuild,v 1.11 2012/12/21 21:12:43 eva Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"

inherit python virtualx

DESCRIPTION="GLib bindings for the Telepathy D-Bus protocol."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug +introspection +vala"

RDEPEND=">=dev-libs/glib-2.30.0:2
	>=dev-libs/dbus-glib-0.90
	introspection? ( >=dev-libs/gobject-introspection-1.30 )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	virtual/pkgconfig
	vala? (
		>=dev-lang/vala-0.14.0:0.14[vapigen]
		>=dev-libs/gobject-introspection-1.30 )"

src_prepare() {
	python_convert_shebangs -r 2 examples tests tools
	default
}

src_configure() {
	local myconf

	if use vala; then
		myconf="--enable-introspection
			VALAC=$(type -p valac-0.14)
			VAPIGEN=$(type -p vapigen-0.14)"
	fi

	econf --disable-static \
		--disable-installed-tests \
		PYTHON=$(PYTHON -2 -a) \
		$(use_enable debug backtrace) \
		$(use_enable debug debug-cache) \
		$(use_enable introspection) \
		$(use_enable vala vala-bindings) \
		${myconf}
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	# Needs dbus for tests (auto-launched)
	Xemake -j1 check
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
