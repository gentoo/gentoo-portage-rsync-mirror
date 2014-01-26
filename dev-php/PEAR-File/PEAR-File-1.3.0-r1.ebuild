# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File/PEAR-File-1.3.0-r1.ebuild,v 1.9 2014/01/26 18:29:47 olemarkus Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Common file and directory routines"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

RDEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
