# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Text_CAPTCHA/PEAR-Text_CAPTCHA-0.5.0.ebuild,v 1.2 2014/08/10 20:55:43 slyfox Exp $

EAPI=5

inherit php-pear-r1

DESCRIPTION="Generation of CAPTCHAs"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND=">=dev-php/PEAR-Text_Password-1.1.1
	dev-lang/php[gd,truetype]
	!minimal? ( dev-php/PEAR-Numbers_Words
		    dev-php/PEAR-Text_Figlet
		    >=dev-php/PEAR-Image_Text-0.7.0 )"
