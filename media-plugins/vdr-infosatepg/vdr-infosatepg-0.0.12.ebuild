# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-infosatepg/vdr-infosatepg-0.0.12.ebuild,v 1.1 2013/11/26 20:36:23 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1098" # every bump, new version!

DESCRIPTION="VDR Plugin: Reads the contents of infosat and writes the data into the EPG."
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-infosatepg"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-2.0"
RDEPEND="${DEPEND}"
