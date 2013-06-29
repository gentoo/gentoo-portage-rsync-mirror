# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mediastreamer-bcg729/mediastreamer-bcg729-1.0.0.ebuild,v 1.8 2013/06/29 19:23:48 ago Exp $

EAPI=4

MY_P="bcg729-${PV}"

DESCRIPTION="Backported G729 implementation for Linphone"
HOMEPAGE="http://www.linphone.org"
SRC_URI="mirror://nongnu/linphone/plugins/sources/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/mediastreamer-2.8.2
	>=net-libs/ortp-0.16.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure(){
	# strict = -Werror
	econf \
		--disable-static \
		--disable-strict
}
