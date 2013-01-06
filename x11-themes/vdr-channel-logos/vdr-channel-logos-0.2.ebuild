# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/vdr-channel-logos/vdr-channel-logos-0.2.ebuild,v 1.5 2010/02/24 14:21:52 ssuominen Exp $

inherit eutils

MY_P=${PN#vdr-channel-}-${PV}

DESCRIPTION="Logos for vdr-skin*"
HOMEPAGE="http://www.vdrskins.org/"
SRC_URI="http://www.vdrskins.org/vdrskins/albums/userpics/10138/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

S=${WORKDIR}/logos

src_install() {
	insinto /usr/share/vdr/channel-logos
	find -maxdepth 1 -name "*.xpm" -print0|xargs -0 cp -a --target="${D}/usr/share/vdr/channel-logos/"
}
