# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phptal/phptal-1.2.1.ebuild,v 1.1 2011/03/05 09:38:39 olemarkus Exp $

EAPI="2"
inherit depend.php

MY_P="PHPTAL-${PV}"
DESCRIPTION="A templating engine for PHP5 that implements Zope Page Templates syntax"
HOMEPAGE="http://phptal.org/"
SRC_URI="http://phptal.org/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

need_php_by_category

src_install() {
	has_php

	insinto /usr/share/php5/${PN}
	doins -r PHPTAL
	doins PHPTAL.php phptal_lint.php

	dodoc-php README
}
