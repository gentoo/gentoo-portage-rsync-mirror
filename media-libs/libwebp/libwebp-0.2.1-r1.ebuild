# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwebp/libwebp-0.2.1-r1.ebuild,v 1.1 2013/03/13 19:08:18 ssuominen Exp $

EAPI=5
inherit eutils multilib-minimal

DESCRIPTION="A lossy image compression format"
HOMEPAGE="http://code.google.com/p/webp/"
SRC_URI="http://webp.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE="experimental static-libs"

RDEPEND="media-libs/libpng:0=
	media-libs/tiff:0=
	virtual/jpeg"
DEPEND="${RDEPEND}"

ECONF_SOURCE=${S}

multilib_src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable experimental) \
		--enable-experimental-libwebpmux
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	prune_libtool_files
	dodoc AUTHORS ChangeLog doc/*.txt NEWS README{,.mux}
}
