# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Server/Gearman-Server-1.110.0.ebuild,v 1.1 2011/08/30 15:11:52 tove Exp $

EAPI=4

MODULE_AUTHOR=DORMANDO
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="Gearman distributed job system - worker/client connector"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-perl/Danga-Socket-1.57
	>=dev-perl/Gearman-1.07"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/$PN-1.09-Use-saner-name-in-process-listing.patch" )

src_install() {
	perl-module_src_install
	newinitd "${FILESDIR}"/gearmand-init.d-1.09 gearmand
	newconfd "${FILESDIR}"/gearmand-conf.d-1.09 gearmand
}
