# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.14.25.ebuild,v 1.4 2013/03/25 16:29:44 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils gnome2 multilib python-r1

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://projects.gnome.org/libgsf/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="bzip2 gtk +introspection python"

RDEPEND=">=dev-libs/glib-2.26:2
	>=dev-libs/libxml2-2.4.16:2
	sys-libs/zlib
	bzip2? ( app-arch/bzip2 )
	gtk? ( x11-libs/gtk+:2 )
	introspection? ( >=dev-libs/gobject-introspection-1 )
	python? (
		${PYTHON_DEPS}
		>=dev-python/pygobject-2.10:2
		>=dev-python/pygtk-2.10:2 )"

DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
	>=dev-util/intltool-0.35.0
	dev-libs/gobject-introspection-common
	virtual/pkgconfig
"

BUILD_DIR="${S}/python"

src_configure() {
	DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-static
		$(use_with bzip2 bz2)
		$(use_enable introspection)
		$(use_with gtk gdk-pixbuf)"

	if use python ; then
		copy_binding() {
			gnome2_src_configure --with-python
			cp -r python "${BUILD_DIR}"
		}
		python_foreach_impl copy_binding
	fi

	gnome2_src_configure --without-python
}

src_compile() {
	gnome2_src_compile

	if use python ; then
		building() {
			cd "${BUILD_DIR}"
			python_export PYTHON_SITEDIR
			default
		}
		python_foreach_impl building
	fi
}

src_install() {
	gnome2_src_install

	if use python ; then
		installation() {
			cd "${BUILD_DIR}"
			emake install DESTDIR="${D}"
		}
		python_foreach_impl installation
		prune_libtool_files --modules
	fi
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libgsf-1.so.1
	preserve_old_lib /usr/$(get_libdir)/libgsf-gnome-1.so.1
}

pkg_postinst() {
	gnome2_pkg_postinst
	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-1.so.1
	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-gnome-1.so.1
}
