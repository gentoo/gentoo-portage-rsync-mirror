# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/abrt/abrt-2.0.6.ebuild,v 1.8 2012/05/31 02:21:27 zmedico Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"

# Need gnome2-utils for gnome2_icon_cache_update
inherit autotools eutils gnome2-utils python systemd user

DESCRIPTION="Automatic bug detection and reporting tool"
HOMEPAGE="https://fedorahosted.org/abrt/"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

COMMON_DEPEND="dev-libs/btparser
	>=dev-libs/glib-2.21:2
	dev-libs/libreport
	dev-libs/libxml2
	dev-libs/nss
	sys-apps/dbus
	sys-fs/inotify-tools
	x11-libs/gtk+:2
	x11-libs/libnotify"
RDEPEND="${COMMON_DEPEND}
	app-arch/cpio
	dev-libs/elfutils
	sys-devel/gdb"
DEPEND="${COMMON_DEPEND}
	app-text/asciidoc
	app-text/xmlto
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	>=sys-devel/gettext-0.17"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	enewgroup abrt
	enewuser abrt -1 -1 -1 abrt
}

src_prepare() {
	# Disable redhat-specific code not usable in gentoo, or that requires
	# bugs.gentoo.org infra support.
	epatch "${FILESDIR}/${PN}-2.0.6-gentoo.patch"

	# Using a server response as a format string is a bad idea
	epatch "${FILESDIR}/${PN}-2.0.6-format-security.patch"

	# Fixes building with glib-2.31, will be in next release
	epatch "${FILESDIR}/${P}-glib-2.31.patch"

	# -Werror should not be used by default
	sed -e 's/-Werror\( \|$\)//g' \
		-i src/applet/Makefile.* src/cli/Makefile.* src/daemon/Makefile.* \
		   src/gui-gtk/Makefile.* src/hooks/Makefile.* src/lib/Makefile.* \
		   src/plugins/Makefile.* || die "sed failed"

	mkdir m4
	eautoreconf

	echo '#!/bin/sh' > py-compile
	python_convert_shebangs -r 2 src
}

src_configure() {
	# Configure checks for python.pc; our python-2.7 installs python-2.7.pc,
	# while python-2.6 does not install any pkgconfig file.
	export PYTHON_CFLAGS=$(python-config --includes)
	export PYTHON_LIBS=$(python-config --libs)

	myeconfargs=( "--localstatedir=${EPREFIX}/var" )
	# --disable-debug enables debug!
	use debug && myeconfargs=( "${myeconfargs[@]}" --enable-debug )
	systemd_to_myeconfargs
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	keepdir /var/run/abrt
	# /var/spool/abrt is created by dev-libs/libreport

	diropts -m 700 -o abrt -g abrt
	keepdir /var/spool/abrt-upload

	diropts -m 775 -o abrt -g abrt
	keepdir /var/cache/abrt-di

	find "${D}" -name '*.la' -exec rm -f {} + || die

	newinitd "${FILESDIR}/${PN}-2.0.5-init" abrt
	newconfd "${FILESDIR}/${PN}-2.0.5-conf" abrt
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	python_mod_optimize abrt_exception_handler.py
	elog "To start the bug detection service on an openrc-based system, do"
	elog "# /etc/init.d/abrt start"
}

pkg_postrm() {
	gnome2_icon_cache_update
	python_mod_cleanup abrt_exception_handler.py
}
