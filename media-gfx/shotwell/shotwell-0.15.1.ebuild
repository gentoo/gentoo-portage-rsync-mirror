# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/shotwell/shotwell-0.15.1.ebuild,v 1.3 2014/02/20 20:40:10 ago Exp $

EAPI=5

GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.20"
VALA_MAX_API_VERSION="0.22"

inherit eutils gnome2 multilib toolchain-funcs vala versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Open source photo manager for GNOME"
HOMEPAGE="http://yorba.org/shotwell/"
SRC_URI="http://www.yorba.org/download/${PN}/stable/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

CORE_SUPPORTED_LANGUAGES="
	ia hi te fr de it es pl et sv sk lv pt bg bn nl da zh_CN
	el ru pa hu en_GB uk ja fi zh_TW cs nb id th sl hr ar ast ro sr lt gl tr ca ko kk pt_BR
	eu he mk ta vi or km af as gu kn ml mr af_ZA bn_IN id_ID ky nn_NO ta_IN te_IN "

EXTRAS_SUPPORTED_LANGUAGES="
	fr de it es pl et sv sk lv pt bg bn nl da zh_CN el ru pa hu en_GB uk
	ja fi zh_TW cs nb id th sl hr ar ast ro sr lt gl tr ca ko kk pt_BR eu he mk te ta eo or hi
	as kn ml mr bn_IN gu id_ID nn_NO vi"

for x in ${CORE_SUPPORTED_LANGUAGES} ${EXTRAS_SUPPORTED_LANGUAGES}; do
	IUSE+="linguas_${x} "
done

RDEPEND="
	>=dev-db/sqlite-3.5.9:3
	>=dev-libs/dbus-glib-0.80
	>=dev-libs/glib-2.30.0:2
	>=dev-libs/json-glib-0.7.6
	>=dev-libs/libgee-0.8.5:0.8
	>=dev-libs/libxml2-2.6.32:2
	>=dev-util/desktop-file-utils-0.13
	gnome-base/dconf
	>=media-libs/gexiv2-0.4.90
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gstreamer:1.0
	media-libs/lcms:2
	>=media-libs/libexif-0.6.16:=
	>=media-libs/libgphoto2-2.4.2:=
	>=media-libs/libraw-0.13.2:=
	>=net-libs/libsoup-2.26.0:2.4
	>=net-libs/rest-0.7:0.7
	>=net-libs/webkit-gtk-1.4:3
	>=virtual/udev-145[gudev]
	>=x11-libs/gtk+-3.6.0:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	>=sys-devel/m4-1.4.13"

DOCS=( AUTHORS MAINTAINERS NEWS README THANKS )

# This probably comes from libraries that
# shotwell-video-thumbnailer links to.
# Nothing we can do at the moment. #435048
QA_FLAGS_IGNORED="/usr/libexec/${PN}/${PN}-video-thumbnailer"

pkg_setup() {
	tc-export CC
	G2CONF="${G2CONF}
		--disable-schemas-compile
		--disable-desktop-update
		--disable-icon-update
		--prefix=/usr
		--lib=$(get_libdir)"
}

src_prepare() {
	vala_src_prepare
	sed \
		-e 's|CFLAGS :|CFLAGS +|g' \
		-i plugins/Makefile.plugin.mk || die
	epatch \
		"${FILESDIR}"/${PN}-0.13.1-ldflags.patch
}

src_configure() {
	./configure \
		${G2CONF} \
		|| die
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
