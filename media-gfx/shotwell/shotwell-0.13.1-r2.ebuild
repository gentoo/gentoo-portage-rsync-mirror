# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/shotwell/shotwell-0.13.1-r2.ebuild,v 1.3 2013/05/08 06:37:02 jlec Exp $

EAPI=5

GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.18"

inherit eutils gnome2 multilib toolchain-funcs vala versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Open source photo manager for GNOME"
HOMEPAGE="http://yorba.org/shotwell/"
SRC_URI="http://www.yorba.org/download/${PN}/stable/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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
	gnome-base/dconf
	>=media-libs/gexiv2-0.3.92
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gstreamer:1.0
	media-libs/lcms:2
	>=media-libs/libexif-0.6.16
	>=media-libs/libgphoto2-2.4.2:=
	>=media-libs/libraw-0.14.0
	>=net-libs/libsoup-2.26.0:2.4
	net-libs/rest:0.7
	net-libs/webkit-gtk:3
	virtual/udev[gudev]
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	sys-devel/m4"

DOCS=( AUTHORS MAINTAINERS NEWS README THANKS )

# This probably comes from libraries that
# shotwell-video-thumbnailer links to.
# Nothing we can do at the moment. #435048
QA_FLAGS_IGNORED="/usr/bin/${PN}-video-thumbnailer"

pkg_setup() {
	tc-export CC
	G2CONF="${G2CONF}
		--disable-schemas-compile
		--disable-desktop-update
		--disable-icon-update
		--lib=$(get_libdir)"
}

src_prepare() {
	vala_src_prepare
	sed \
		-e 's|CFLAGS :|CFLAGS +|g' \
		-i plugins/Makefile.plugin.mk || die
	epatch \
		"${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-gst-1.0.patch
}

src_compile() {
	local valaver="$(vala_best_api_version)"
	emake VALAC="$(type -p valac-${valaver})"
}

src_install() {
	gnome2_src_install
	for x in ${LANGS}; do
		if ! has ${x} ${LINGUAS}; then
			find "${D}"/usr/share/locale/${x} -type f -exec rm {} \;
		fi
	done
}
