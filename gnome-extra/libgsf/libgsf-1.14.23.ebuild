# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.14.23.ebuild,v 1.11 2012/10/28 15:55:49 armin76 Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="python? 2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython *-pypy-*"

inherit autotools eutils gnome2 python multilib

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://projects.gnome.org/libgsf/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="bzip2 doc gtk +introspection python"

RDEPEND=">=dev-libs/glib-2.26:2
	>=dev-libs/libxml2-2.4.16:2
	sys-libs/zlib
	bzip2? ( app-arch/bzip2 )
	gtk? ( x11-libs/gtk+:2 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	python? (
		>=dev-python/pygobject-2.10:2
		>=dev-python/pygtk-2.10:2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	dev-util/gtk-doc-am
	dev-libs/gobject-introspection-common
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"
	G2CONF="${G2CONF}
		--with-gio
		--disable-static
		$(use_with bzip2 bz2)
		$(use_with python)
		$(use_with gtk gdk-pixbuf)"

	use python && python_pkg_setup
}

src_prepare() {
	# Drop DEPRECATED flags
	sed -i -e "s/ -DG_DISABLE_DEPRECATED//" configure.in configure || die

	# Python bindings are built/installed manually.
	sed -e "/SUBDIRS += python/d" -i Makefile.am || die

	use python && python_clean_py-compile_files

	# compilation: avoid identifier "clone", fixed in next version
	epatch "${FILESDIR}/${P}-clone-identifier.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
	gnome2_src_prepare
}

src_compile() {
	gnome2_src_compile

	if use python; then
		python_copy_sources python

		building() {
			emake \
				PYTHON_INCLUDES="-I$(python_get_includedir)" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir python building
	fi
}

src_install() {
	gnome2_src_install

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_execute_function -s --source-dir python installation

		python_clean_installation_image
	fi
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libgsf-1.so.1
	preserve_old_lib /usr/$(get_libdir)/libgsf-gnome-1.so.1
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use python; then
		python_mod_optimize gsf
	fi

	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-1.so.1
	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-gnome-1.so.1
}

pkg_postrm() {
	gnome2_pkg_postrm

	if use python; then
		python_mod_cleanup gsf
	fi
}
