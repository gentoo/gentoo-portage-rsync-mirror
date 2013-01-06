# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/colord/colord-0.1.21.ebuild,v 1.11 2012/12/31 18:12:03 ago Exp $

EAPI="4"

inherit autotools bash-completion-r1 eutils user systemd base

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="http://www.freedesktop.org/software/colord/"
SRC_URI="http://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ia64 ~mips ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="doc examples gtk +gusb +introspection scanner +udev vala"

COMMON_DEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.28.0:2
	>=media-libs/lcms-2.2:2
	>=sys-auth/polkit-0.103
	gtk? (
		x11-libs/gdk-pixbuf:2[introspection?]
		x11-libs/gtk+:3[introspection?] )
	gusb? ( >=dev-libs/libgusb-0.1.1 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )
	scanner? ( media-gfx/sane-backends )
	udev? ( virtual/udev[gudev] )
"
RDEPEND="${COMMON_DEPEND}
	media-gfx/shared-color-profiles"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	>=sys-devel/gettext-0.17
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.9
	)
	vala? ( dev-lang/vala:0.14[vapigen] )
"

# FIXME: needs pre-installed dbus service files
RESTRICT="test"

DOCS=(AUTHORS ChangeLog MAINTAINERS NEWS README TODO)

pkg_setup() {
	enewgroup colord
	enewuser colord -1 -1 /var/lib/colord colord
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.1.11-fix-automagic-vala.patch"
	epatch "${FILESDIR}/${PN}-0.1.15-fix-automagic-libgusb.patch"

	eautoreconf
}

src_configure() {
	# Reverse tools require gusb
	econf \
		--disable-examples \
		--disable-static \
		--enable-polkit \
		--disable-volume-search \
		--with-daemon-user=colord \
		--localstatedir="${EPREFIX}"/var \
		$(use_enable doc gtk-doc) \
		$(use_enable gtk) \
		$(use_enable gusb) \
		$(use_enable gusb reverse) \
		$(use_enable introspection) \
		$(use_enable scanner sane) \
		$(use_enable udev gudev) \
		$(use_enable vala) \
		$(systemd_with_unitdir) \
		VAPIGEN=$(type -p vapigen-0.14)
	# parallel make fails in doc/api
	use doc && MAKEOPTS="${MAKEOPTS} -j1"
}

src_install() {
	base_src_install

	newbashcomp client/colormgr-completion.bash colormgr
	rm -vr "${ED}etc/bash_completion.d"

	# Ensure config and profile directories exist and /var/lib/colord/*
	# is writable by colord user
	keepdir /var/lib/color{,d}/icc
	fowners colord:colord /var/lib/colord{,/icc}

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi

	find "${D}" -name "*.la" -delete || die
}
