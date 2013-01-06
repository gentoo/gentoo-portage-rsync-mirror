# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/redshift/redshift-1.7-r1.ebuild,v 1.5 2012/08/16 20:40:38 hasufell Exp $

EAPI=4

PYTHON_DEPEND="gtk? 2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.*"

inherit autotools eutils gnome2-utils python

DESCRIPTION="A screen color temperature adjusting software"
HOMEPAGE="http://jonls.dk/redshift/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="geoclue gnome gtk nls"

COMMON_DEPEND=">=x11-libs/libX11-1.4
	x11-libs/libXxf86vm
	x11-libs/libxcb
	geoclue? ( app-misc/geoclue )
	gnome? ( dev-libs/glib:2
		>=gnome-base/gconf-2 )"
RDEPEND="${COMMON_DEPEND}
	gtk? ( >=dev-python/pygtk-2
		dev-python/pyxdg )"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	>py-compile
	epatch "${FILESDIR}"/${P}-make-conditionals.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable nls) \
		--enable-randr \
		--enable-vidmode \
		--disable-wingdi \
		$(use_enable gnome gnome-clock) \
		$(use_enable geoclue) \
		$(use_enable gtk gui) \
		--disable-ubuntu
}

src_install() {
	default

	# handle multiple python abi support
	per_abi_install() {
		cp "${D}"/usr/bin/gtk-redshift "${D}"/usr/bin/gtk-redshift-${PYTHON_ABI} || die
	 	python_convert_shebangs ${PYTHON_ABI} "${D}"/usr/bin/gtk-redshift-${PYTHON_ABI}
		emake DESTDIR="${D}" pythondir="$(python_get_sitedir)" -C src/gtk-redshift install
	}

	if use gtk ; then
		rm -R "${D}"/usr/$(get_libdir)/python* || die
		python_execute_function per_abi_install
		python_generate_wrapper_scripts -f "${D}"/usr/bin/gtk-redshift
	fi
}

pkg_preinst() {
	use gtk && gnome2_icon_savelist
}

pkg_postinst() {
	use gtk && { gnome2_icon_cache_update; python_mod_optimize gtk_${PN}; }
}

pkg_postrm() {
	use gtk && { gnome2_icon_cache_update; python_mod_cleanup gtk_${PN}; }
}
