# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/shotwell/shotwell-0.12.3.ebuild,v 1.4 2012/12/11 11:15:25 ssuominen Exp $

EAPI=4
GCONF_DEBUG="no"
inherit gnome2 versionator eutils multilib toolchain-funcs

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Open source photo manager for GNOME"
HOMEPAGE="http://yorba.org/shotwell/"
SRC_URI="http://www.yorba.org/download/${PN}/${MY_PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

LANGS="ar ast bg bn ca cs da de el en_GB es et eu fi fr gl he hi hr hu ia id it ja kk
ko lt lv mk nb nl pa pl pt pt_BR ro ru sk sl sr sv ta te ta_IN te_IN th tr uk vi zh_CN zh_TW"

for x in ${LANGS}; do
	IUSE+="linguas_${x} "
done

RDEPEND="
	>=dev-db/sqlite-3.5.9:3
	>=dev-libs/dbus-glib-0.80
	>=dev-libs/glib-2.30.0:2
	>=dev-libs/json-glib-0.7.6
	>=dev-libs/libgee-0.5.0:0
	>=dev-libs/libunique-3.0.0:3
	>=dev-libs/libxml2-2.6.32:2
	>=media-libs/gexiv2-0.3.92
	media-libs/gst-plugins-base:0.10
	media-libs/gstreamer:0.10
	media-libs/lcms:2
	>=media-libs/libexif-0.6.16
	>=media-libs/libgphoto2-2.4.2
	>=media-libs/libraw-0.14.0
	>=net-libs/libsoup-2.26.0:2.4
	net-libs/rest:0.7
	net-libs/webkit-gtk:3
	virtual/udev[gudev]
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	sys-devel/m4"

DOCS=( AUTHORS MAINTAINERS NEWS README THANKS )

pkg_setup() {
	tc-export CC
	G2CONF="${G2CONF}
		--disable-schemas-compile
		--disable-desktop-update
		--disable-icon-update
		--lib=$(get_libdir)"
}

src_prepare() {
	sed \
		-e 's|CFLAGS :|CFLAGS +|g' \
		-i plugins/Makefile.plugin.mk || die
}

src_compile() {
	emake VALAC="$(type -p valac-0.16)"
}

src_install() {
	gnome2_src_install
	for x in ${LANGS}; do
		if ! has ${x} ${LINGUAS}; then
			find "${D}"/usr/share/locale/${x} -type f -exec rm {} \;
		fi
	done
}
