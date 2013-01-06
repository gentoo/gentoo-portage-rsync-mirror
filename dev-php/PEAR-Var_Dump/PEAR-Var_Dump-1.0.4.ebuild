# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Var_Dump/PEAR-Var_Dump-1.0.4.ebuild,v 1.1 2011/03/21 08:41:18 olemarkus Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Provides methods for dumping structured information about a variable."

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
