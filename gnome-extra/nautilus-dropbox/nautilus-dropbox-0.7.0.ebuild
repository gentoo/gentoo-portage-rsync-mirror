# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-dropbox/nautilus-dropbox-0.7.0.ebuild,v 1.4 2012/06/07 22:22:02 zmedico Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit autotools eutils python linux-info gnome2 user

DESCRIPTION="Store, Sync and Share Files Online"
HOMEPAGE="http://www.dropbox.com/"
SRC_URI="http://www.dropbox.com/download?dl=packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux"
IUSE="debug"

RDEPEND="gnome-base/nautilus
	dev-libs/glib:2
	dev-python/pygtk:2
	net-misc/dropbox
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXinerama"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-python/docutils"

DOCS="AUTHORS ChangeLog NEWS README"
G2CONF="${G2CONF} $(use_enable debug) --disable-static"

CONFIG_CHECK="~INOTIFY_USER"

pkg_setup () {
	check_extra_config
	enewgroup dropbox
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare
	python_convert_shebangs 2 dropbox.in

	# use sysem dropbox
	sed -e "s|~/[.]dropbox-dist|/opt/dropbox|" \
		-e 's|\(DROPBOXD_PATH = \).*|\1"/opt/dropbox/dropboxd"|' \
			-i dropbox.in || die
	# us system rst2man
	epatch "${FILESDIR}"/${P}-system-rst2man.patch
	AT_NOELIBTOOLIZE=yes eautoreconf
}

src_install () {
	gnome2_src_install

	local extensiondir="$(pkg-config --variable=extensiondir libnautilus-extension)"
	[ -z ${extensiondir} ] && die "pkg-config unable to get nautilus extensions dir"

	# Strip $EPREFIX from $extensiondir as fowners/fperms act on $ED not $D
	extensiondir="${extensiondir#${EPREFIX}}"

	find "${ED}" -name '*.la' -exec rm -f {} + || die

	use prefix || fowners root:dropbox "${extensiondir}"/libnautilus-dropbox.so
	fperms o-rwx "${extensiondir}"/libnautilus-dropbox.so
}

pkg_postinst () {
	gnome2_pkg_postinst

	elog
	elog "Add any users who wish to have access to the dropbox nautilus"
	elog "plugin to the group 'dropbox'. You need to setup a drobox account"
	elog "before using this plugin. Visit ${HOMEPAGE} for more information."
	elog
}
