# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrmanager/vdr-vdrmanager-0.8.ebuild,v 1.2 2012/12/16 20:22:17 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1130" # every bump, new version

DESCRIPTION="VDR Plugin: allows remote programming VDR using VDR-Manager running on Android devices"
HOMEPAGE="http://projects.vdr-developer.org/projects/vdr-manager/wiki"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="-stream"

DEPEND=">=media-video/vdr-1.5.7"
RDEPEND="stream? ( media-plugins/vdr-streamdev[server] )"

S="${WORKDIR}/${P}"

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	einfo "Add a password to /etc/conf.d/vdr.vdrmanager"
}
