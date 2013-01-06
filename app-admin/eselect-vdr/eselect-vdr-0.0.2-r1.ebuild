# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-vdr/eselect-vdr-0.0.2-r1.ebuild,v 1.2 2009/03/12 18:59:07 zzam Exp $

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

	dosym /usr/bin/eselect /usr/bin/vdr-plugin-config
}
