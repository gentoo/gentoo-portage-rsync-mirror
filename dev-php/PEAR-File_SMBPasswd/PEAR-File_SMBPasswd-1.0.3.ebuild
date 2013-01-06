# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_SMBPasswd/PEAR-File_SMBPasswd-1.0.3.ebuild,v 1.7 2012/02/12 14:43:24 armin76 Exp $

EAPI="2"
inherit php-pear-r1

DESCRIPTION="Class for managing SAMBA style password files."
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND="|| ( <dev-lang/php-5.3[mhash] >=dev-lang/php-5.3 )
		>=dev-php/PEAR-Crypt_CHAP-1.0.0"
