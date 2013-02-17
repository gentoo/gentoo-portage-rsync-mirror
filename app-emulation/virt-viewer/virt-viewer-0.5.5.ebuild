# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-viewer/virt-viewer-0.5.5.ebuild,v 1.1 2013/02/17 19:13:10 cardoe Exp $

EAPI=5
inherit eutils gnome2 toolchain-funcs

DESCRIPTION="Graphical console client for connecting to virtual machines"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3 nsplugin sasl +spice +vnc"

RDEPEND=">=app-emulation/libvirt-0.10.0[sasl?]
	>=dev-libs/libxml2-2.6
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( >=x11-libs/gtk+-2.18:2 )
	nsplugin? (
		>=dev-libs/nspr-4
		>=x11-libs/gtk+-2.18:2
		)
	spice? ( >=net-misc/spice-gtk-0.18[sasl?,gtk3=] )
	vnc? ( >=net-libs/gtk-vnc-0.5.0[sasl?,gtk3=] )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	nsplugin? ( =net-misc/npapi-sdk-0.27 )
	spice? ( >=app-emulation/spice-protocol-0.10.1 )"

REQUIRED_USE="|| ( spice vnc )"

GTK2_BUILDDIR="${WORKDIR}/${P}_nsplugin"
GTK3_BUILDDIR="${WORKDIR}/${P}_gtk"

pkg_setup() {
	G2CONF="$(use_with vnc gtk-vnc) $(use_with spice spice-gtk)"

	GTK2_G2CONF="${G2CONF} $(use_enable nsplugin plugin)"
	GTK2_G2CONF="${G2CONF} --with-gtk=2.0"

	GTK3_G2CONF="${G2CONF} --with-gtk=3.0"
}

src_prepare() {
	mkdir ${GTK2_BUILDDIR} || die
	mkdir ${GTK3_BUILDDIR} || die

	epatch "${FILESDIR}"/${PN}-0.5.x-npapi-sdk.patch
}

src_configure() {
	if use nsplugin; then
		export MOZILLA_PLUGIN_CFLAGS="$($(tc-getPKG_CONFIG) --cflags npapi-sdk nspr)"
		export MOZILLA_PLUGIN_LIBS="$($(tc-getPKG_CONFIG) --libs npapi-sdk nspr)"
	fi

	export ECONF_SOURCE="${S}"

	cd ${GTK2_BUILDDIR}
	echo "Running configure in ${GTK2_BUILDDIR}"
	G2CONF="${GTK2_G2CONF}" gnome2_src_configure

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		echo "Running configure in ${GTK3_BUILDDIR}"
		G2CONF="${GTK3_G2CONF}" gnome2_src_configure
	fi
}

src_compile() {
	cd ${GTK2_BUILDDIR}
	echo "Running make in ${GTK2_BUILDDIR}"
	default

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		echo "Running make in ${GTK3_BUILDDIR}"
		default
	fi
}

src_test() {
	cd ${GTK2_BUILDDIR}
	echo "Running make check in ${GTK2_BUILDDIR}"
	default

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		echo "Running make check in ${GTK3_BUILDDIR}"
		default
	fi
}

src_install() {
	cd ${GTK2_BUILDDIR}
	echo "Running make install in ${GTK2_BUILDDIR}"
	default

	if use gtk3; then
		cd ${GTK3_BUILDDIR}
		echo "Running make install in ${GTK3_BUILDDIR}"
		default
	fi
}
