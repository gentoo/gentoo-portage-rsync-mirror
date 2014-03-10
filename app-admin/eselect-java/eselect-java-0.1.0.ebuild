# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-java/eselect-java-0.1.0.ebuild,v 1.6 2014/03/10 17:35:32 johu Exp $

EAPI=5

DESCRIPTION="A set of eselect modules for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="http://dev.gentoo.org/~sera/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="
	!app-admin/eselect-ecj
	!app-admin/eselect-maven
	!<dev-java/java-config-2.2
	app-admin/eselect"
# https://bugs.gentoo.org/show_bug.cgi?id=315229
PDEPEND=">=virtual/jre-1.5"
