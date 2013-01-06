# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/get_flash_videos/get_flash_videos-1.23-r1.ebuild,v 1.4 2010/11/15 13:14:36 hwoarang Exp $

EAPI=2
inherit perl-module

DESCRIPTION="Downloads videos from various Flash-based video hosting sites"
HOMEPAGE="http://code.google.com/p/get-flash-videos/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-perl/WWW-Mechanize
	perl-core/Module-CoreList
	dev-perl/HTML-TokeParser-Simple"
DEPEND="${RDEPEND}
	dev-perl/UNIVERSAL-require
	test? ( media-video/rtmpdump
		dev-perl/Tie-IxHash
		dev-perl/XML-Simple
		dev-perl/Crypt-Rijndael
		dev-perl/Data-AMF
		perl-core/IO-Compress )"

SRC_TEST="do"

S="${WORKDIR}/monsieurvideo-get-flash-videos-9897240"
SRC_TEST="do"
mymake="default ${PN}.1"
myinst="DESTDIR=${D}"

src_prepare() {
	sed -i -e 's#^check:#test:#' Makefile || die
	# remove failling test because of missing locales
	rm t/utils.t
}

pkg_postinst() {
	elog "Downloading videos from RTMP server requires the following packages :"
	elog "	media-video/rtmpdump"
	elog "	dev-perl/Tie-IxHash"
	elog "Others optional dependencies :"
	elog "	dev-perl/XML-Simple"
	elog "	dev-perl/Crypt-Rijndael"
	elog "	dev-perl/Data-AMF"
	elog "	perl-core/IO-Compress"
}
