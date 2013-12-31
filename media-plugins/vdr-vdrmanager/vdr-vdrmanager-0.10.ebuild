# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrmanager/vdr-vdrmanager-0.10.ebuild,v 1.1 2013/12/27 17:18:28 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1588" # every bump, new version

DESCRIPTION="VDR Plugin: allows remote programming VDR using VDR-Manager running on Android devices"
HOMEPAGE="http://projects.vdr-developer.org/projects/vdr-manager/wiki"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="-stream"

DEPEND=">=media-video/vdr-2"
RDEPEND="stream? ( media-plugins/vdr-streamdev[server] )"

S="${WORKDIR}/${P}"

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	einfo "Add a password to /etc/conf.d/vdr.vdrmanager"
}
