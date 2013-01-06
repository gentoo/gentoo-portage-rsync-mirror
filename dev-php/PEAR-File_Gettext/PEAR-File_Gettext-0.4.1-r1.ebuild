# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_Gettext/PEAR-File_Gettext-0.4.1-r1.ebuild,v 1.7 2012/01/29 15:08:52 armin76 Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="GNU Gettext file parser."

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
