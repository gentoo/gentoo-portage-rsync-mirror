# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-0.5.5.ebuild,v 1.3 2014/04/07 16:59:24 ssuominen Exp $

EAPI=5

MY_VALA_VERSION=0.20
VALA_MIN_API_VERSION=${MY_VALA_VERSION}
VALA_MAX_API_VERSION=${MY_VALA_VERSION}

PYTHON_COMPAT=( python2_7 )

unset _live_inherits

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://git.xfce.org/apps/${PN}"
	_live_inherits=git-2
else
	KEYWORDS="~amd64 ~arm ~mips ~ppc ~x86 ~x86-fbsd"
	SRC_URI="http://www.${PN}-browser.org/downloads/${PN}_${PV}_all_.tar.bz2"
fi

inherit eutils fdo-mime gnome2-utils pax-utils python-any-r1 waf-utils vala ${_live_inherits}

DESCRIPTION="A lightweight web browser based on WebKitGTK+"
HOMEPAGE="http://www.midori-browser.org/"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
IUSE="doc +unique zeitgeist"

RDEPEND=">=dev-db/sqlite-3.6.19:3
	>=dev-libs/glib-2.32.3
	dev-libs/libxml2
	>=net-libs/libsoup-2.34:2.4
	>=net-libs/libsoup-gnome-2.34:2.4
	>=x11-libs/libnotify-0.7
	x11-libs/libXScrnSaver
	>=net-libs/webkit-gtk-1.8.3:2
	>=x11-libs/gtk+-2.24:2
	unique? ( dev-libs/libunique:1 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.14 )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	$(vala_depend)
	dev-util/intltool
	gnome-base/librsvg
	sys-devel/gettext
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	python-any-r1_pkg_setup

	DOCS=( AUTHORS ChangeLog HACKING README TODO TRANSLATE )
	HTML_DOCS=( data/faq.html data/faq.css )
}

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		git-2_src_unpack
	else
		default
	fi
}

src_prepare() {
	# Force disabled because we don't have this custom renamed in Portage
	sed -i -e 's:gcr-3-gtk2:&dIsAbLe:' wscript || die

	vala_src_prepare
}

src_configure() {
	export VALAC_VERSION=${MY_VALA_VERSION}

	strip-linguas -i po

	waf-utils_src_configure \
		--disable-docs \
		$(use_enable doc apidocs) \
		$(use_enable unique) \
		--disable-granite \
		--disable-gtk3 \
		$(use_enable zeitgeist) \
		--disable-webkit2
}

src_install() {
	waf-utils_src_install

	local jit_is_enabled
	has_version 'net-libs/webkit-gtk:2[jit]' && jit_is_enabled=yes
	[[ ${jit_is_enabled} == yes ]] && pax-mark -m "${ED}"/usr/bin/${PN} #480290
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
