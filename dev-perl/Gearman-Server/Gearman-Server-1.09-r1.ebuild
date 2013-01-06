# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Server/Gearman-Server-1.09-r1.ebuild,v 1.2 2008/09/30 13:15:16 tove Exp $

MODULE_AUTHOR=BRADFITZ
inherit perl-module

DESCRIPTION="Gearman distributed job system - worker/client connector"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-perl/Danga-Socket-1.57
	>=dev-perl/Gearman-1.07
	dev-lang/perl"

mydoc="CHANGES"

PATCHES=( "${FILESDIR}/$PN-1.09-Use-saner-name-in-process-listing.patch" )

src_install() {
	perl-module_src_install
	newinitd "${FILESDIR}"/gearmand-init.d-1.09 gearmand
	newconfd "${FILESDIR}"/gearmand-conf.d-1.09 gearmand
}
