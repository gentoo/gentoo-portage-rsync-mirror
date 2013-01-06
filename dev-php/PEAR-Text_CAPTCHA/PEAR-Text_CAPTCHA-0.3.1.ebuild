# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Text_CAPTCHA/PEAR-Text_CAPTCHA-0.3.1.ebuild,v 1.2 2007/12/06 00:53:55 jokey Exp $

inherit php-pear-r1

DESCRIPTION="Generation of CAPTCHAs."
LICENSE="PHP-3 BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="dev-php/PEAR-Text_Password
	!minimal? ( dev-php/PEAR-Numbers_Words
		    dev-php/PEAR-Text_Figlet
		    dev-php/PEAR-Image_Text )"
