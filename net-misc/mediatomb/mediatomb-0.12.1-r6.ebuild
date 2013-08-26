# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mediatomb/mediatomb-0.12.1-r6.ebuild,v 1.3 2013/08/26 15:31:14 axs Exp $

EAPI=5
inherit autotools eutils linux-info user

DEB_VER="4"
DESCRIPTION="MediaTomb is an open source UPnP MediaServer"
HOMEPAGE="http://www.mediatomb.cc/"
SRC_URI="mirror://sourceforge/mediatomb/${P}.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}-${DEB_VER}.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="+curl debug +exif +ffmpeg id3tag inotify +javascript lastfm libextractor +magic +mp4 mysql +sqlite +taglib thumbnail +zlib"
REQUIRED_USE="
	|| ( mysql sqlite )
	taglib? ( !id3tag ) id3tag? ( !taglib )
	thumbnail? ( ffmpeg !libextractor )
	ffmpeg? ( !libextractor )
	libextractor? ( !ffmpeg !thumbnail )
"

DEPEND="mysql? ( virtual/mysql )
	id3tag? ( media-libs/id3lib )
	javascript? ( >=dev-lang/spidermonkey-1.8.5:0 )
	dev-libs/expat
	taglib? ( media-libs/taglib )
	sqlite? ( >=dev-db/sqlite-3 )
	lastfm? ( >=media-libs/lastfmlib-0.4 )
	exif? ( media-libs/libexif )
	libextractor? ( media-libs/libextractor )
	mp4? ( >=media-libs/libmp4v2-1.9.1_p479:0 )
	ffmpeg? ( virtual/ffmpeg )
	thumbnail? ( media-video/ffmpegthumbnailer[jpeg] )
	curl? ( net-misc/curl )
	magic? ( sys-apps/file )
	sys-apps/util-linux
	zlib? ( sys-libs/zlib )
	virtual/libiconv"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~INOTIFY_USER"

pkg_setup() {
	enewgroup mediatomb
	enewuser mediatomb -1 -1 /dev/null mediatomb
}

src_prepare() {
	local p dd="${WORKDIR}"/debian/patches
	sed -i -r '/^[-+]{3} /s:[.][.]/::' "${dd}"/* || die
	for p in $(<"${dd}"/series) ; do
		epatch "${dd}"/${p}
	done
	epatch "${FILESDIR}"/${P}-libmp4v2.patch
	epatch "${FILESDIR}"/${P}-system-uuid.patch #270830
	if has_version "~dev-lang/spidermonkey-1.8.7" ; then
		epatch "${FILESDIR}"/${P}-mozjs187.patch #435394
	fi
	epatch "${FILESDIR}"/${P}-libextractor.patch #435394
	epatch "${FILESDIR}"/${P}-inotify-hard-links.patch
	epatch "${FILESDIR}"/${P}-thumb-cache.patch
	epatch "${FILESDIR}"/${P}-libav9.patch
	epatch "${FILESDIR}"/${P}-avformatcontext-pointer.patch #446922
	epatch "${FILESDIR}"/${P}-system-ar.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable curl) $(use_enable curl youtube) \
		$(use_enable debug tombdebug) \
		$(use_enable exif libexif) \
		$(use_enable ffmpeg) \
		$(use_enable id3tag id3lib) \
		$(use_enable inotify) \
		$(use_enable javascript libjs) \
		$(use_enable lastfm lastfmlib) \
		$(use_enable libextractor) \
		$(use_enable magic libmagic) \
		$(use_enable mp4 libmp4v2) \
		$(use_enable mysql) \
		$(use_enable sqlite sqlite3) \
		$(use_enable taglib) \
		$(use_enable thumbnail ffmpegthumbnailer) \
		$(use_enable zlib) \
		--enable-external-transcoding \
		--enable-protocolinfo-extension
}

src_install() {
	default

	newinitd "${FILESDIR}"/${PN}-0.12.1.initd ${PN}
	use mysql || sed -i -e "/use mysql/d" "${ED}"/etc/init.d/${PN}
	newconfd "${FILESDIR}"/${PN}-0.12.0.confd ${PN}

	insinto /etc/mediatomb
	newins "${FILESDIR}/${PN}-0.12.0.config" config.xml
	fperms 0600 /etc/mediatomb/config.xml
	fowners mediatomb:mediatomb /etc/mediatomb/config.xml

	keepdir /var/lib/mediatomb
	fowners mediatomb:mediatomb /var/lib/mediatomb
}

pkg_postinst() {
	if use mysql ; then
		elog "MediaTomb has been built with MySQL support and needs"
		elog "to be configured before being started."
		elog "For more information, please consult the MediaTomb"
		elog "documentation: http://mediatomb.cc/pages/documentation"
		elog
	fi

	elog "To configure MediaTomb edit:"
	elog "/etc/mediatomb/config.xml"
	elog
	elog "The MediaTomb web interface can be reached at (after the service is started):"
	elog "http://localhost:49152/"
}
