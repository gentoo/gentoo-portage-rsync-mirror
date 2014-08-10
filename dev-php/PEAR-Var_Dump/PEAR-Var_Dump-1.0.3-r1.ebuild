# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Var_Dump/PEAR-Var_Dump-1.0.3-r1.ebuild,v 1.2 2014/08/10 20:57:15 slyfox Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Provides methods for dumping structured information about a variable"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
