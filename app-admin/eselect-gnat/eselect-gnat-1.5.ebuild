# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-gnat/eselect-gnat-1.5.ebuild,v 1.3 2014/08/10 01:37:39 patrick Exp $

inherit eutils

DESCRIPTION="gnat module for eselect"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"

IUSE=""
RDEPEND=">=app-admin/eselect-1.2.5"

MODULEDIR="/usr/share/eselect/modules"

# NOTE!!
# This path is duplicated in gnat-eselect module,
# adjust in both locations!
LIBDIR="/usr/share/gnat/lib"

src_install() {
	dodir ${MODULEDIR}
	insinto ${MODULEDIR}
	newins "${FILESDIR}"/gnat.eselect-${PV} gnat.eselect
	dodir ${LIBDIR}
	insinto ${LIBDIR}
	# !ATTN!
	# Make sure to adjust version of installed file to a proper one if there is
	# a change!
	newins "${FILESDIR}"/gnat-common-1.4-r1.bash gnat-common.bash
}
