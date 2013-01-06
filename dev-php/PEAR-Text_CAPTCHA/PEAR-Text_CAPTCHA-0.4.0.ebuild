# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Text_CAPTCHA/PEAR-Text_CAPTCHA-0.4.0.ebuild,v 1.4 2010/08/12 08:49:54 maekke Exp $

EAPI=2

inherit php-pear-r1

DESCRIPTION="Generation of CAPTCHAs."
LICENSE="BSD"
SLOT="0"

KEYWORDS="amd64 x86"
IUSE="minimal"

RDEPEND="dev-php/PEAR-Text_Password
	dev-lang/php[truetype]
	|| ( dev-lang/php[gd] dev-lang/php[gd-external] )
	!minimal? ( dev-php/PEAR-Numbers_Words
		    dev-php/PEAR-Text_Figlet
		    dev-php/PEAR-Image_Text )"
