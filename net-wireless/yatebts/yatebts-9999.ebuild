# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/yatebts/yatebts-9999.ebuild,v 1.1 2014/04/28 02:46:36 zx2c4 Exp $

EAPI=5

inherit subversion autotools

DESCRIPTION="The Yate GSM base station"
HOMEPAGE="http://www.yatebts.com/"
ESVN_REPO_URI="http://voip.null.ro/svn/yatebts/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="rad1 usrp1 uhd bladerf sse3 sse4_1"

RDEPEND="
	net-voip/yate[gsm]
	uhd? ( net-wireless/uhd )
	virtual/libusb:1"
DEPEND="virtual/pkgconfig ${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable rad1) \
		$(use_enable usrp1) \
		$(use_enable uhd) \
		$(use_enable bladerf) \
		$(use_enable sse3) \
		$(use_enable sse4_1 sse41)

}
