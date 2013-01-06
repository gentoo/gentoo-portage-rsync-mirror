# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR_Info/PEAR-PEAR_Info-1.9.2-r2.ebuild,v 1.1 2012/03/05 08:33:53 olemarkus Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Show Information about your PEAR install and its packages"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE="minimal"

DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
		dev-php/PEAR-Console_Getargs"
