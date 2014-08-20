# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Crypt_GPG/PEAR-Crypt_GPG-1.3.2.ebuild,v 1.5 2014/08/20 11:30:18 armin76 Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="GNU Privacy Guard (GnuPG)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ~sparc x86"
IUSE=""
DEPEND=">=dev-lang/php-5.2.1"
RDEPEND="${DEPEND}
	app-crypt/gnupg"
