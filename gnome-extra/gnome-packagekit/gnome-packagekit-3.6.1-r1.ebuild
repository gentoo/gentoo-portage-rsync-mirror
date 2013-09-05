# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-packagekit/gnome-packagekit-3.6.1-r1.ebuild,v 1.3 2013/09/05 19:44:49 mgorny Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_{6,7} python3_2 )

inherit eutils gnome2 python-r1 virtualx

DESCRIPTION="PackageKit client for the GNOME desktop"
HOMEPAGE="http://www.packagekit.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls systemd test udev"

# FIXME: add PYTHON_USEDEP on packagekit-base when available
# gdk-pixbuf used in gpk-animated-icon
# pango used on gpk-common
RDEPEND="
	>=dev-libs/glib-2.32:2
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.91.0:3
	>=x11-libs/libnotify-0.7.0:=
	x11-libs/pango
	>=dev-libs/dbus-glib-0.73

	>=app-admin/packagekit-base-0.7.2[udev]
	>=app-admin/packagekit-gtk-0.7.2
	>=media-libs/libcanberra-0.10[gtk3]
	>=sys-apps/dbus-1.1.2
	>=sys-power/upower-0.9.0

	media-libs/fontconfig
	x11-libs/libX11

	systemd? ( >=sys-apps/systemd-42 )
	!systemd? ( sys-auth/consolekit )
	udev? ( >=virtual/udev-171[gudev] )
"
DEPEND="${RDEPEND}
	app-text/docbook-sgml-utils
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
"

# NOTES:
# app-text/docbook-sgml-utils required for man pages
# app-text/gnome-doc-utils and dev-libs/libxslt required for gnome help files
# gtk-doc is generating a useless file, don't need it

# UPSTREAM:
# misuse of CPPFLAGS/CXXFLAGS ?
# see if tests can forget about display (use eclass for that ?)
# intltool and gettext only with +nls

src_prepare() {
	# Regenerate marshalers for <glib-2.31 compat
	rm -v src/gpk-marshal.{c,h} || die

	# * disable tests with graphical dialogs and that require packagekitd
	#   to be run with the dummy backend
	# * disable tests that fails every time packagekit developers make a
	#   tiny change to headers
	sed -e '/gpk_enum_test (test)/d' \
		-e '/gpk_error_test (test)/d' \
		-e '/gpk_modal_dialog_test (test)/d' \
		-e '/gpk_task_test (test)/d' \
		-i src/gpk-self-test.c || die

	# Leave python build to us
	sed '/python.*\\/d' -i Makefile.am Makefile.in || die

	# Disable stupid flags
	# FIXME: touching configure.ac triggers maintainer-mode
	sed -e '/CPPFLAGS="$CPPFLAGS -g"/d' -i configure || die

	mkdir -p "${S}_default" || die
	prepare_python() {
		mkdir -p "${BUILD_DIR}" || die
	}
	python_foreach_impl prepare_python
	gnome2_src_prepare
}

src_configure() {
	G2CONF="${G2CONF}
		--localstatedir=/var
		--enable-compile-warnings=yes
		--enable-iso-c
		--disable-strict
		$(use_enable nls)
		$(use_enable systemd)
		$(use_enable test tests)
		$(use_enable udev gudev)
		ITSTOOL=$(type -P true)"

	cd "${S}_default" || die
	ECONF_SOURCE="${S}" gnome2_src_configure
	configure_python() {
		mkdir -p "${BUILD_DIR}" || die
		cd "${BUILD_DIR}" || die
		ECONF_SOURCE="${S}" gnome2_src_configure
	}
	python_foreach_impl configure_python
}

src_compile() {
	cd "${S}_default" || die
	gnome2_src_compile
	build_python() {
		cd "${BUILD_DIR}"/python || die
		default
	}
	python_foreach_impl build_python
}

src_test() {
	unset DISPLAY
	cd "${S}_default" || die
	Xemake check
}

src_install() {
	cd "${S}_default" || die
	gnome2_src_install

	install_python() {
		cd "${BUILD_DIR}"/python || die
		emake install DESTDIR="${D}" VPATH="${S}/python/packagekit:${BUILD_DIR}" || die
	}
	python_foreach_impl install_python

	cd "${S}" || die
	dodoc AUTHORS MAINTAINERS NEWS README TODO
}
