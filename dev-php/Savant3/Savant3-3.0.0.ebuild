# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Savant3/Savant3-3.0.0.ebuild,v 1.2 2012/06/10 12:05:21 mabi Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="The simple PHP template alternative to Smarty."
HOMEPAGE="http://phpsavant.com/yawiki/index.php?area=Savant3"
SRC_URI="http://phpsavant.com/${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="minimal"

DEPEND=""
RDEPEND="!minimal? ( >=dev-php/Savant3-Plugin-Form-0.2.1 )"
