# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-2.1.3-r1.ebuild,v 1.4 2013/04/10 20:13:29 ssuominen Exp $

EAPI=5

inherit autotools eutils gnome2-utils

DESCRIPTION="A graphical user interface to the Apple productline"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="aac clutter curl cdr flac gstreamer mp3 vorbis webkit"

COMMON_DEPEND="
	>=dev-libs/gdl-3.6:3
	>=dev-libs/glib-2.28.5
	>=dev-libs/libxml2-2.7.7
	>=dev-util/anjuta-2.91
	>=media-libs/libgpod-0.7.0
	>=media-libs/libid3tag-0.15
	>=x11-libs/gtk+-3.0.8:3
	aac? ( media-libs/faad2 )
	clutter? ( media-libs/clutter-gtk:1.0 )
	curl? ( >=net-misc/curl-7.10 )
	cdr? (
		>=app-cdr/brasero-3
		media-libs/musicbrainz:3
		)
	flac? ( media-libs/flac )
	gstreamer? ( >=media-libs/gst-plugins-base-0.10.25:0.10 )
	mp3? ( media-sound/lame )
	vorbis? (
		media-libs/libvorbis
		media-sound/vorbis-tools
		)
	webkit? ( >=net-libs/webkit-gtk-1.3:3 )"
RDEPEND="${COMMON_DEPEND}
	gstreamer? ( media-plugins/gst-plugins-meta:0.10 )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	media-libs/gstreamer:0.10
	sys-devel/flex
	sys-devel/gettext
	virtual/os-headers
	virtual/pkgconfig"
# media-libs/gstreamer is always required for gst-element-check-0.10.m4 and
# eautoreconf

src_prepare() {
	# Make sure SLOT="4" is not used. Everyone should move from "3" to "5" directly.
	sed -i -e '/PKG_CHECK_MODULES/s:libmusicbrainz4:&sLoT4iSdEpReCaTeD:' configure.ac || die

	# /path/to/install: '/path/to/app-pda/gtkpod-2.1.2_beta2/image/usr/share/gtkpod/data/rhythmbox.gep’: File exists
	sed -i -e '/^dist_profiles_DATA/s:=.*:=:' plugins/sjcd/data/Makefile.am || die

	sed -i -e 's:python:python2:' scripts/sync-palm-jppy.py || die

	epatch \
		"${FILESDIR}"/${P}-gdl-3.6.patch \
		"${FILESDIR}"/${P}-gold.patch
	eautoreconf
}

src_configure() {
	export GST_INSPECT=true #420279

	econf \
		--disable-static \
		$(use_enable webkit plugin-coverweb) \
		$(use_enable clutter plugin-clarity) \
		$(use_enable gstreamer plugin-media-player) \
		$(use_enable cdr plugin-sjcd) \
		$(use_with curl) \
		$(use_with vorbis ogg) \
		$(use_with flac) \
		$(use_with aac mp4)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF}/html \
		figuresdir=/usr/share/doc/${PF}/html/figures \
		install

	prune_libtool_files --all

	dodoc AUTHORS ChangeLog NEWS README TODO TROUBLESHOOTING
	rm -f "${ED}"/usr/share/gtkpod/data/{AUTHORS,COPYING} || die
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
