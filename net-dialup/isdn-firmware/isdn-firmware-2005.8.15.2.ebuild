# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn-firmware/isdn-firmware-2005.8.15.2.ebuild,v 1.4 2014/04/30 18:41:10 ulm Exp $

inherit rpm versionator

SUSE_RELEASE="SL-10.0-OSS"

MY_PN="i4lfirm"
MY_PV="$(get_version_component_range 1-3)"
MY_PP="$(get_version_component_range 4)"
MY_P="${MY_PN}-${MY_PV}-${MY_PP}"

DESCRIPTION="ISDN firmware for active ISDN cards (AVM, Eicon, etc.)"
HOMEPAGE="http://www.isdn4linux.de/"
SRC_URI="mirror://opensuse/distribution/${SUSE_RELEASE}/inst-source/suse/i586/${MY_P}.i586.rpm"

LICENSE="freedist"		#446158
SLOT="0"
KEYWORDS="amd64 ppc x86"

S="${WORKDIR}/lib/firmware/isdn"

src_install() {
	insinto /lib/firmware
	insopts -m 0644
	doins *
}
