# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Crypt_GPG/PEAR-Crypt_GPG-1.3.2.ebuild,v 1.1 2011/10/02 11:36:59 olemarkus Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="GNU Privacy Guard (GnuPG)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-lang/php-5.2.1"
RDEPEND="${DEPEND}
	app-crypt/gnupg"
