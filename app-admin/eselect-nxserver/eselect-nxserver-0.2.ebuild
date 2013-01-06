# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-nxserver/eselect-nxserver-0.2.ebuild,v 1.1 2009/11/07 08:52:02 voyageur Exp $

DESCRIPTION="Manages configuration of NX servers"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI="mirror://gentoo/nxserver.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/nxserver.eselect-${PVR}" nxserver.eselect || die "failed to install"
}
