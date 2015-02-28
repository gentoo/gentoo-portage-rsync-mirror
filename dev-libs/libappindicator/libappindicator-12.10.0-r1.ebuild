# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libappindicator/libappindicator-12.10.0-r1.ebuild,v 1.1 2015/04/05 16:09:44 mgorny Exp $

EAPI=5
VALA_MIN_API_VERSION="0.16"
VALA_USE_DEPEND="vapigen"

inherit eutils vala autotools-multilib

DESCRIPTION="A library to allow applications to export a menu into the Unity Menu bar"
HOMEPAGE="http://launchpad.net/libappindicator"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

RDEPEND="
	>=dev-libs/dbus-glib-0.98[${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.26:2[${MULTILIB_USEDEP}]
	>=dev-libs/libdbusmenu-0.6.2[gtk3,${MULTILIB_USEDEP}]
	>=dev-libs/libindicator-12.10.0:3[${MULTILIB_USEDEP}]
	>=x11-libs/gtk+-3.2:3[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-1 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig[${MULTILIB_USEDEP}]
	introspection? ( $(vala_depend) )
"

disable_python_for_abi_x86() {
	if ! multilib_is_native_abi; then
		cd "${BUILD_DIR}" || die "couldn't change into BUILD_DIR"

		# disable configure checks
		epatch "${FILESDIR}"/multilib_disable_python.patch
		sed -i -e "s/.*python.*/\\\/" bindings/Makefile.am || die not found
		sed -i -e "s/ python //" bindings/Makefile.in || die not found
		eautoreconf
	fi
}

src_prepare() {
	# Don't use -Werror
	sed -i -e 's/ -Werror//' {src,tests}/Makefile.{am,in} || die

	# Disable MONO for now because of http://bugs.gentoo.org/382491
	sed -i -e '/^MONO_REQUIRED_VERSION/s:=.*:=9999:' configure || die
	use introspection && vala_src_prepare

	multilib_copy_sources
	multilib_foreach_abi disable_python_for_abi_x86
}

multilib_src_configure() {
	# http://bugs.gentoo.org/409133
	export APPINDICATOR_PYTHON_CFLAGS=' '
	export APPINDICATOR_PYTHON_LIBS=' '

	econf \
		--disable-silent-rules \
		--disable-static \
		$(multilib_native_use_enable introspection) \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-gtk=3
}

multilib_src_install() {
	emake -j1 DESTDIR="${D}" install
}

multilib_src_install_all() {
	dodoc AUTHORS ChangeLog

	prune_libtool_files
}
