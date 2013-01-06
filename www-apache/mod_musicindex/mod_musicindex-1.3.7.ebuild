# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_musicindex/mod_musicindex-1.3.7.ebuild,v 1.2 2012/10/16 05:25:22 patrick Exp $

EAPI=4

inherit apache-module

DESCRIPTION="mod_musicindex allows nice displaying of directories containing music files"
HOMEPAGE="http://www.parisc-linux.org/~varenet/musicindex/"
#SRC_URI="http://www.parisc-linux.org/~varenet/musicindex/${P}.tar.gz"  # currently down :-/
SRC_URI="mirror://debian/pool/main/liba/libapache-mod-musicindex/libapache-mod-musicindex_${PV}.orig.tar.gz"
S="${WORKDIR}/libapache-mod-musicindex-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mp3 +mp4 +flac +vorbis mysql"

DEPEND="mp3? ( media-libs/libmad )
	mp4? ( media-libs/libmp4v2:0 )
	flac? ( media-libs/flac )
	vorbis? ( media-libs/liboggz )
	mysql? ( virtual/mysql )"
RDEPEND="${DEPEND}
	sys-devel/libtool"

APACHE2_MOD_CONF="50_${PN}"
APACHE2_MOD_DEFINE="MUSICINDEX"
DOCFILES="AUTHORS BUGS ChangeLog README UPGRADING"

need_apache2_2

src_configure() {
	econf \
		$(use_enable mp3) \
		$(use_enable mp4) \
		$(use_enable flac) \
		$(use_enable vorbis) \
		$(use_enable mysql mysqlcache)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	apache-module_src_install
}
