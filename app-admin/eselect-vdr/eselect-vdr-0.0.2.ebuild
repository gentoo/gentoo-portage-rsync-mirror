# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-vdr/eselect-vdr-0.0.2.ebuild,v 1.3 2007/10/05 13:30:38 dertobi123 Exp $

DESCRIPTION="Manages the VDR plugins"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.6"

src_install() {
	insinto /usr/share/eselect/modules
	doins vdr-plugin.eselect || die "Could not install eselect module"
}
