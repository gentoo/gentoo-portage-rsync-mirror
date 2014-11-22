# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgusb/libgusb-0.1.6-r1.ebuild,v 1.1 2014/11/22 21:45:14 mgorny Exp $

EAPI=5
VALA_MIN_API_VERSION="0.16"
VALA_USE_DEPEND="vapigen"

inherit eutils multilib-minimal vala

DESCRIPTION="GObject wrapper for libusb"
HOMEPAGE="https://gitorious.org/gusb/"
SRC_URI="http://people.freedesktop.org/~hughsient/releases/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection static-libs vala"
REQUIRED_USE="vala? ( introspection )"

# udev is effectively a required dependency: configuring with --disable-gudev
# causes build failures
RDEPEND=">=dev-libs/glib-2.28:2[${MULTILIB_USEDEP}]
	virtual/libusb:1[${MULTILIB_USEDEP}]
	virtual/libgudev:=[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-1.29 )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-libs/libxslt
	dev-util/gtk-doc-am
	virtual/pkgconfig[${MULTILIB_USEDEP}]
	vala? ( $(vala_depend) )"
# gtk-doc-am needed for proper api docs installation

# Tests try to access usb devices in /dev
RESTRICT="test"

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		$(multilib_native_use_enable introspection) \
		$(use_enable static-libs static) \
		$(multilib_native_use_enable vala)

	if multilib_is_native_abi; then
		ln -s "${S}"/docs/api/html docs/api/html || die
	fi
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files
}
