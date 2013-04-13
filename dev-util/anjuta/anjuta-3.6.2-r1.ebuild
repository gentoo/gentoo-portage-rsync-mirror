# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-3.6.2-r1.ebuild,v 1.6 2013/04/13 07:37:16 ago Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_6,2_7} )
# libanjuta-language-vala.so links to a specific slot of libvala; we want to
# avoid automagic behavior.
VALA_MIN_API_VERSION="0.18"
VALA_MAX_API_VERSION="${VALA_MIN_API_VERSION}"

inherit autotools eutils gnome2 flag-o-matic multilib python-single-r1 vala

DESCRIPTION="A versatile IDE for GNOME"
HOMEPAGE="http://www.anjuta.org"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~x86-fbsd"
IUSE="debug devhelp glade +introspection packagekit subversion test vala"

# FIXME: make python dependency non-automagic
COMMON_DEPEND=">=dev-libs/glib-2.32:2
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.4:3
	>=x11-libs/vte-0.27.6:2.90
	>=dev-libs/libxml2-2.4.23
	>=dev-libs/gdl-3.5.5:3=
	>=x11-libs/gtksourceview-3:3.0

	sys-devel/autogen

	>=gnome-extra/libgda-5:5=
	dev-util/ctags

	x11-libs/libXext
	x11-libs/libXrender

	${PYTHON_DEPS}

	devhelp? ( >=dev-util/devhelp-3.4.2:= )
	glade? ( >=dev-util/glade-3.12:3.10= )
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	subversion? (
		>=dev-vcs/subversion-1.5.0:=
		>=net-libs/neon-0.28.2:=
		>=dev-libs/apr-1:=
		>=dev-libs/apr-util-1:= )
	vala? ( $(vala_depend) )
"
RDEPEND="${COMMON_DEPEND}
	packagekit? ( app-admin/packagekit-base )
"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/perl-5
	>=dev-util/gtk-doc-am-1.4
	>=dev-util/intltool-0.40.1
	sys-devel/bison
	sys-devel/flex
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	!!dev-libs/gnome-build
	test? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/docbook-xml-dtd:4.5 )

	app-text/yelp-tools
	dev-libs/gobject-introspection-common
	gnome-base/gnome-common
"
# eautoreconf requires: gtk-doc-am, gnome-common, gobject-introspection-common, yelp-tools

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	# COPYING is used in Anjuta's help/about entry
	DOCS="AUTHORS ChangeLog COPYING FUTURE MAINTAINERS NEWS README ROADMAP THANKS TODO"

	G2CONF="${G2CONF}
		--disable-static
		--docdir=/usr/share/doc/${PF}
		$(use_enable debug)
		$(use_enable devhelp plugin-devhelp)
		$(use_enable glade plugin-glade)
		$(use_enable introspection)
		$(use_enable packagekit)
		$(use_enable subversion plugin-subversion)
		$(use_enable vala)"

	# Conflicts with -pg in a plugin, bug #266777
	filter-flags -fomit-frame-pointer

	# python2.7-configure in Fedora vs. python-configure in Gentoo
	sed -e 's:$PYTHON-config:$PYTHON$PYTHON_VERSION-config:g' \
		-i plugins/am-project/tests/anjuta.lst || die "sed failed"

	# https://bugzilla.gnome.org/show_bug.cgi?id=684758
	epatch "${FILESDIR}/${PN}-3.5.91-cxx-check.patch"
	eautoreconf

	use vala && vala_src_prepare
	gnome2_src_prepare
}

src_install() {
	# COPYING is used in Anjuta's help/about entry
	docompress -x "/usr/share/doc/${PF}/COPYING"

	# Anjuta uses a custom rule to install DOCS, get rid of it
	gnome2_src_install
	rm -rf "${ED}"/usr/share/doc/${PN} || die "rm failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog ""
	elog "Some project templates may require additional development"
	elog "libraries to function correctly. It goes beyond the scope"
	elog "of this ebuild to provide them."

	if use vala; then
		elog ""
		elog "To create a generic vala project you will need to specify"
		elog "desired valac versioned binary to be used, to do that you"
		elog "will need to:"
		elog "1. Go to 'Build' -> 'Configure project'"
		elog "2. Add 'VALAC=/usr/bin/valac-X.XX' (respecting quotes) to"
		elog "'Configure options'."
	fi
}
