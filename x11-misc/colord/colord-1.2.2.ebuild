# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/colord/colord-1.2.2.ebuild,v 1.1 2014/09/07 14:05:55 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.18"

inherit bash-completion-r1 check-reqs eutils gnome2 user systemd udev vala

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="http://www.freedesktop.org/software/colord/"
SRC_URI="http://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0/2" # subslot = libcolord soname version
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

# We prefer policykit enabled by default, bug #448058
IUSE="examples extra-print-profiles +gusb +introspection +policykit scanner systemd +udev vala"
REQUIRED_USE="
	gusb? ( udev )
	scanner? ( udev )
	vala? ( introspection )
"

COMMON_DEPEND="
	dev-db/sqlite:3=
	>=dev-libs/glib-2.36:2
	>=media-libs/lcms-2.6:2=
	gusb? ( >=dev-libs/libgusb-0.1.1[introspection?] )
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )
	policykit? ( >=sys-auth/polkit-0.103 )
	scanner? ( media-gfx/sane-backends )
	systemd? ( >=sys-apps/systemd-44:0= )
	udev? (
		virtual/udev
		virtual/libgudev:=
		virtual/libudev:=
		)
"
RDEPEND="${COMMON_DEPEND}
	!media-gfx/shared-color-profiles
	!<=media-gfx/colorhug-client-0.1.13
"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	extra-print-profiles? ( media-gfx/argyllcms )
	vala? ( $(vala_depend) )
"

# FIXME: needs pre-installed dbus service files
RESTRICT="test"

# According to upstream comment in colord.spec.in, building the extra print
# profiles requires >=4G of memory
CHECKREQS_MEMORY="4G"

pkg_pretend() {
	use extra-print-profiles && check-reqs_pkg_pretend
}

pkg_setup() {
	use extra-print-profiles && check-reqs_pkg_setup
	enewgroup colord
	enewuser colord -1 -1 /var/lib/colord colord
}

src_prepare() {
	use vala && vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	# Reverse tools require gusb
	# bash-completion test does not work on gentoo
	gnome2_src_configure \
		--disable-bash-completion \
		--disable-examples \
		--disable-static \
		--enable-libcolordcompat \
		--with-daemon-user=colord \
		--localstatedir="${EPREFIX}"/var \
		$(use_enable extra-print-profiles print-profiles) \
		$(usex extra-print-profiles COLPROF="$(type -P argyll-colprof)" "") \
		$(use_enable gusb) \
		$(use_enable gusb reverse) \
		$(use_enable introspection) \
		$(use_enable policykit polkit) \
		$(use_enable scanner sane) \
		$(use_enable systemd systemd-login) \
		$(use_enable udev) \
		--with-udevrulesdir="$(get_udevdir)"/rules.d \
		$(use_enable vala) \
		"$(systemd_with_unitdir)"
}

src_install() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README.md TODO"
	gnome2_src_install

	newbashcomp data/colormgr colormgr
	rm -vr "${ED}etc/bash_completion.d"

	# Ensure config and profile directories exist and /var/lib/colord/*
	# is writable by colord user
	keepdir /var/lib/color{,d}/icc
	fowners colord:colord /var/lib/colord{,/icc}

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi
}
