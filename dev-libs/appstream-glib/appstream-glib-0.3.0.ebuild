# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/appstream-glib/appstream-glib-0.3.0.ebuild,v 1.4 2014/10/16 02:43:40 blueness Exp $

EAPI=5

inherit autotools eutils bash-completion-r1

MY_P="${PN/-/_}_${PV//./_}"

DESCRIPTION="Provides GObjects and helper methods to read and write AppStream metadata"
HOMEPAGE="https://github.com/hughsie/appstream-glib"
SRC_URI="https://github.com/hughsie/${PN}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/7"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64"
IUSE="+introspection nls"

# FIXME: yaml is optional but not properly handled in autofoo
RDEPEND="
	app-arch/libarchive
	dev-db/sqlite:3
	>=dev-libs/glib-2.16.1:2
	media-libs/fontconfig
	>=media-libs/freetype-2.4:2
	>=net-libs/libsoup-2.24:2.4
	>=x11-libs/gdk-pixbuf-2.14:2
	x11-libs/gtk+:3
	x11-libs/pango
	dev-libs/libyaml
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )
"
# gtk-doc required until package is released properly
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.3
	dev-libs/libxslt
	>=dev-util/gtk-doc-1.21
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
"

S="${WORKDIR}/${PN}-${MY_P}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-rpm \
		--disable-static \
		--enable-dep11 \
		--enable-man \
		$(use_enable nls) \
		$(use_enable introspection) \
		--with-bashcompletiondir="$(get_bashcompdir)"
}

src_install() {
	emake install DESTDIR="${D}"

	prune_libtool_files
}
