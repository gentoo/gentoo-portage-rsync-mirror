# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmp3splt/libmp3splt-0.8.2.ebuild,v 1.2 2013/05/03 00:11:47 sping Exp $

EAPI=4
inherit versionator autotools eutils multilib

DESCRIPTION="a library for mp3splt to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN:3}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc pcre"

RDEPEND="media-libs/libmad
	media-libs/libvorbis
	media-libs/libogg
	media-libs/libid3tag
	pcre? ( dev-libs/libpcre )"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.8.3.1 media-gfx/graphviz )
	sys-apps/findutils"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7-libltdl.patch
	epatch "${FILESDIR}"/${P}-automake-1.13.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable pcre) \
		$(use_enable doc doxygen_doc) \
		--docdir=/usr/share/doc/${PF} \
		--disable-optimise \
		--disable-cutter  # TODO package cutter <http://cutter.sourceforge.net/>
}

src_install() {
	default
	use	doc && docompress -x /usr/share/doc/${PF}/doxygen/${PN}_ico.svg

	dodoc AUTHORS ChangeLog LIMITS NEWS README TODO

	find "${D}"/usr -name '*.la' -delete
}
