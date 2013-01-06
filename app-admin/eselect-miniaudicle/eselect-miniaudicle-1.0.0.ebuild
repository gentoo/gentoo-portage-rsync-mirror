# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-miniaudicle/eselect-miniaudicle-1.0.0.ebuild,v 1.1 2009/08/09 14:18:05 cedk Exp $

DESCRIPTION="Manages the /usr/bin/miniAudicle symlink"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/miniaudicle.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.6"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/miniaudicle.eselect-${PVR}" miniaudicle.eselect || die
}
