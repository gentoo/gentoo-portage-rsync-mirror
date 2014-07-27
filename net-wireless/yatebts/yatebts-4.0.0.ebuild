# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/yatebts/yatebts-4.0.0.ebuild,v 1.2 2014/07/27 21:44:56 zerochaos Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="The Yate GSM base station"
HOMEPAGE="http://www.yatebts.com/"
ESVN_REPO_URI="http://voip.null.ro/svn/yatebts/trunk"

LICENSE="GPL-2"
SLOT="0"
IUSE="rad1 usrp1 uhd bladerf sse3 sse4_1"

RDEPEND="
	>=net-voip/yate-5.4.0[gsm]
	uhd? ( net-wireless/uhd )
	virtual/libusb:1"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~x86"
	SRC_URI="http://yate.null.ro/tarballs/${PN}4/yate-bts-${PV}-1.tar.gz"
	S="${WORKDIR}/yate-bts"
fi

src_prepare() {
	epatch "${FILESDIR}"/${P}-dont-mess-with-cflags.patch
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
