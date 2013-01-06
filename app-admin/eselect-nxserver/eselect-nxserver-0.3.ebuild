# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-nxserver/eselect-nxserver-0.3.ebuild,v 1.1 2012/08/23 12:43:03 voyageur Exp $

EAPI=4

DESCRIPTION="Manages configuration of NX servers"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI="http://dev.gentoo.org/~voyageur/distfiles/nxserver.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3
	!<net-misc/neatx-0.3.1_p59-r4"

S=${WORKDIR}

src_install() {
	insinto /usr/share/eselect/modules
	newins nxserver.eselect-${PVR} nxserver.eselect
}
