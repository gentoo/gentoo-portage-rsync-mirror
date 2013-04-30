# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/babl/babl-9999.ebuild,v 1.2 2013/04/30 20:37:44 sping Exp $

EAPI=4

VALA_MIN_API_VERSION=0.14
VALA_USE_DEPEND=vapigen
EGIT_REPO_URI="git://git.gnome.org/babl"

inherit vala autotools eutils git-2

DESCRIPTION="A dynamic, any to any, pixel format conversion library"
HOMEPAGE="http://www.gegl.org/babl/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="altivec +introspection sse mmx vala"

RDEPEND="introspection? ( >=dev-libs/gobject-introspection-0.10 )"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-2.2
	vala? ( $(vala_depend) )
	virtual/pkgconfig"

src_prepare() {
	# fix compilation on OSX, can be dropped on next release:
	# http://mail.gnome.org/archives/commits-list/2012-April/msg02589.html
	sed -i -e 's/values\.h/limits.h/' babl/babl-palette.c || die
	eautoreconf

	use vala && vala_src_prepare
}

src_configure() {
	# Automagic rsvg support is just for website generation we do not call,
	#     so we don't need to fix it
	# w3m is used for dist target thus no issue for us that it is automagically
	#     detected
	econf \
		--disable-static \
		--disable-maintainer-mode \
		$(use_enable altivec) \
		$(use_enable introspection) \
		$(use_enable mmx) \
		$(use_enable sse) \
		$(use_with vala)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
	dodoc AUTHORS MAINTAINERS NEWS TODO
}
