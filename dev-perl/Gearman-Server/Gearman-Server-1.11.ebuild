# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Server/Gearman-Server-1.11.ebuild,v 1.1 2010/03/27 21:43:16 robbat2 Exp $

MODULE_AUTHOR=DORMANDO
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
