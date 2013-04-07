# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.28.2-r205.ebuild,v 1.2 2013/04/07 19:38:16 hasufell Exp $

EAPI="5"
GCONF_DEBUG="yes"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils gnome2 python-r1

DESCRIPTION="GNOME terminal widget"
HOMEPAGE="https://live.gnome.org/VTE"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug glade +introspection python"

PDEPEND="x11-libs/gnome-pty-helper"
RDEPEND=">=dev-libs/glib-2.26:2
	>=x11-libs/gtk+-2.20:2[introspection?]
	>=x11-libs/pango-1.22.0

	sys-libs/ncurses
	x11-libs/libX11
	x11-libs/libXft

	glade? ( dev-util/glade:3 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )
	python? (
		${PYTHON_DEPS}
		dev-python/pygtk:2[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	sys-devel/gettext"

wrap_phase() {
	if use python; then
		python_foreach_impl run_in_build_dir "${@}"
	else
		"${@}"
	fi
}

src_prepare() {
	# Do not disable gnome-pty-helper, bug #401389
	G2CONF="${G2CONF}
		--disable-deprecation
		--disable-static
		$(use_enable debug)
		$(use_enable glade glade-catalogue)
		$(use_enable introspection)
		$(use_enable python)
		--with-gtk=2.0"

	if [[ ${CHOST} == *-interix* ]]; then
		G2CONF="${G2CONF} --disable-Bsymbolic"

		# interix stropts.h is empty...
		export ac_cv_header_stropts_h=no
	fi

	DOCS="AUTHORS ChangeLog HACKING NEWS README"

	# https://bugzilla.gnome.org/show_bug.cgi?id=663779
	epatch "${FILESDIR}/${PN}-0.30.1-alt-meta.patch"

	# https://bugzilla.gnome.org/show_bug.cgi?id=652290
	epatch "${FILESDIR}"/${PN}-0.28.2-interix.patch

	# Fix CVE-2012-2738, upstream bug #676090
	epatch "${FILESDIR}"/${PN}-0.28.2-limit-arguments.patch

	gnome2_src_prepare
	use python && python_copy_sources
}

src_configure() {
	wrap_phase gnome2_src_configure
}

src_compile() {
	wrap_phase gnome2_src_compile
}

src_install() {
	wrap_phase gnome2_src_install
	rm -v "${ED}usr/libexec/gnome-pty-helper" || die
}
