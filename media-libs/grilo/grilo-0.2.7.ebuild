# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/grilo/grilo-0.2.7.ebuild,v 1.1 2013/09/28 20:15:35 pacho Exp $

EAPI="5"
GCONF_DEBUG="no" # --enable-debug only changes CFLAGS
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_{6,7} )
VALA_MIN_API_VERSION="0.12"
VALA_MAX_API_VERSION="0.20" # explicitly specified in configure
VALA_USE_DEPEND="vapigen"

inherit gnome2 python-any-r1 vala

DESCRIPTION="A framework for easy media discovery and browsing"
HOMEPAGE="https://live.gnome.org/Grilo"

LICENSE="LGPL-2.1+"
SLOT="0.2/1" # subslot is libgrilo-0.2 soname suffix
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="gtk examples +introspection +network test vala"
REQUIRED_USE="test? ( introspection )"

RDEPEND="
	>=dev-libs/glib-2.29.10:2
	dev-libs/libxml2:2
	net-libs/liboauth
	gtk? ( >=x11-libs/gtk+-3:3 )
	introspection? ( >=dev-libs/gobject-introspection-0.9 )
	network? ( >=net-libs/libsoup-2.41.3:2.4 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.10
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	test? (
		${PYTHON_DEPS}
		dev-python/pygobject:2
		dev-python/pygobject:3
		media-plugins/grilo-plugins:0.2 )
"
# eautoreconf requires gnome-common

python_check_deps() {
	has_version "dev-python/pygobject:2[${PYTHON_USEDEP}]" && \
		has_version "dev-python/pygobject:3[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	# Don't build examples
	sed -e '/SUBDIRS/s/examples//' \
		-i Makefile.am -i Makefile.in || die

	use vala && vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	# --enable-debug only changes CFLAGS, useless for us
	gnome2_src_configure \
		--disable-static \
		--disable-debug \
		$(use_enable gtk test-ui) \
		$(use_enable introspection) \
		$(use_enable network grl-net) \
		$(use_enable test tests) \
		$(use_enable vala)
}

src_install() {
	gnome2_src_install
	# Upstream made this conditional on gtk-doc build...
	emake -C doc install DESTDIR="${ED}"

	# Prevent file collision with other slot
	if use vala; then
		mv "${ED}usr/bin/grilo-simple-playlist" \
			"${ED}usr/bin/grilo-simple-playlist-${SLOT%/*}" || die
	fi

	if use examples; then
		# Install example code
		insinto /usr/share/doc/${PF}/examples
		doins "${S}"/examples/*.c
	fi
}
