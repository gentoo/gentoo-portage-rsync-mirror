# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-4.9.3.ebuild,v 1.4 2012/11/30 16:39:34 ago Exp $

EAPI=4

KMNAME="kde-baseapps"
inherit kde4-meta pax-utils

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	x11-libs/libXt
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep konqueror)
"

KMEXTRACTONLY="
	konqueror/settings/
"

src_install() {
	kde4-base_src_install

	# bug 419513
	pax-mark m "${ED}"/usr/bin/nspluginviewer
}
